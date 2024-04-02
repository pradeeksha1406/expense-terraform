data "aws_ami" "ami"{
  most_recent = True
  name_regex  = "Centos-8-DevOps-Practice"
  owners = ["851725420695"]
}