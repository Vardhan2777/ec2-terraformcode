
data "aws_ami" "linux" {

  most_recent = true
  owners      = ["137112412989"]


  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "tag:Name"
    values = ["amazon-linux"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


#get the vpc 
data "aws_vpc" "default_vpc" {
  default = true

}

data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}