
provider "aws" {
  region = var.aws_region
}

module "TerraformVPC" {
  source = "./modules/vpc"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
  }

  subnet_config = {
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
  }
}

module "WebServer" {
  source = "./modules/ec2"
  instance_config = {
    ami_id = var.instance_config.ami_id
    instance_count = var.instance_config.instance_count
    instance_type = var.instance_config.instance_type
    instance_name = "Webserver-${var.instance_config.instance_name}"
  }
  security_group_name = "Modified security group"
  vpc_config = {
    vpc_id = module.TerraformVPC.vpc_id
    subnet_id = module.TerraformVPC.subnet_id  
  }
}

module "BackendServer" {
  source = "./modules/ec2"
  instance_config = {
    ami_id = var.instance_config.ami_id
    instance_count = var.instance_config.instance_count
    instance_type = var.instance_config.instance_type
    instance_name = "Backend-${var.instance_config.instance_name}"
  }
  security_group_name = "Modified security group"

  vpc_config = {
    vpc_id = module.TerraformVPC.vpc_id
    subnet_id = module.TerraformVPC.subnet_id  
  }
}

resource "aws_sns_topic" "alarms" {
  name = "${terraform.workspace}-alarms"
}

module "webserver_cpu_alarm" {
  source = "./modules/cloudwatch"
  count = var.environment == "prod" ? var.instance_config.instance_count : 0
  alarm_config = {
    alarm_name = "${terraform.workspace}-webserver-high-cpu-${count.index +1}"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 5
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 60
    statistic = "Average"
    threshold = 5
    alarm_description = "This is a test monitor creator for prod resources"
    alarm_actions = [ "arn:aws:cloudwatch:ap-south-1:120569639577:alarm:test-alarm" ]
    dimensions = {
      InstanceId = module.WebServer.instance_id[count.index]
    }
  }
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

# resource "aws_s3_bucket" "example" {
#   bucket = "my-tf-aayush-bucket"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }

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

# terraform {
#   backend "s3" {
#     bucket = "my-tf-aayush-bucket"
#     region = "us-east-1"
#     # use_lockfile = true
#     # dynamodb_table = "terraform-lock"
#   }
# }