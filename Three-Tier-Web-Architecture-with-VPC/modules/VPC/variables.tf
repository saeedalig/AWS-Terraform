# VPC CIDR
variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  default = "10.0.0.0/16"
}

# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "Fin"
}


# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}

# # Subnet Count
# variable "subnet_count" {
#   default = 2
# }


variable "public_cidrs" {
  description = "Public Subnet CIDRS"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidrs" {
  description = "Private Subnet CIDRS"
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}