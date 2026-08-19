mock_provider "aws" {}

variables {
  bucket_name = "terraform-test-bucket-12345"
  environment = "test"
}

run "validate_s3_configuration" {

  command = plan

  assert {
    condition     = aws_s3_bucket.this.bucket == "terraform-test-bucket-12345"
    error_message = "S3 bucket name is incorrect"
  }

  assert {
    condition     = aws_s3_bucket_versioning.this.versioning_configuration[0].status == "Enabled"
    error_message = "S3 versioning is not enabled"
  }

  assert {
    condition     = aws_s3_bucket_public_access_block.this.block_public_acls == true
    error_message = "Public ACLs are not blocked"
  }

  assert {
    condition     = aws_s3_bucket_public_access_block.this.block_public_policy == true
    error_message = "Public bucket policies are not blocked"
  }
}