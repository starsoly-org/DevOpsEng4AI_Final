resource "aws_cloudwatch_dashboard" "model_dashboard" {
  dashboard_name = "${var.function_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0, y = 0, width = 12, height = 6,
        properties = {
          title = "Lambda Invocations",
          metrics = [
            [ "AWS/Lambda", "Invocations", "FunctionName", var.function_name ]
          ],
          period = 300,
          stat = "Sum",
          region = var.aws_region,
          view = "timeSeries"
        }
      },
      {
        type = "metric",
        x = 0, y = 6, width = 12, height = 6,
        properties = {
          title = "Lambda Errors",
          metrics = [
            [ "AWS/Lambda", "Errors", "FunctionName", var.function_name ]
          ],
          period = 300,
          stat = "Sum",
          region = var.aws_region,
          view = "timeSeries"
        }
      },
      {
        type = "metric",
        x = 0, y = 12, width = 12, height = 6,
        properties = {
          title = "Lambda Duration",
          metrics = [
            [ "AWS/Lambda", "Duration", "FunctionName", var.function_name ]
          ],
          period = 300,
          stat = "Average",
          region = var.aws_region,
          view = "timeSeries"
        }
      }
    ]
  })
}