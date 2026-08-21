resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  ebs_optimized = true
  monitoring    = true

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

resource "aws_iam_role" "ec2" {
  name = "${var.name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.name}-profile"
  role = aws_iam_role.ec2.name
}


resource "aws_instance" "this" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  ebs_optimized        = true
  monitoring           = true
  iam_instance_profile = aws_iam_instance_profile.ec2.name

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}