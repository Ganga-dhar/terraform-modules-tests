variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "logging_bucket" {
  type    = string
  default = null
}

variable "expiration_days" {
  type    = number
  default = 365
}

