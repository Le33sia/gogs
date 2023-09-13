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
resource "aws_vpc" "myvpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "MyVPC"
    }
}
resource "aws_subnet" "PublicSubnet"{
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-1a"
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


# Create an Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "gogs_app" {
  name = "GogsApp"
}

resource "aws_elastic_beanstalk_environment" "gogs_env" {
  name        = "GogsEnvironment"
  application = aws_elastic_beanstalk_application.gogs_app.name
  solution_stack_name = "Go 1 running on 64bit Amazon Linux 2/3.8.0"
  tier = "WebServer"
}  

