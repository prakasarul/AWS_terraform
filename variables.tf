variable "aws_region" {}

variable "project_name" {}

variable "profile" {}

variable "vpc_cidr" {}


variable "public_cidrs" {
  type = "list"
}


variable "accessip" {}


variable "key_name" {}
variable "public_key_path" {}
variable "instance_type" {}
variable "instance_count" {
  default = 1
}
