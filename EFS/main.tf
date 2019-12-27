resource "aws_efs_file_system" "efs" {
  creation_token   = "EFS Shared Data"
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
  encrypted = "true"

  tags = {
    Name = "Web_Data_EFS"
  }
}


 resource "aws_efs_mount_target" "webdata_efs_1" {
    file_system_id  = "${aws_efs_file_system.efs.id}"
    subnet_id = "${element(aws_subnet.dev_pub_subnet.*.id, count.index)}"
    security_groups = ["${aws_security_group.allow-ssh.id}"]
 }