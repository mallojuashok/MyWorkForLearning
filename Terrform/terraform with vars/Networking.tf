
# lets try to define the resource for the vpc
resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc_cidr_range

    tags = {
      "Name" = "from-tf"
    }

}
# lets create web subnet
resource "aws_subnet" "web" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = var.subnet_cidr[0]
    availability_zone   = var.az-a

    tags                = {
      "Name"            = "web-tf"
    }

}
# lets create web1 subnet
resource "aws_subnet" "web1" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = var.subnet_cidr[1]
    availability_zone   = var.az-b

    tags                = {
      "Name"            = "web1-tf"
    }

}
# lets create Db subnet
resource "aws_subnet" "Db" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = var.subnet_cidr[2]
    availability_zone   = var.az-a

    tags                = {
      "Name"            = "Db-tf"
    }

}
# lets create web1 subnet
resource "aws_subnet" "Db1" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = var.subnet_cidr[3]
    availability_zone   = var.az-b

    tags                = {
      "Name"            = "Db1-tf"
    }

}
# lets create web subnet
resource "aws_subnet" "App" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = var.subnet_cidr[4]
    availability_zone   = var.az-a

    tags                = {
      "Name"            = "App-tf"
    }

}
# lets create web1 subnet
resource "aws_subnet" "App1" {
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = var.subnet_cidr[5]
    availability_zone   = var.az-b

    tags                = {
      "Name"            = "App1-tf"
    }

}