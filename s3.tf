resource "aws_s3_bucket" "bucket_a" {
  force_destroy = true
  bucket        = "090901-platform-raw-uploads"
}

resource "aws_s3_bucket" "bucket_b" {
  force_destroy = true
  bucket        = "090901-platform-exif-removed"
}

# S3 event notification to trigger Lambda on .jpg upload
resource "aws_s3_bucket_notification" "bucket_a_notification" {
  bucket = aws_s3_bucket.bucket_a.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.exif_cleaner.arn
    events              = ["s3:ObjectCreated:Put"]
    filter_prefix       = ""
    filter_suffix       = ".jpg"
  }
}

# Allow S3 to invoke Lambda
resource "aws_lambda_permission" "allow_bucket_a" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.exif_cleaner.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket_a.arn
}