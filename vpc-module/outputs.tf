output "aws_private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "aws_public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "vpc_security_group_ids" {
  value = aws_security_group.sg_vpc_eu_west_2
}
