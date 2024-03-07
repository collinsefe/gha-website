variable "project_id" {
  type        = string
  description = "The Project ID"
  default = "GDS"
}

variable "vpc_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
  default     = "10.0.0.0/16"
}

variable "cidr_public_subnets" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "cidr_private_subnets" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "eu_availability_zone" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-west-2a", "eu-west-2b"]
}


variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}

variable "additional_tags" {
  default     = {}
  description = "Additional resource tags"
  type        = map(string)
}

variable "environment" {
  type        = string
  description = "AWS environment e.g. Development, Production, Sandbox"

  validation {
    condition     = contains(["Development", "Production", "Sandbox"], var.environment)
    error_message = "Valid values for variables: environment are (Development, Production, Sandbox)."
  } 
}