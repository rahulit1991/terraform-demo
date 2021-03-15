#AWS Provider
variable "AWS_REGION" {
  description = "AWS deployment region"
  default = "ap-south-1"
}
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "INSTANCE_AMI" {
  /* getting latest image from http://cloud-images.ubuntu.com/locator/ec2/ */
      type = map(string)
      default = {
        us-east-1 = "ami-042e8287309f5df03"
        ap-south-1 = "ami-0d758c1134823146a"
        eu-west-1 = "ami-0db61e5fa6d1a815a"
            }
}
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