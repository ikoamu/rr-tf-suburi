data "aws_iam_policy_document" "ikoamu_suburi" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ikoamu_suburi" {
  name               = "ikoamu_suburi"
  assume_role_policy = data.aws_iam_policy_document.ikoamu_suburi.json
}

resource "aws_cloudwatch_log_group" "ikoamu_suburi" {
  name              = "/aws/lambda/ikoamu_suburi"
  retention_in_days = 30
}

resource "aws_iam_policy" "function_logging_policy" {
  name = "function_logging_policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Effect : "Allow",
        Action : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource : "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "function_logging_policy_attachment" {
  role       = aws_iam_role.ikoamu_suburi.id
  policy_arn = aws_iam_policy.function_logging_policy.arn
}
