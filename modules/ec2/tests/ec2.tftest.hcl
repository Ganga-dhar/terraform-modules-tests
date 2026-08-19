mock_provider "aws" {}

variables {
  ami_id        = "ami-12345678"
  instance_type = "t3.micro"
  name          = "test-ec2"
  environment   = "test"
}

run "validate_ec2_configuration" {

  command = plan

  assert {
    condition     = aws_instance.this.instance_type == "t3.micro"
    error_message = "EC2 instance type is not t3.micro"
  }

  assert {
    condition     = aws_instance.this.tags["Environment"] == "test"
    error_message = "Environment tag is incorrect"
  }

  assert {
    condition     = aws_instance.this.tags["Name"] == "test-ec2"
    error_message = "Name tag is incorrect"
  }
}