resource "aws_security_group" "apache" {
  name        = "apache"
  description = "Allow Apache inbound traffic"
  vpc_id      = data.aws_vpc.default_vpc.id



  ingress {
    description = "Apache from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Apache from VPC"
    from_port   = 80
    to_port     = 80
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
    Name = "apache"
  }
}


resource "aws_instance" "apache" {
  ami                    = data.aws_ami.linux.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.apache.id]
  subnet_id              = data.aws_subnets.vpc_subnets.ids[1]
  key_name               = aws_key_pair.deployer.id
  /* user_data              = <<-EOF
  #!/bin/bash
  echo "*** Installing httpd"
  sudo yum update -y
  sudo yum install httpd -y
  systemctl start httpd 
  systemctl enable httpd
  echo "*** Completed Installing httpd"
  EOF */
  user_data = file("scripts/apache.sh")
  tags = {
    Name       = "apache"
    team       = "devops"
    automation = "true"
  }
  depends_on = ["aws_security_group.apache", "aws_key_pair.deployer"]
  lifecycle {
    create_before_destroy = true
  }

}



