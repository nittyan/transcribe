resource "aws_s3_bucket" "input_bucket" {
  bucket = var.input_bucket_name
  acl = "private"
  tags = {
    Created_by = "Terraform"
  }
}

resource "aws_s3_bucket" "output_bucket" {
  bucket = var.output_bucket_name
  acl = "private"
  tags = {
    Created_by = "Terraform"
  }
}

resource "aws_s3_bucket_notification" "s3_object_create_notification" {
  bucket = aws_s3_bucket.input_bucket.id

  lambda_function {
    lambda_function_arn = var.lambda_function_arn
    events = ["s3:ObjectCreated:*"]
  }
}
