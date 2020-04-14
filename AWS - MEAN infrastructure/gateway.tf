resource "aws_internet_gateway" "app_gw" {
  vpc_id = aws_vpc.app_vpc.id
  
  tags = {
    Name = "app1-gw"
  }
}

resource "aws_network_acl" "all" {
    vpc_id = aws_vpc.app_vpc.id
    egress {
        protocol = "-1"
        rule_no = 2
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    ingress {
        protocol = "-1"
        rule_no = 1
        action = "allow"
        cidr_block = "0.0.0.0/0"
        from_port = 0
        to_port = 0
    }
    tags = {
        Name = "open acl"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.app_vpc.id
    tags = {
        Name = "Public"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.app_gw.id
    }
}
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.app_vpc.id
    tags = {
        Name = "Private"
    }
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.public_ngw.id
    }
}
resource "aws_eip" "forNat" {
    instance = aws_instance.app1.id
    vpc = true
}

resource "aws_nat_gateway" "public_ngw" {
    allocation_id = aws_eip.forNat.id
    subnet_id = aws_subnet.public_sbn.id
    depends_on = [aws_internet_gateway.app_gw]
}