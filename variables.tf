variable "bucket_a_name" {
  description = "RAW uploads bucket name"
  type        = string
  default     = "platform_raw_uploads"
}

variable "bucket_b_name" {
  description = "EXIF removed bucket name"
  type        = string
  default     = "platform_exif_removed"
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
  default     = "exif_cleaner_platform"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "Platform Exif"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "CI"
}

variable "owner" {
  description = "Resource owner"
  type        = string
  default     = "platform exif team"
}
