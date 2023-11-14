variable "instance_type" {
  default = "t2.micro" 
}

variable "name" {}
variable "pub_sub_ids" {}

variable "keypair" {
  default = "tf-mum.pem"
}

variable "bastion_sg_id" {}
