
resource "aws_cognito_user_pool" "ikoamu_suburi" {
  name = "ikoamu_suburi"
}

resource "aws_cognito_user_pool_client" "ikoamu_suburi" {
  name            = "aws_cognito_user_pool_client"
  user_pool_id    = aws_cognito_user_pool.ikoamu_suburi.id
  generate_secret = false
  callback_urls = [
    "http://localhost:5173/callback",
    "${var.api_endpoint}/callback"
  ]
  logout_urls = [
    "http://localhost:5173",
    var.api_endpoint
  ]
  allowed_oauth_flows = ["code"]
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
  ]
  supported_identity_providers = [
    "Google",
    "COGNITO"
  ]
  allowed_oauth_scopes = [
    "aws.cognito.signin.user.admin",
    "email",
    "openid",
    "phone",
    "profile",
  ]
  allowed_oauth_flows_user_pool_client = true
}

resource "aws_cognito_identity_provider" "google" {
  user_pool_id  = aws_cognito_user_pool.ikoamu_suburi.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes = "email"
    client_id        = var.google_client_id
    client_secret    = var.google_client_secret
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}

resource "aws_cognito_user_pool_domain" "ikoamu_suburi" {
  domain       = "ikoamu-suburi"
  user_pool_id = aws_cognito_user_pool.ikoamu_suburi.id
}


resource "aws_cognito_identity_pool" "ikoamu_suburi" {
  identity_pool_name               = "ikoamu_suburi_id_pool"
  allow_unauthenticated_identities = true
  allow_classic_flow               = false

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.ikoamu_suburi.id
    provider_name           = aws_cognito_user_pool.ikoamu_suburi.endpoint
    server_side_token_check = false
  }

  supported_login_providers = {
    "accounts.google.com" = var.google_client_id
  }
}

resource "aws_cognito_identity_pool_roles_attachment" "ikoamu_suburi" {
  identity_pool_id = aws_cognito_identity_pool.ikoamu_suburi.id

  roles = {
    "authenticated"   = var.authenticated_user_role_arn
    "unauthenticated" = var.unauthenticated_user_role_arn
  }
}
