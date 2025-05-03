
provider "aws" {
  region = var.aws_region
}

module "WebServer" {
  source = "./modules/ec2"
  instance_count = 1
  instance_name = "My TF Web Server"

  security_group_name = "Modified security group"
}

# module "WebServer_security" {
#   source = "./modules/ec2"
#   instance_count = 1
#   instance_name = "My TF Web Server"
# }

# resource "aws_instance" "terraform-ec2" {
#   # ami = "ami-062f0cc54dbfd8ef1"
#   ami = var.ami_id
#   # instance_type = "t2.micro"
#   instance_type = var.instance_type
#   # count = 2
#   count = var.instance_count
#   tags = {
#     Name = var.instance_name
#   }
# }

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-aayush-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# resource "aws_security_group" "sg_example" {
#   name = "terraform_allow_group"
#   description = "Allowing traffic to instances"

#   ingress {
#     from_port        = 8080
#     to_port          = 8080
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     # ipv6_cidr_blocks = ["::/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "Allowing the traffic via terraform config"
#   }
# }

# resource "aws_dynamodb_table" "basic-dynamodb-table" {
#   name           = "terraform-lock"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key = "LockID"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

terraform {
  backend "s3" {
    bucket = "my-tf-aayush-bucket"
    region = "us-east-1"
    # use_lockfile = true
    # dynamodb_table = "terraform-lock"
  }
}