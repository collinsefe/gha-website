provider "aws" {
  region = "eu-west-2"
  # shared_credentials_files = ["/Users/rahulwagh/.aws/credentials"]
}

# Create AWS VPC in eu-west-2
resource "aws_vpc" "vpc-eu-west-2" {
  cidr_block = var.vpc_cidr

  tags = merge(
    var.additional_tags,
    {
      Name        = "${var.environment}-${var.project_id} Project"
      Environment = var.environment
    },
  )
}

# Setup public subnet
resource "aws_subnet" "public_subnets" {
  count             = length(var.cidr_public_subnets)
  vpc_id            = aws_vpc.vpc-eu-west-2.id
  cidr_block        = element(var.cidr_public_subnets, count.index)
  availability_zone = element(var.eu_availability_zone, count.index)

  tags = {
    Name = "${var.environment}-Public Subnet: ${var.project_id} ${count.index + 1}"
  }
}

# Setup private subnet
resource "aws_subnet" "private_subnets" {
  count             = length(var.cidr_private_subnets)
  vpc_id            = aws_vpc.vpc-eu-west-2.id
  cidr_block        = element(var.cidr_private_subnets, count.index)
  availability_zone = element(var.eu_availability_zone, count.index)

  tags = {
    Name = "${var.environment}-Private Subnet: ${var.project_id} ${count.index + 1}"
  }
}

output "vpc_id" {
  value = aws_vpc.vpc-eu-west-2.id
  
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = aws_vpc.vpc-eu-west-2.id
  service_name = "com.amazonaws.eu-west-2.ssm"
  security_group_ids = [aws_security_group.sg_vpc_eu_west_2.id]
   vpc_endpoint_type = "Interface"

  private_dns_enabled = false

   tags = {
    Name = "${var.environment} ${var.project_id} Project"
  }
}

