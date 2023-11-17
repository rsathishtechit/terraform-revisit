provider "aws" {}

variable "subnet_cidr_block" {
  description= "subnet CIDR block"
}

variable "vpc_cidr_block" {
  description = "vpc CIDR block"
}

variable "enviroment" {
  default = "deployment environment name"
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name :var.enviroment
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "ap-south-1a"
  tags = {
    Name : "subnet-1-dev"
  }
}

data "aws_vpc" "existing_vpc" {
    default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.55.0/25"
  availability_zone = "ap-south-1a"
  tags = {
    Name : "subnet-2-default"
  }
}


