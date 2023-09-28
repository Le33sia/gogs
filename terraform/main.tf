provider "aws" {
  region = var.aws_region
  //access_key = 
  //secret_key = 
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
resource "aws_subnet" "PrivateDbSubnet" {
  vpc_id            = aws_vpc.myvpc.id
  availability_zone =  "us-east-2a"# Choose a single availability zone for the private subnet
  cidr_block        = "10.0.2.0/24"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "PrivateAppSubnet" {
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = "us-east-2a"  # Choose the same availability zone as PrivateDbSubnet
  cidr_block        = "10.0.3.0/24"
  map_public_ip_on_launch = false   //or true?
}
resource "aws_subnet" "PrivateAppSubnet2" {
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = "us-east-2b"        #при створенні aws_db_subnet_group  вимагає більше двох зон, то додала us-east-2b
  cidr_block        = "10.0.4.0/24"
  map_public_ip_on_launch = false
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


# sec group
resource "aws_security_group" "gogs-prod" {
  vpc_id = aws_vpc.myvpc.id
  name = "gogs-secgroup"
  description = "App security group"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_iam_role" "beanstalkgogs" {
    name = "beanstalkgogs"

    managed_policy_arns = [
        "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier",
        "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker",
        "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier",
        "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    ]

    assume_role_policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Action = "sts:AssumeRole",
          Effect = "Allow",
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        }
      ]
   })
}
resource "aws_iam_instance_profile" "beanstalkgogs_profile" {
    name = "beanstalkgogs-profile"
    role = aws_iam_role.beanstalkgogs.name
}


resource "aws_elastic_beanstalk_application" "gogs" {
  name = "GogsApp"
}
# CREATE ENVIRONMENT
resource "aws_elastic_beanstalk_environment" "gogs-env" {
  name        = "GogsEnvironment"
  application = aws_elastic_beanstalk_application.gogs.name
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
    value     = aws_subnet.PublicSubnet.id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = aws_subnet.PrivateAppSubnet.id
  }
  # Associate the security group with the Elastic Beanstalk environment
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = "${aws_security_group.gogs-prod.id}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalkgogs_profile.name
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     =  "True"
  }
  
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t3.micro"
  }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_USERNAME"
    value = "${aws_db_instance.rds-gogs-prod.username}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_PASSWORD"
    value = "${aws_db_instance.rds-gogs-prod.password}"
  }
  //setting {
    //namespace = "aws:elasticbeanstalk:application:environment"
    //name = "RDS_DATABASE"
    //value = "${aws_db_instance.rds-gogs-prod.name}"
  //}
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_HOSTNAME"
    value = "${aws_db_instance.rds-gogs-prod.endpoint}"
  }
}






resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "gogss3bucket"  # Replace with your desired bucket name # Adjust access control as needed
}


