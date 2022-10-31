variable "target_region" {
    type =  string
    default = "us-east-1"
    description = "Region Where to infra will created"
  
}
variable "vpc_cidr_range" {
    type = string
    default = "192.168.0.0/16"
    description = "Vpc Cidr Ranges"
  
}
variable "subnet_name_tags" {
    type = list(string)
    default = [ "web","web1","Db","Db1","App","App1"]
  
}