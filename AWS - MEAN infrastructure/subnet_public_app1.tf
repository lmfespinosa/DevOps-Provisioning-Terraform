resource "aws_subnet" "public_sbn" {
    vpc_id = aws_vpc.app_vpc.id
    cidr_block = var.Subnet-Public-CIDR
    availability_zone = var.aws_availability_zone
 
    tags = {
        Name = "Public Subnet"
    }
    depends_on = [aws_internet_gateway.app_gw]
}
resource "aws_route_table_association" "Public_rta" {
    subnet_id = aws_subnet.public_sbn.id
    route_table_id = aws_route_table.public_rt.id
}