
provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "terraform-ec2" {
  # ami = "ami-0f1dcc636b69a6438"
  ami = var.ami_id
  # instance_type = "t2.micro"
  instance_type = var.instance_type
  # count = 2
  count = var.instance_count

  tags = {
    Name = var.instance_name
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-aayush-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_security_group" "sg_example" {
  name = "terraform_allow_group"
  description = "Allowing traffic to instances"

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Allowing the traffic via terraform config"
  }
}