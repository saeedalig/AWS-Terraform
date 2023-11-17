variable "instance_type" {
  default = "t2.micro" 
}


variable "name" {}
variable "vpc_id" {}
variable "pub_sub_ids" {}

variable "keypair" {
  default = "keys/tf-mum.pem"
}

variable "bastion_sg_id" {}
