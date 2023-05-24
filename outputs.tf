output "ami" {

  value = data.aws_ami.linux.image_id
}

output "arn" {

  value = data.aws_ami.linux.arn
}

output "vpc" {
  value = data.aws_vpc.default_vpc.id

}

output "subnet" {
  value = data.aws_subnets.vpc_subnets.ids
}

output "subnet1" {
  value = data.aws_subnets.vpc_subnets.ids[1]
}

output "public_ip" {
  value = aws_instance.apache.public_ip
}