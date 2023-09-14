#variable "subnet_id" { value = "subnet-015f40300479c9f71" }
#variable "default_vpc_id" { value = "vpc-094c0d9b78cccd0b4" }

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}
