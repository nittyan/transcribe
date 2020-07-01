resource "aws_iam_role" "execute_transcribe_role" {
  name = "execute_transcribe_role"
  tags = {
    Created_by = "Terraform"
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logging_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
  role = aws_iam_role.execute_transcribe_role.name
}

resource "aws_iam_role_policy_attachment" "lambda_execute_transcribe_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_execute_transcribe_policy.arn
  role = aws_iam_role.execute_transcribe_role.name
}

resource "aws_iam_role_policy_attachment" "transcribe_access_s3_policy_attachment" {
  policy_arn = aws_iam_policy.transcribe_access_s3_policy.arn
  role = aws_iam_role.execute_transcribe_role.name
}
