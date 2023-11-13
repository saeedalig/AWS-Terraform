# EIP-1 in for NAT-1 in az-1
resource "aws_eip" "eip_nat_az1" {
  domain = "vpc"
  tags = {
    Name = "${var.name}-eip-az1"
  }
}

# EIP-2 in for NAT-2 in az-2
resource "aws_eip" "eip_nat_az2" {
  domain = "vpc"
  tags = {
    Name = "${var.name}-eip-az2"
  }
}


# Create a Nat Gateway in Public Subnet-1
resource "aws_nat_gateway" "nat-az1" {
  allocation_id = aws_eip.eip_nat_az1.id
  subnet_id     = var.pub_sub_ids[0]

  tags = {
    Name ="${var.name}-NAT-az1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.igw_id]
}

# Create a Nat Gateway in Public Subnet-2
resource "aws_nat_gateway" "nat-az2" {
  allocation_id = aws_eip.eip_nat_az2.id
  subnet_id     = var.pub_sub_ids[1]

  tags = {
    Name ="${var.name}-NAT-az2"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.igw_id]
}