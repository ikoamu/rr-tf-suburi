terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "iam" {
  source         = "./modules/iam"
  idp_id         = module.cognito.idp_id
  todo_table_arn = module.dynamodb.todo_table_arn
}

module "s3" {
  source = "./modules/s3"
}

module "lambda" {
  source             = "./modules/lambda"
  region             = var.region
  role_arn           = module.iam.ikoamu_suburi_role_arn
  archive_bucket     = module.s3.archive_bucket
  archive_bucket_key = module.s3.archive_bucket_key
  source_code_hash   = module.s3.archive_source_code_hash
}

module "apigw" {
  source        = "./modules/apigw"
  function_name = module.lambda.function_name
  invoke_arn    = module.lambda.invoke_arn
}

module "cloudwatch" {
  source        = "./modules/cloudwatch"
  function_name = module.lambda.function_name
}

module "cognito" {
  source                        = "./modules/cognito"
  authenticated_user_role_arn   = module.iam.ikoamu_suburi_authenticated_user_role_arn
  unauthenticated_user_role_arn = module.iam.ikoamu_suburi_unauthenticated_user_role_arn
  api_endpoint                  = module.apigw.api_endpoint
  google_client_id              = var.google_client_id
  google_client_secret          = var.google_client_secret
}
