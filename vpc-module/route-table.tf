resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc-eu-west-2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_internet_gateway.id
  }
  tags = {
    Name = "${var.environment}-Public-RTB: ${var.project_id} Project"
  }
}

resource "aws_route_table" "private_route_table" {
  count      = length(var.cidr_private_subnets)
  vpc_id     = aws_vpc.vpc-eu-west-2.id
  depends_on = [aws_nat_gateway.nat_gateway]
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }
  tags = {
    Name = "${var.environment}-Private-RTB: ${var.project_id} Project"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.cidr_public_subnets)
  depends_on     = [aws_subnet.public_subnets, aws_route_table.public_route_table]
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.cidr_private_subnets)
  depends_on     = [aws_subnet.private_subnets, aws_route_table.private_route_table]
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_route_table[count.index].id
}