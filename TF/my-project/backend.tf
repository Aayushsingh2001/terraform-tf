terraform{
    backend "s3" {
        bucket = "aayush-basket-cfe5a416"
        key = "terraform.tfstate"
        region = "ap-south-1"
    }
}
