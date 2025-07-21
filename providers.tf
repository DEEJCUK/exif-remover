provider "aws" {
  region  = "eu-west-1"
  profile = "deploy"
  default_tags {
    tags = {
      Project     = var.project
      Owner       = var.owner
      Environment = var.environment
    }
  }
}
