terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "s3" {
  source = "./modules/s3"
}

module "iam" {
  source = "./modules/iam"
}

module "lambda" {
  source       = "./modules/lambda"
  region       = var.region
  asset_bucket = module.s3.ikoamu_suburi_assets_bucket
  role_arn     = module.iam.ikoamu_suburi_role_arn
}

module "apigw" {
  source        = "./modules/apigw"
  function_name = module.lambda.function_name
  invoke_arn    = module.lambda.invoke_arn
}
