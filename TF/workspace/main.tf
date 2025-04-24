provider "aws" {
  region = var.region
}

resource "aws_instance" "app_server" {
  ami = "ami-0e35ddab05955cf57"
  instance_type = var.type
  tags = {
    Name = "AppServer-${var.environment}"
    Environments = var.environment
  }
}