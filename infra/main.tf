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
