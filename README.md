
# AWS S3 EXIF Cleaner

Deploys:
- Two S3 buckets: one for raw uploads, one for EXIF-cleaned images
- IAM users with scoped access
- Lambda function to strip EXIF metadata from .jpg files on upload


## Assumptions
- You are already authenticated to AWS (e.g., via CLI or environment variables)
- You have permission to create S3 buckets, Lambda functions, and IAM resources

## Deploy
1. Package Lambda code and dependencies as `lambda-deploy.zip` (see main.py)
2. Place `lambda-deploy.zip` in the project root
3. Run:
   ```sh
   terraform init
   terraform apply
   ```

## What it does
Uploads to bucket A trigger a Lambda that removes EXIF metadata and saves the cleaned image to bucket B, preserving the path.

## Improvements
- this is a POC, if considering deployment, Setup a shared backend (s3) for tf state and split the envs using best practices (Dev,Test,Prod) and paramiterise them
- Follow Terraform best practices by creating reusable modules rather than a flat repo
- Use IAM roles for access control instead of IAM users for better security and scalability
- Add error handling and logging to the Lambda function
- Parameterize bucket names and Lambda settings for flexibility and add Random suffixes
- Add automated tests for the workflow and terraform functions
- If running something like this in a production environment, Add checks in your CI/CD workflow to keep the code readable, secure and following industry standards (trivy, tflint, tf fmt, infracost, SAST, DAST etc)