# variable "ami_id" {
#   type = string
#   default = "ami-062f0cc54dbfd8ef1"
#   description = "This is the AMI id of AL2 in ap-south-1 region"
# }

# variable "instance_type" {
#   type = string
#   default = "t2.micro"
#   description = "This is type of ec2 instance to launch"
# }

# variable "instance_count" {
#   type = number
#   default = 3
#   description = "Number of instances"
# }

# variable "instance_name" {
#   type = string
#   default = "Terraform-created"
#   description = "Name of instances"
# }

variable "aws_region" {
  type = string
  default = "us-east-1"
  description = "aws region"
}

