# This would create just a VPC
resource "aws_vpc" "vpc_prod" {
  cidr_block = "172.0.0.0/16"

  tags = {
    Name = "VPC_PROD"
  }
}


# Create an Internet gateway here
resource "aws_internet_gateway" "vpc_prod_igw" {
  vpc_id = aws_vpc.vpc_prod.id

  tags = {
    Name = "vpc_prod_igw"
  }
}