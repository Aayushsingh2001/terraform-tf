provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "server" {
  count = 3
  ami = "ami-0e35ddab05955cf57"  # Ubuntu AMI Id
  instance_type = "t2.micro"
  
  tags = {
    Name ="server-${count.index+1}"
  }
}