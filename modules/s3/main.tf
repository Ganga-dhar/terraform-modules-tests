resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

##CKV_AWS_145
##Ensure that S3 buckets are encrypted with KMS by default

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

##CKV_AWS_18
##Ensure the S3 bucket has access logging enabled

resource "aws_s3_bucket_logging" "this" {
  count = var.logging_bucket != null ? 1 : 0

  bucket = aws_s3_bucket.this.id

  target_bucket = var.logging_bucket
  target_prefix = "${var.bucket_name}/"
}



##CKV2_AWS_61
##Ensure that an S3 bucket has a lifecycle configuration

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "default-lifecycle"
    status = "Enabled"

    filter {}

    expiration {
      days = 365
    }
  }
}


##CKV2_AWS_61
##Ensure that an S3 bucket has a lifecycle configuration

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "default-lifecycle"
    status = "Enabled"

    filter {}

    expiration {
      days = var.expiration_days
    }
  }
}


##CKV_AWS_144
##Ensure that S3 bucket has cross-region replication enabled

