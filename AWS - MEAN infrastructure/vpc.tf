resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc-fullcidr #"172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
    Name = "app-vpc"
  }
}