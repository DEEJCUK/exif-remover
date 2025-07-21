output "bucket_a_name" {
  value = aws_s3_bucket.bucket_a.bucket
}

output "bucket_b_name" {
  value = aws_s3_bucket.bucket_b.bucket
}

output "user_a_name" {
  value = aws_iam_user.user_a.name
}

output "user_b_name" {
  value = aws_iam_user.user_b.name
}

output "lambda_function_name" {
  value = aws_lambda_function.exif_cleaner.function_name
}
