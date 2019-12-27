output "public_subnets" {
  value = "${aws_subnet.dev_pub_subnet.*.id}"
}

output "public_sg" {
  value = "${aws_security_group.dev_pub_sg.id}"
}

output "subnet_ips" {
  value = "${aws_subnet.dev_pub_subnet.*.cidr_block}"
}