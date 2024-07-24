/*
# This data source would help you get the latest ami for your ec2 instance provisioning
data "aws_ami" "amzlinux2" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"] #Take an ami from launch instance in console and go under "AMI" to search to get the name
    #al2023-ami-2023.0.20230503.0-kernel-6.1-x86_64 This is for AL 2023
    #amzn2-ami-kernel-5.10-hvm-2.0.20230418.0-x86_64-gp2 This is for HVM
    #[ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

*/

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


/*
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}
*/

resource "aws_instance" "ERPLY" {
#ami                    = data.aws_ami.amzlinux2.id
ami                     = data.aws_ami.ubuntu.id
#instance_type           = var.instance_type
instance_type           = var.instance_type_list[2]
key_name                = var.key-name
vpc_security_group_ids  = [ aws_security_group.vpc_prod_secgrp.id ]
subnet_id               = aws_subnet.vpc_prod_subnet1.id
user_data               = file("install_applications.sh")

count = 3
tags = {
  #Name = "ERPLY"
  Name = "ERPLY-${count.index}"
  } 
}


/****
resource "aws_route53_zone" "my_zone" {
  name = "mydomain.com"
}

resource "aws_route53_record" "www_mydomain_com" {
  zone_id = "${aws_route53_zone.my_zone.zone_id}"
  name    = "www.mydomain.com"
  type    = "A"
  ttl     = "300"
  records = ["192.0.2.44"]
}
***/





/*
///////
provider "aws" {
  region = "us-west-1"
}

resource "aws_eks_cluster" "erply_test_cluster" {
  name     = "erply-test-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.public.*.id
  }

  version = "1.29"
}

resource "aws_eks_node_group" "worker_nodes" {
  cluster_name    = aws_eks_cluster.erply_test_cluster.name
  node_group_name = "worker-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.public.*.id

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  instance_types = ["t2.small"]

  depends_on = [
    aws_eks_cluster.erply_test_cluster
  ]
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCNIPolicy"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}
/////////

*/

