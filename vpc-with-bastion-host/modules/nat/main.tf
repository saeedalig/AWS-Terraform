# EIP-1 in for NAT-1 in az1
resource "aws_eip" "eip_nat_az1" {
  domain = "vpc"
  tags = {
    Name = "${var.name}-eip-az1"
  }
}


# Create a Nat-1 in Public Subnet-az1
resource "aws_nat_gateway" "nat-az1" {
  # count = length(var.pub_sub_ids)
  allocation_id = aws_eip.eip_nat_az1.id
  subnet_id     = var.pub_sub_ids[0]

  tags = {
    Name ="${var.name}-NAT-az1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.igw_id]
}


# Create Private Route Table-1
resource "aws_route_table" "pri_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-az1.id
  }

  tags   = {
    Name ="${var.name}-Pri-RT"
  }
}

# Private Route Table Association for private subnets
resource "aws_route_table_association" "pri_rta" {
  count = length(var.pri_sub_ids)
  subnet_id = element(var.pri_sub_ids, count.index)
  route_table_id = aws_route_table.pri_rt.id
}

# Create Private Route Table-2 for Database Subnets
resource "aws_route_table" "db_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-az1.id
  }
  tags   = {
    Name ="${var.name}-db-RT"
  }
}

# Private Route Table Association for database subnets
  resource "aws_route_table_association" "db_rta" {
    count = length(var.db_sub_ids)
    subnet_id = element(var.db_sub_ids, count.index)
    route_table_id = aws_route_table.db_rt.id
  }

  