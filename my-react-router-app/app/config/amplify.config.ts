const userPoolId = import.meta.env.VITE_USER_POOL_ID;
const awsRegion = import.meta.env.VITE_AWS_REGION;
const userPoolClientId = import.meta.env.VITE_USER_POOL_CLIENT_ID;
const identityPoolId = import.meta.env.VITE_IDENTITY_POOL_ID;

export const amplifyConfig = {
  "auth": {
    "user_pool_id": userPoolId,
    "aws_region": awsRegion,
    "user_pool_client_id": userPoolClientId,
    "identity_pool_id": identityPoolId,
    "mfa_methods": [],
    "standard_required_attributes": ["email"],
    "username_attributes": ["email"],
    "user_verification_types": ["email"],
    "mfa_configuration": "NONE",
    "password_policy": {
      "min_length": 8,
      "require_lowercase": true,
      "require_numbers": true,
      "require_symbols": true,
      "require_uppercase": true
    },
    "oauth": {
      "identity_providers": ["GOOGLE"],
      "redirect_sign_in_uri": ["http://localhost:5173/callback"],
      "redirect_sign_out_uri": ["http://localhost:5173"],
      "response_type": "code",
      "scopes": [
        "phone",
        "email",
        "openid",
        "profile",
        "aws.cognito.signin.user.admin"
      ],
      "domain": "ikoamu-suburi.auth.ap-northeast-1.amazoncognito.com"
    },
    "unauthenticated_identities_enabled": true
  },
  "version": "1.2"
}
