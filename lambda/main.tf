resource "aws_lambda_function" "execute_transcribe_function" {
  function_name = "execute_transcribe_function"
  handler = "execute_transcribe.lambda_handler"
  role = var.role_arn
  filename = data.archive_file.zip.output_path
  runtime = "python3.8"
  depends_on = [aws_cloudwatch_log_group.lambda_log_group]
  tags = {
    Created_by = "Terraform"
  }
}

data "archive_file" "zip" {
  type = "zip"
  output_path = "${path.module}/src/function.zip"
  source {
    content = data.template_file.lambda.rendered
    filename = "execute_transcribe.py"
  }
}

data "template_file" "lambda" {
  template = file("${path.module}/src/execute_transcribe.py")
  vars = {
    input_bucket_name = var.input_bucket_name
    output_bucket_name = var.output_bucket_name
  }
}

resource "aws_lambda_permission" "s3_execute_lambda_permission" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.execute_transcribe_function.function_name
  principal = "s3.amazonaws.com"
  source_arn = var.input_bucket_arn
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/execute_transcribe_function"
  retention_in_days = 7
}
