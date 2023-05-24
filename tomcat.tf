resource "aws_security_group" "tomcat" {
  name        = "tomcat"
  description = "Allow tomcat inbound traffic"
  vpc_id      = data.aws_vpc.default_vpc.id



  ingress {
    description = "tomcat from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "tomcat from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tomcat"
  }
}


resource "aws_instance" "tomcat" {
  ami                    = data.aws_ami.linux.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.tomcat.id]
  subnet_id              = data.aws_subnets.vpc_subnets.ids[1]
  tags = {
    Name       = "tomcat"
    team       = "devops"
    automation = "true"
  }


}



