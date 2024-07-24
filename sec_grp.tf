resource "aws_security_group" "vpc_prod_secgrp" {
  name        = "vpc_prod_secgrp"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc_prod.id

  ingress {
    description      = "TLS from VPC server"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    #cidr_blocks      = [aws_vpc.vpc_prod.cidr_block]
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    #cidr_blocks      = [aws_vpc.vpc_prod.cidr_block]
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "Secured TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    #cidr_blocks      = [aws_vpc.vpc_prod.cidr_block]
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  ingress {
    description      = "SSH into VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    #cidr_blocks      = [aws_vpc.vpc_prod.cidr_block]
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  /*ingress {
    description      = "mongodb"
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    #cidr_blocks      = [aws_vpc.vpc_prod.cidr_block]
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  */
  
  ingress {
    description      = "k8s"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    #cidr_blocks      = [aws_vpc.vpc_prod.cidr_block]
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}