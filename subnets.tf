
#PUBLIC SUBNET = 1 and 3
#PRIVATE SUBNET   = 2 and 4

# Create a Subnet
resource "aws_subnet" "vpc_prod_subnet1" {
  vpc_id     = aws_vpc.vpc_prod.id
  cidr_block = "172.0.0.0/19"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1b"
  tags = {
    Name = "vpc_prod_subnet1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/erply"      = "owned"
  }
}

resource "aws_subnet" "vpc_prod_subnet2" {
  vpc_id     = aws_vpc.vpc_prod.id
  cidr_block = "172.0.32.0/19"
  #map_public_ip_on_launch = true
  availability_zone = "us-west-1c"

  tags = {
    Name = "vpc_prod_subnet2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/erply"      = "owned"
  }
}

resource "aws_subnet" "vpc_prod_subnet3" {
  vpc_id     = aws_vpc.vpc_prod.id
  cidr_block = "172.0.64.0/19"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1b"

  tags = {
    Name = "vpc_prod_subnet3"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/erply"      = "owned"
  }
}

resource "aws_subnet" "vpc_prod_subnet4" {
  vpc_id     = aws_vpc.vpc_prod.id
  cidr_block = "172.0.96.0/19"
  #map_public_ip_on_launch = true
  availability_zone = "us-west-1c"

  tags = {
    Name = "vpc_prod_subnet4"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/erply"      = "owned"
  }
}



