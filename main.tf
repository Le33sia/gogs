terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}
# Create an Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "app" {
  name = "gogs"
}

# Create an Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "env" {
  name                = "gogs_env"
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2/3.8.0 running Go 1"
  tier = "WebServer"
  # Configure other environment settings and options as needed
}


# Create a VPC
#resource "aws_vpc" "example" {
#  cidr_block = "10.0.0.0/16"
#}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"
  azs             = ["us-east-2a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway = true
  tags = {
    Terraform = "true"
  }
}
