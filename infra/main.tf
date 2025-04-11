terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "iam" {
  source = "./modules/iam"
  idp_id = module.cognito.idp_id
}

module "lambda" {
  source   = "./modules/lambda"
  region   = var.region
  role_arn = module.iam.ikoamu_suburi_role_arn
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
  google_client_id              = var.google_client_id
  google_client_secret          = var.google_client_secret
}
