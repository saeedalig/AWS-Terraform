variable "region" {
  default = "us-east-1"
}

######## vpc_variables ################

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "name" {
  default = "dev"
}

variable "pub_sub-cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "pri_sub-cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "db_sub_cidrs" {
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}
