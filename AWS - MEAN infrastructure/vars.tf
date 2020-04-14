variable "access_key" {
  default = ""
}

variable "secret_key" {
  default = ""
}

variable "key_pair_path"{
  type = map
  default = {
    public_key_path = "keys/prod_key.pub",
    private_key_path = "keys/prod_key",
  }
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "aws_availability_zone" {
  default = "eu-west-1a"
}

variable "vpc-fullcidr" {
 default = "172.28.0.0/16"
 description = "the vpc cdir"
}

variable "Subnet-Public-CIDR" {
 default = "172.28.0.0/24"
 description = "the cidr of the subnet"
}
variable "Subnet-Private-CIDR" {
 default = "172.28.3.0/24"
 description = "the cidr of the subnet"
}

variable "DnsZoneName" {
 default = "example.internal"
 description = "the internal dns name"
}

variable "DataBasePort" {
 default = "27017"
 description = "Data base port"
}

variable "WebPort" {
 default = "80"
 description = "web port"
}

variable "IpApp2" {
 default = "172.28.3.114"
 description = "Ip App2"
}

variable "UserDB" {
 default = "admin"
 description = "UserDB"
}

variable "PassDB" {
 default = "admin123"
 description = "PassDB"
}
