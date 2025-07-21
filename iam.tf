# IAM access keys for users
resource "aws_iam_access_key" "user_a_key" {
  user = aws_iam_user.user_a.name
}

resource "aws_iam_user" "user_a" {
  name = "raw-upload-user"
}

resource "aws_iam_user_policy" "user_a_policy" {
  name = "user_a_rw_bucket_a"
  user = aws_iam_user.user_a.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
        Resource = [aws_s3_bucket.bucket_a.arn, "${aws_s3_bucket.bucket_a.arn}/*"]
      }
    ]
  })
}

resource "aws_iam_access_key" "user_b_key" {
  user = aws_iam_user.user_b.name
}

resource "aws_iam_user" "user_b" {
  name = "removed-exif-user"
}

resource "aws_iam_user_policy" "user_b_policy" {
  name = "user_b_r_bucket_b"
  user = aws_iam_user.user_b.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:ListBucket"]
        Resource = [aws_s3_bucket.bucket_b.arn, "${aws_s3_bucket.bucket_b.arn}/*"]
      }
    ]
  })
}

# Lambda IAM role
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
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

# Lambda policy for S3 access
resource "aws_iam_policy" "lambda_s3_policy" {
  name        = "lambda_s3_rw_policy"
  description = "Allow Lambda to read from Bucket A and write to Bucket B"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:ListBucket"]
        Resource = [aws_s3_bucket.bucket_a.arn, "${aws_s3_bucket.bucket_a.arn}/*"]
      },
      {
        Effect   = "Allow"
        Action   = ["s3:PutObject"]
        Resource = ["${aws_s3_bucket.bucket_b.arn}/*"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_s3_policy.arn
}

# Lambda IAM policy attachment
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}