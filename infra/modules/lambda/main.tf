resource "aws_lambda_function" "ikoamu_suburi" {
  function_name    = "ikoamu_suburi"
  handler          = "run.sh"
  role             = var.role_arn
  source_code_hash = var.source_code_hash
  runtime          = "nodejs20.x"
  architectures    = ["x86_64"]
  timeout          = 29
  memory_size      = 1024

  s3_bucket = var.archive_bucket
  s3_key    = var.archive_bucket_key

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
