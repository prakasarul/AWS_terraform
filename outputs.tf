#output file root moudle.

output "Bucket_Name" {
  value = "${module.storage.bucketname}"
}


output "public_subnets" {
  value = "${module.networking.public_subnets}"
}

output "public_sg" {
  value = "${module.networking.public_sg}"
}

output "subnet_ips" {
  value = "${module.networking.subnet_ips}"
}

output "publie_instance_id" {
  value = "${module.compute.server_id}"
}

output "public_instance_ip" {
  value = "${module.compute.server_ip}"
}