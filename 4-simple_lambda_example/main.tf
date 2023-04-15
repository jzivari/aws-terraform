provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "example" {
  filename         = "lambda.zip"
  function_name    = "example"
  role             = aws_iam_role.example.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.8"
}

resource "aws_iam_role" "example" {
  name = "example-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2019-06-01"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
