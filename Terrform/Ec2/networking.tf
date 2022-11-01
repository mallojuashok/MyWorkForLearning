
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
      from_port        = local.ssh_port
      to_port          = local.ssh_port
      protocol         =local.any_tcp
      cidr_blocks      =[local.any_where]
    }
    ingress{
      from_port        = local.http_port
      to_port          = local.http_port
      protocol         =local.any_tcp
      cidr_blocks      =[local.any_where]
    }
    
    egress {
      from_port        = local.all_ports
      to_port          = local.all_ports
      protocol         = local.any_protocol
      cidr_blocks      =[local.any_where]
      ipv6_cidr_blocks = [local.any_ipv6]
   }
   tags                ={
    "Name"             ="Web Security"
   }
}
# Creating Security group
resource "aws_security_group" "Appsg" {
    vpc_id             = aws_vpc.myvpc.id
    description        = "To Create Security Group"
    
    ingress{
      from_port        = local.ssh_port
      to_port          = local.ssh_port
      protocol         =local.any_tcp
      cidr_blocks      =[local.any_where]
    }
    ingress{
      from_port        = local.app_port
      to_port          = local.app_port
      protocol         =local.any_tcp
      cidr_blocks      =[var.vpc_cidr_range]
    }
    
    egress {
      from_port        = local.all_ports
      to_port          = local.all_ports
      protocol         = local.any_protocol
      cidr_blocks      =[local.any_where]
      ipv6_cidr_blocks = [local.any_ipv6]
   }
   tags                ={
    "Name"             ="App Security"
   }
}
#Creating Internetgateway
resource "aws_internet_gateway" "igw" {
        vpc_id          = aws_vpc.myvpc.id
        tags            ={
          Name          = "Igw_tf"
        }
  
}
#Craeting Route
resource "aws_route_table" "publicrt" {
    vpc_id              = aws_vpc.myvpc.id
   route {
       cidr_block       = local.any_where
       gateway_id       = aws_internet_gateway.igw.id
   }
    tags                = {
    "Name"              ="Public Rt"
   }
}
resource "aws_route_table" "pvtrt" {
    vpc_id              = aws_vpc.myvpc.id
    
    tags                = {
    "Name"              ="Private Rt"
   }
}
# Creating Route Association
resource "aws_route_table_association" "Association" {
    count               = length(aws_subnet.subnets)
    subnet_id           = aws_subnet.subnets[count.index].id
   route_table_id       = count.index < 2 ?aws_route_table.publicrt.id : aws_route_table.pvtrt.id
  
}
#Creating Key pair
resource "aws_key_pair" "ssh_key" {
  key_name              = "My_TF_Key"
  public_key            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWE6Hgcu7fE0yvN9W8u1yAhT9b7VvkLZVfSbqYS2qhICF+W4fP/2+qak4YBCVqkF8qBRgW+u1CiAeUmD1ySd8KUldqu8zemuQGYUTSrnJT0AL8psvY3TL7njNBcsj1+0yXl6OmO6U/S8rvsc1JzwgkVlDojuSUF/tEto5tKnVKN+WxdQp2ZIpqFYP5y3SalW4bfAjpWVsMiEX9m1EqFsO+UAtSC6DT2dTL5DL5zX8nrL+cQZuQKpin0xQDeEVZ4uFeomt/Rngh85TYjQZUwalKEBQ/n1syaNGNqpGUnVKgd5oo0Hsq1G1Cs9NY1PPK6pkTOcOxj1YDEV5h4oMEvp8g99oL42gFdW9Wcq7zemVnzCDkCDaPeZa2960rZtdzTwEe7n+kQpI5rG/YJFev7Y9yF+RWHwPIS1RCYPtcFJe2kPQ2TxUoPThif1z5/vmUFlYW31QkkULZfe8XWEbFt3009PkQZ2hBboNrQYgvP4YfQEKugV5nCyot0yRqvafY/Fs= Aadrik@LAPTOP-QD0SB40O"
  
}
#Creating Instance
resource "aws_instance" "MyIns" {
  ami                        = "ami-0149b2da6ceec4bb0"  
  associate_public_ip_address = "true"
  instance_type              = "t2.micro"
  availability_zone          = "us-east-1a"
  key_name                   = "My_TF_Key"
  security_groups            = ["${aws_security_group.websg.id}"]
  subnet_id                  = aws_subnet.subnets[0].id
  tags = {
    Name                      = "Ins_TF"
  }
}