resource "aws_apigatewayv2_api" "ikoamu_suburi_api" {
  name          = "ikoamu_suburi_api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "ikoamu_suburi_api" {
  api_id      = aws_apigatewayv2_api.ikoamu_suburi_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "ikoamu_suburi_api" {
  api_id                 = aws_apigatewayv2_api.ikoamu_suburi_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "ikoamu_suburi_api" {
  api_id             = aws_apigatewayv2_api.ikoamu_suburi_api.id
  route_key          = "$default"
  authorization_type = "NONE"
  target             = "integrations/${aws_apigatewayv2_integration.ikoamu_suburi_api.id}"
}

resource "aws_lambda_permission" "ikoamu_suburi_api" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.ikoamu_suburi_api.execution_arn}/*/*"
}
