resource "aws_apigatewayv2_api" "predict_api" {
  name          = "predict-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id             = aws_apigatewayv2_api.predict_api.id
  integration_type   = "AWS_PROXY"
  integration_uri = "arn:aws:lambda:${var.aws_region}:060795941483:function:${aws_lambda_function.ai_model.function_name}:${aws_lambda_alias.prod.name}"
  integration_method = "ANY"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "predict_route" {
  api_id    = aws_apigatewayv2_api.predict_api.id
  route_key = "GET /predict"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.predict_api.id
  name        = "default"
  auto_deploy = true
}

resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = "AllowInvokeFromAPIGW"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ai_model.function_name}:${aws_lambda_alias.prod.name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.predict_api.execution_arn}/*/*"
}

output "predict_api_endpoint" {
  value = "${aws_apigatewayv2_api.predict_api.api_endpoint}/predict"
}