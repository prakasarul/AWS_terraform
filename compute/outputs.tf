output "server_id" {
  value = "${join(", ",aws_instance.dev_server.*.id)}"
}

output "server_ip" {
  value = "${join(", ",aws_instance.dev_server.*.public_ip)}"
}