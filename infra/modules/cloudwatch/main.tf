resource "aws_cloudwatch_log_group" "ikoamu_suburi" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 30
}
