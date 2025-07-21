# Lambda function
resource "aws_lambda_function" "exif_cleaner" {
  function_name    = "exif_cleaner_platform"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.12"
  filename         = "./lambda-deploy.zip"
  timeout          = 10
  memory_size      = 512
  source_code_hash = filebase64sha256("./lambda-deploy.zip")
  environment {
    variables = {
      BUCKET_B = "090901-platform-exif-removed"
    }
  }
}