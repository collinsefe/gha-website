resource "aws_internet_gateway" "public_internet_gateway" {
  vpc_id = aws_vpc.vpc-eu-west-2.id
  tags = {
    Name = "${var.environment} ${var.project_id} Project"
  }
}