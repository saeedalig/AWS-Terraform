
################################
# EIP
################################

resource "aws_eip" "backend_eip" {
  domain = "vpc"

  tags = {
    Name        = "${local.env}-${local.app}-backend_eip"

  }
}

################################
# NAT Gateway
################################
resource "aws_nat_gateway" "backend_nat" {
  allocation_id = aws_eip.backend_eip.id
  subnet_id     = aws_subnet.backend_public_subnets[0].id

  tags = {
    Name        = "${local.env}-${local.app}-backend_nat"
  }

  depends_on = [aws_internet_gateway.backend_igw]
}