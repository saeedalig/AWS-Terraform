# Region
variable "region" {
  description = "AWS Region to create resources "
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_cidrs" {
  description = "Public Subnet CIDRS"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "private_cidrs" {
  description = "Private Subnet CIDRS"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}


# EC2 Instance Type
variable "instance_type" {
  default = "t2.micro"
}
