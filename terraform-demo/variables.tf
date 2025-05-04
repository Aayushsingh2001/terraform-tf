variable "aws_region" {
  type = string
  default = "ap-south-1"
  description = "aws region"
}

variable "instance_config" {
  type = object({
    ami_id = string,
    instance_type = string,
    instance_count = number,
    instance_name = string
  })
}
