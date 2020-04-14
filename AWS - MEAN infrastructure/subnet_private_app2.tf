
resource "aws_subnet" "private_sbn" {
    vpc_id = aws_vpc.app_vpc.id
    cidr_block = var.Subnet-Private-CIDR
    availability_zone = var.aws_availability_zone
    
    tags = {
        Name = "Private Subnet"
    }

}
resource "aws_route_table_association" "private_rta" {
    subnet_id = aws_subnet.private_sbn.id
    route_table_id = aws_route_table.private_rt.id
}