provider "aws" {
  region = "ap-south-1"
}

module "web-server" {
  source = "./modules/ec2-instance"
  instance_name = "aayushvm"
  instance_type = "t2.micro"
  image_id = "ami-0e35ddab05955cf57"
}

module "s3_bucket" {
  source = "./modules/s3-bucket"
  bucket_name = "aayush-basket-1234"
  environment = "dev"
}