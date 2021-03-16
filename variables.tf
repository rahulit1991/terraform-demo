#AWS Provider
variable "AWS_REGION" {
  description = "AWS deployment region"
  default = "ap-south-1"
}
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "key_path" {}
variable "vpc-cidr-block" {}

variable "az1" {}
variable "az2" {}
variable "az3" {}

variable "public-subnet1" {}
variable "public-subnet2" {}
variable "public-subnet3" {}

variable "private-subnet1" {}
variable "private-subnet2" {}
variable "private-subnet3" {}

