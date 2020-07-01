module "s3" {
  source = "./s3"
  input_bucket_name = local.input_bucket_name
  output_bucket_name = local.output_bucket_name
  lambda_function_arn = module.lambda.function.arn
}

module "iam" {
  source = "./iam"
  input_bucket_name = local.input_bucket_name
  output_bucket_name = local.output_bucket_name
}

module "lambda" {
  source = "./lambda"
  input_bucket_name = local.input_bucket_name
  output_bucket_name = local.output_bucket_name
  input_bucket_arn = module.s3.input_bucket.arn
  role_arn = module.iam.execute_transcribe_role.arn
}