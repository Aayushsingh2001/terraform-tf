# terraform {
#   backend "s3" {
#     bucket = "aayush-basket-1234"
#     key = "global/s3/terraform.tfstate"
#     region = "ap-south-1"
#   }
# }

# After this again you can do terraform init
# it will promp to copy terraform.tfstate in s3 bucket so you can say yess
# file will bw copied.
