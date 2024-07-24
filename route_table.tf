resource "aws_route_table" "vpc_prod_route1" {
  vpc_id = aws_vpc.vpc_prod.id

  route {
    # Associated subnet can reach public internet
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_prod_igw.id
  }

  tags = {
    #Name = "vpc_prod_route1"
    Name = "public"
  }
}


resource "aws_route_table" "vpc_prod_route2" {
  vpc_id = aws_vpc.vpc_prod.id

  route {
    # Associated subnet can reach public internet
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_prod_igw.id
    #nat_gateway_id = aws_nat_gateway.k8s-nat.id
  }

  tags = {
    #Name = "vpc_prod_route1"
    Name = "private"
  }
}





#associate subnet with route table
resource "aws_route_table_association" "subnet-route1" {
  subnet_id      = aws_subnet.vpc_prod_subnet1.id
  route_table_id = aws_route_table.vpc_prod_route1.id
}

resource "aws_route_table_association" "subnet-route2" {
  subnet_id      = aws_subnet.vpc_prod_subnet2.id
  route_table_id = aws_route_table.vpc_prod_route2.id
}

resource "aws_route_table_association" "subnet-route3" {
  subnet_id      = aws_subnet.vpc_prod_subnet3.id
  route_table_id = aws_route_table.vpc_prod_route1.id
}
resource "aws_route_table_association" "subnet-route4" {
  subnet_id      = aws_subnet.vpc_prod_subnet4.id
  route_table_id = aws_route_table.vpc_prod_route2.id
}