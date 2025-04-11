locals {
  app_path     = "${path.module}/../../../my-react-router-app"
  archive_path = "${path.module}/../../../archive"
  key          = "zip/archive.zip"
}

resource "aws_s3_bucket" "lambda_archive" {
  bucket = "ikoamu-suburi-lambda-archive"
}

resource "aws_s3_bucket_versioning" "lambda_archive" {
  bucket = aws_s3_bucket.lambda_archive.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "terraform_data" "ikoamu_suburi" {
  triggers_replace = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "cd ${local.archive_path}/.. && rm -rf archive"
  }

  provisioner "local-exec" {
    command = "cd ${local.app_path} && npm install && npm run build"
  }

  provisioner "local-exec" {
    # ビルド成果物のみをデプロイ用ディレクトリにコピー
    command = <<-EOT
      mkdir -p ${local.archive_path}
      cp ${local.app_path}/package.json ${local.archive_path}
      cp ${local.app_path}/package-lock.json ${local.archive_path}
      cp -r ${local.app_path}/build ${local.archive_path}
      cp ${local.app_path}/package.json ${local.archive_path}
      cp ${local.app_path}/server.js ${local.archive_path}
      cp ${local.app_path}/run.sh ${local.archive_path}
    EOT
  }

  provisioner "local-exec" {
    command = "cd ${local.archive_path} && npm install --omit=dev"
  }
}

data "archive_file" "ikoamu_suburi" {
  depends_on  = [terraform_data.ikoamu_suburi]
  type        = "zip"
  source_dir  = "../archive"
  output_path = "../archive.zip"
}

resource "aws_s3_object" "zip" {
  bucket      = aws_s3_bucket.lambda_archive.bucket
  key         = local.key
  source      = "../archive.zip"
  source_hash = data.archive_file.ikoamu_suburi.output_base64sha256
}
