data "aws_ami" "server_ami" {
most_recent = true
owners = ["amazon"]

 filter {
  name = "name"
  values = ["amzn-ami-hvm*-x86_64-gp2"]
 }
}

resource "aws_key_pair" "dev_auth" {
  key_name = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
<<<<<<< HEAD
=======
  //  public_key = "${file("terraform_ec2_key.pub")}"
>>>>>>> terraup
}

data "template_file" "user-init" {
  count = 2
  template = "${file("${path.module}/userdata.tpl")}"
  
  vars = {
   firewall_subnets = "${element(var.subnet_ips,count.index)}"
  }
}

resource "aws_instance" "dev_server" {
  count = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami = "${data.aws_ami.server_ami.id}"
 tags = {
  Name = "dev_server1-${count.index +1}"
 }
 key_name = "${aws_key_pair.dev_auth.id}"
 vpc_security_group_ids = ["${var.security_group}"] 
 subnet_id = "${element(var.subnets,count.index)}"
 user_data = "${data.template_file.user-init.*.rendered[count.index]}"
}