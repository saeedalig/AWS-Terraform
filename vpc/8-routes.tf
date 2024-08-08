
################################
# Private Route Table
################################

resource "aws_route_table" "backend_private_rt" {
  vpc_id = aws_vpc.backend_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.backend_nat.id
  }

  tags = {
    Name = "${local.env}-${local.app}-private_rt"
  }
}

################################
# Public Route Table
################################
resource "aws_route_table" "backend_public_rt" {
  vpc_id = aws_vpc.backend_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.backend_igw.id
  }

  tags = {
    Name = "${local.env}-${local.app}-public_rt"
  }
}

################################
# Private Route Table Associations
################################

resource "aws_route_table_association" "backend_private_rta" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.backend_private_subnets[count.index].id
  route_table_id = aws_route_table.backend_private_rt.id
}


################################
# Public Route Table Associations
################################

resource "aws_route_table_association" "backend_public_rta" {
  count = length(var.public_subnets)
  subnet_id = aws_subnet.backend_public_subnets[count.index].id
  route_table_id = aws_route_table.backend_public_rt.id
}

################################
# Database Route Table Associations
################################

resource "aws_route_table_association" "backend_database_rta" {
  count = length(var.public_subnets)
  subnet_id = aws_subnet.backend_database_subnets[count.index].id
  route_table_id = aws_route_table.backend_public_rt.id
}