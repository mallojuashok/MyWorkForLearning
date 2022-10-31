
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

# for ( i=0; i < 6; i++ )  {
# resource "aws_subnet" "subnets"{
#    cidr_block          = var.subnet_cidr[i]
 #   availability_zone   = var.subnet_azs[i]
#    vpc_id              = aws_vpc.myvpc.id
#     tags               = {
#      Name              = var.subnet_name_tags[i]
#    }
#  }
#}