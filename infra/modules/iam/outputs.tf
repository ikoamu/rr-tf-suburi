output "ikoamu_suburi_role_arn" {
  value = aws_iam_role.ikoamu_suburi.arn
}

output "ikoamu_suburi_authenticated_user_role_arn" {
  value = aws_iam_role.ikoamu_suburi_authenticated_user.arn
}

output "ikoamu_suburi_unauthenticated_user_role_arn" {
  value = aws_iam_role.ikoamu_suburi_unauthenticated_user.arn
}
