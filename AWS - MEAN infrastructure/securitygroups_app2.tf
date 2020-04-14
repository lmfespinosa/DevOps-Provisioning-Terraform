
resource "aws_security_group" "Database" {
    name = "Database"
    tags = {
        Name = "Database"
    }
    description = "Security group for App2 - Database"
    vpc_id = aws_vpc.app_vpc.id
    ingress {
        from_port = var.DataBasePort
        to_port = var.DataBasePort
        protocol = "TCP"
        security_groups = ["${aws_security_group.FrontEnd.id}"]
    }
    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}