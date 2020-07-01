# transcribeを呼び出すlambdaがCloudWatchへログを書き出すためのpolicy
resource "aws_iam_policy" "lambda_logging_policy" {
  name        = "lambda_logging_policy"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# lambdaがtranscribeを実行できるようにするpolicy
resource "aws_iam_policy" "lambda_execute_transcribe_policy" {
  name = "lambda_execute_transcribe_policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "transcribe:*",
            "Resource": "*"
        }
    ]
}
EOF
}

# transcribeがs3へファイルを読み書きするためのpolicy
resource "aws_iam_policy" "transcribe_access_s3_policy" {
  name        = "transcribe_access_s3_policy"
  description = "IAM policy for transcribe access s3"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.input_bucket_name}/*",
                "arn:aws:s3:::${var.output_bucket_name}/*"
            ]
        }
    ]
}
EOF
}
