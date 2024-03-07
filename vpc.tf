terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}


module "vpc_module" {

  source               = "./vpc-module"
  project_id           = var.project_id
  vpc_cidr             = var.vpc_cidr
  cidr_private_subnets = var.cidr_private_subnets
  cidr_public_subnets  = var.cidr_public_subnets
  eu_availability_zone = var.eu_availability_zone
  vpc_name             = var.vpc_name
  additional_tags      = var.additional_tags
  environment          = var.environment
  # enable_vpc_endpoint = false
}


# module "vpc_module-2" {

#   source               = "./vpc-module"
#   project_id           = var.project_id2
#   vpc_cidr             = var.vpc_cidr2
#   cidr_private_subnets = var.cidr_private_subnets2
#   cidr_public_subnets  = var.cidr_public_subnets2
#   eu_availability_zone = var.eu_availability_zone2
#   vpc_name             = var.vpc_name2
#   additional_tags      = var.additional_tags2
#   environment          = var.environment2




# }


# data "aws_subnet" "public_subnet" {
#   filter {
#     name = "tag:Name"
#     values = ["Subnet-Public : Public Subnet 1"]
#   }

#   depends_on = [
#     aws_route_table_association.public_subnet_asso
#   ]
# # }

# resource "aws_instance" "ec2_example" {
#   ami = "ami-0e5f882be1900e43b"
#   instance_type = "t2.micro"
#   tags = {
#     Name = "EC2 Public subnet 1"
#   }
#   key_name= "aws_key"
#   #subnet_id = data.aws_subnet.aws_gongola_public_subnet.id
#   subnet_id = "${my-module-vpc.cidr_public_subnets[0]}"

#   vpc_security_group_ids = [aws_security_group.sg_vpc_gongola_eu_west_2.id]
# }

# resource "aws_key_pair" "deployer" {
#   key_name   = "aws_key"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC56JQgYBYnirYqIDoWxcvkuXfAJ895uY0ULLfFcvgBy5zCwm8G9jYq+NyrHloorJHSMgKEbLlTUA5XKaqYD7nlM1FSTyb4W8I3e1+FO0apbRlXe2B3u0yRlNq3x2hFGJlKJwUczEtW1yOwW/WERPccHW3KSkuOhYwZ1r9uhLJF0wLaNQVfY3H6kk5M22/1x7G+MDokq2nDbYWBmaBwUlABcN0bSsqTRwn4OlXH3oZeEkhlik1fAMcScYtZCbPglExlNSjZvMY3kBTfOtq6RaMUHzTCdW0Z8nwsXmxL74si7tSMh4mc+EN9ykjt/e5ClgkPmZG8+GiASOgfBa9rDpYeWnZ3CQ3O7b7YvThUZ2vMbRvbhH0DjgsDKcbE+ONiW4vBmpQHED9QEyAa22s68odaYSvKuhrwy1ZQC5yQnc5UMttmrzSBwMxOeAHz4ibmGUEDQgQcZ+t9qZwnCfFKw2JCL8JgQOw9J8oHfKa3buUnGNLyogK38s2qdq1WfMEVO2c= collinsefe@yahoo.com"
# }


# # output "fetched_info_from_aws" {
# #   value = "" #format("%s%s","ssh -i /Users/collinsorighose/.ssh/aws_key ubuntu@",aws_instance.ec2_example.public_dns)
# # }


output "vpc_id_generated" {
  value = module.vpc_module.vpc_id
  
}