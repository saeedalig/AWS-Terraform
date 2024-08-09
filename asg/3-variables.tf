
variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}
variable "public_subnets" {
  description = "A list of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

}

variable "private_subnets" {
  description = "A list of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "databasee_subnets" {
  description = "A list of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

