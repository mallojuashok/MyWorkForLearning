
# lets try to define the resource for the vpc
resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc_cidr_range

    tags = {
      "Name" = "from-tf"
    }

}
# lets create web subnet
resource "aws_subnet" "subnets" {
  count                 = length(var.subnet_name_tags)
    vpc_id              = aws_vpc.myvpc.id
    cidr_block          = cidrsubnet(var.vpc_cidr_range,8,count.index)
    availability_zone   = format("${var.target_region}%s",count.index%2==0?"a":"b")

    tags                = {
      "Name"            = var.subnet_name_tags[count.index]
    }

}
# Creating Security group
resource "aws_security_group" "websg" {
    vpc_id             = aws_vpc.myvpc.id
    description        = "To Create Security Group"
    
    ingress{
      from_port        = 22
      to_port          = 22
      protocol         ="tcp"
      cidr_blocks      =["0.0.0.0/0"]
    }
    ingress{
      from_port        = 80
      to_port          = 80
      protocol         ="tcp"
      cidr_blocks      =["0.0.0.0/0"]
    }
    
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      =["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
   }
   tags                ={
    "Name"             ="Web Security"
   }
}
