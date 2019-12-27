data "aws_availability_zones" "available" {}

resource "aws_vpc" "dev_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "dev_vpc1"
  }
  
}

resource "aws_internet_gateway" "dev_igw" {
 vpc_id = "${aws_vpc.dev_vpc.id}" 
  tags  = {
    Name = "dev-igw1"
  }
}

 resource "aws_route_table" "dev_public_rte" {
  vpc_id = "${aws_vpc.dev_vpc.id}"

  route {
    cidr_block ="0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dev_igw.id}"
   
 }
  tags = {
    Name = "dev_public_rte1"
  }  
}
resource "aws_default_route_table" "dev_private_rte" {
default_route_table_id = "${aws_vpc.dev_vpc.default_route_table_id}"  
  tags = {
    Name = "dev_private_rte1"
  }
}

resource "aws_subnet" "dev_pub_subnet" {
  count = "${length(var.public_cidrs)}"
  vpc_id = "${aws_vpc.dev_vpc.id}"
  cidr_block = "${element(var.public_cidrs,count.index)}"
  map_public_ip_on_launch = true
  availability_zone = "${element(data.aws_availability_zones.available.names,count.index)}"
  tags = {
    Name = "dev_pub_sub_${count.index +1}"
  }
}

resource "aws_route_table_association" "dev_pub_ass" {
 count = "${length(var.public_cidrs)}"
 subnet_id = "${element(aws_subnet.dev_pub_subnet.*.id,count.index)}"
 route_table_id = "${aws_route_table.dev_public_rte.id}"
  
}

resource "aws_security_group" "dev_pub_sg" {
name = "dev_pub_sg1"
description = "used for access public instance"
vpc_id = "${aws_vpc.dev_vpc.id}"  


#SSH
ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${var.accessip}"]
}

ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["${var.accessip}"]
}

egress {

  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}



#Referenced few coodes
#https://www.bogotobogo.com/DevOps/Terraform/Terraform-VPC-Subnet-ELB-RouteTable-SecurityGroup-Apache-Server-1.php