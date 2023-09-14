terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
  #backend "s3" {
   # bucket = "enes-mybucket"  # S3 bucket name
    #key    = "path/to/my/key" # S3 key name
    #region = "us-east-2"      # S3 region
  #}
}
# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}
resource "aws_vpc" "myvpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "MyVPC"
    }
}
resource "aws_subnet" "PublicSubnet"{
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-2a"
    cidr_block = "10.0.1.0/24"
}    
resource "aws_subnet" "PrivSubnet"{
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
}
resource "aws_internet_gateway" "myIgw"{
    vpc_id = aws_vpc.myvpc.id
}
resource "aws_route_table" "PublicRT"{
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myIgw.id
    }
}
resource "aws_route_table_association" "PublicRTAssociation"{
    subnet_id = aws_subnet.PublicSubnet.id
    route_table_id = aws_route_table.PublicRT.id
}
resource "aws_s3_bucket" "eb_bucket" {
  bucket = "enes-eb-bucket" # Name of S3 bucket 
}

# Beanstalk instance profile
data "aws_ec2_instance_type" "example" {
  instance_type = "t2.micro"
}

# Create an Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "gogs_app" {
  name = "GogsApp"

  #appversion_lifecycle {
   # service_role          = aws-iam-role.beanstalk_service.arn
    #delete_source_from_s3 = true
  #}
}
  
# CREATE ENVIRONMENT
resource "aws_elastic_beanstalk_environment" "gogs_env" {
  name        = "GogsEnvironment"
  application = aws_elastic_beanstalk_application.gogs_app.name
  solution_stack_name = "64bit Amazon Linux 2 v3.8.0 running Go 1"
  wait_for_ready_timeout = "10m"
  tier = "WebServer"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_vpc.myvpc.id
  }
   setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = aws_subnet.PrivSubnet.id
  }
}  

