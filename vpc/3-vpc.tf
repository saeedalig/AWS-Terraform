resource "aws_vpc" "backend_vpc" {
  cidr_block = var.cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.env}_${local.app}_vpc"
  }
}