/*
############################
resource "aws_eip" "nat" {

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "k8s-nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.vpc_prod_subnet1.id

  tags = {
    Name = "k8s-nat"
  }

  depends_on = [aws_internet_gateway.vpc_prod_igw]
}
############################
*/
