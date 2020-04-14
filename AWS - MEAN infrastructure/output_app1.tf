output "instance_ip_addr_app1" {
  value = aws_instance.app1.private_ip
}

output "PublicIPApp1" {
  value = "${aws_instance.app1.public_ip}"
}
