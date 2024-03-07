resource "aws_eip" "nat_eip" {
  count  = length(var.cidr_private_subnets)
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.cidr_private_subnets)
  depends_on    = [aws_eip.nat_eip]
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.private_subnets[count.index].id
  tags = {
    "Name" = "${var.environment} Private NATGW: ${var.project_id} Project "
  }
}