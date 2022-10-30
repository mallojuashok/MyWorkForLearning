#Creating One Vpc With 6 Subnets
provider "aws" {
    region        = "us-east-1"
}

# lets try to define the resource for the vpc
resource "aws_vpc" "myvpc" {
    cidr_block = "192.168.0.0/16"

    tags = {
      "Name" = "from-tf"
    }

}
# lets create web subnet
resource "aws_subnet" "web" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = "192.168.0.0/24"
    availability_zone   = "us-east-1a"

    tags                = {
      "Name"            = "web-tf"
    }

}
# lets create web1 subnet
resource "aws_subnet" "web1" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = "192.168.1.0/24"
    availability_zone   = "us-east-1b"

    tags                = {
      "Name"            = "web1-tf"
    }

}
# lets create Db subnet
resource "aws_subnet" "Db" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = "192.168.2.0/24"
    availability_zone   = "us-east-1a"

    tags                = {
      "Name"            = "Db-tf"
    }

}
# lets create web1 subnet
resource "aws_subnet" "Db1" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = "192.168.3.0/24"
    availability_zone   = "us-east-1b"

    tags                = {
      "Name"            = "Db1-tf"
    }

}
# lets create web subnet
resource "aws_subnet" "App" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = "192.168.4.0/24"
    availability_zone   = "us-east-1a"

    tags                = {
      "Name"            = "App-tf"
    }

}
# lets create web1 subnet
resource "aws_subnet" "App1" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = "192.168.5.0/24"
    availability_zone   = "us-east-1b"

    tags                = {
      "Name"            = "App1-tf"
    }

}