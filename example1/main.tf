provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami = "ami-002f6e91abff6eb96"  # Linux AMI Id
  instance_type = "t2.micro"

  tags = {
    Name = "aayushvm"
  }
}

# open this folder in wsl
# execute terraform init
# execute terraform plan
# execute terraform app