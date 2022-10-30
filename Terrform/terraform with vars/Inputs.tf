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
variable "az-a" {
    type = string
    default = "us-east-1a"
    description = "Regin for Subnet 1a"
  
}
variable "az-b" {
    type = string
    default = "us-east-1b"
    description = "Regin for Subnet 1b"
  
}
variable "subnet_cidr" {
    type = list(string)
    default = ["192.168.0.0/24","192.168.1.0/24","192.168.2.0/24","192.168.3.0/24","192.168.4.0/24","192.168.5.0/24"]
  
}