
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "terraform-ec2" {
  ami = "ami-0f1dcc636b69a6438"
  instance_type = "t2.micro"
  count = 1
}