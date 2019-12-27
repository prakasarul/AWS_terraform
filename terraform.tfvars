aws_region = "ap-south-1"
project_name = "divi-prod"
profile = "divdevops"

vpc_cidr = "10.124.0.0/16"
public_cidrs = [
"10.124.1.0/24",
"10.124.2.0/24"
]
accessip = "0.0.0.0/0"

key_name = "dev_key"

public_key_path = "/root/.ssh/id_rsa.pub"

instance_type = "t2.micro"
instance_count = 2