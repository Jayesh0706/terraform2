provider "aws"{
    region = "ap-south-1"
    alias = "Mumbai"
}

provider "aws"{
    region = "us-east-1"
    alias = "USA"
}
locals {
  staging_env = "Production"   
}  # we have to chnage value here eg staging1/staging2/production etc and it will be used everywhere

resource "aws_vpc" "staging-vpc" {
    provider = aws.Mumbai
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "${local.staging_env}_vpc"
    }
}

resource "aws_subnet" "staging_subnet" {
    provider = aws.Mumbai
    vpc_id = aws_vpc.staging-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    tags = {
        Name = "${local.staging_env}_subnet"
    }    
}

resource "aws_instance" "ec2_eg" {
    provider = aws.Mumbai
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.staging_subnet.id   
     

    tags = {
      Name = "${local.staging_env}-ec2"
    }
  
}