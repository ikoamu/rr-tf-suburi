resource "terraform_data" "ikoamu_suburi" {
  triggers_replace = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "cd ${path.module}/../../../my-react-router-app && npm i && npm run build"
  }

  # provisioner "local-exec" {
  # TODO: 余計なファイルをzipに入れないようにする
  # }
}

data "archive_file" "ikoamu_suburi" {
  depends_on  = [terraform_data.ikoamu_suburi]
  type        = "zip"
  source_dir  = "../my-react-router-app"
  output_path = "../archive.zip"
}

resource "aws_lambda_function" "ikoamu_suburi" {
  filename         = data.archive_file.ikoamu_suburi.output_path
  function_name    = "ikoamu_suburi"
  handler          = "run.sh"
  role             = var.role_arn
  source_code_hash = data.archive_file.ikoamu_suburi.output_base64sha256
  runtime          = "nodejs20.x"
  architectures    = ["x86_64"]
  timeout          = 29
  memory_size      = 1024

  layers = [
    "arn:aws:lambda:${var.region}:753240598075:layer:LambdaAdapterLayerX86:24"
  ]

  environment {
    variables = {
      AWS_LAMBDA_EXEC_WRAPPER = "/opt/bootstrap"
      PORT                    = "3000"
    }
  }
}
