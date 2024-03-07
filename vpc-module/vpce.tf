# resource "aws_vpc_endpoint" "ssm_main" {
#   vpc_id       = aws_vpc.vpc-eu-west-2.id
#   service_name = "com.amazonaws.eu-west-2.ssm"
#   security_group_ids = [aws_security_group.sg_vpc_eu_west_2.id]
#    vpc_endpoint_type = "Interface"

#   private_dns_enabled = false

#    tags = {
#     Name = "${var.environment} ${var.project_id} Project"
#   }
# }

# output "vpce_id_generated" {
#     value = aws_vpc_endpoint.ssm_main.id
# }