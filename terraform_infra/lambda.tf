resource "aws_lambda_function" "ai_model" {
  function_name = var.function_name
  package_type  = "Image"
  image_uri     = var.image_uri
  publish       = true
  role          = aws_iam_role.lambda_exec.arn
  timeout      = 60
  memory_size  = 1024
}

resource "aws_lambda_alias" "prod" {
  name             = "prod"
  function_name    = aws_lambda_function.ai_model.function_name
  function_version = aws_lambda_function.ai_model.version
}