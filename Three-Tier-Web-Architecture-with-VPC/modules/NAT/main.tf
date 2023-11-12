
# Allcate Elastic Ip Address (eip-1), used for the nat-gateway in the public subnet-1
resource "aws_eip" "eip-nat-1" {
  domain = "vpc"
  tags = {
    Name = "EIP-AZ1"
  }
}


# Allcate Elastic Ip Address (eip-2), used for the nat-gateway in the public subnet-2
resource "aws_eip" "eip-nat-2" {
  domain = "vpc"
  tags = {
    Name = "EIP-AZ2"
  }
}


# Create nat gateway in Public Subnet-1
resource "aws_nat_gateway" "nat-1" {
  allocation_id = aws_eip.eip-nat-1.id
  subnet_id = var.public_cidrs[0]
  
  tags   = {
    Name = "NAT-AZ1"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.igw_id]
}


# Create nat gateway in Public Subnet-2
resource "aws_nat_gateway" "nat-2" {
  allocation_id = aws_eip.eip-nat-2.id
  subnet_id = var.public_cidrs[1]

  tags = {
    Name = "NAT-AZ2"
  }

  depends_on = [ var.igw_id ]
}



# Create Private Route Table-1  and add route through NAT-1
resource "aws_route_table" "pri-rt-1" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-1.id
  }

  tags = {
    Name = "Pri-RT-AZ1"
  }
}

# Create Private Route Table-2  and add route through NAT-2
resource "aws_route_table" "pri-rt-2" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-2.id
  }

  tags = {
    Name = "Pri-RT-AZ2"
  }
}

# Associate Private Subnet-1 with Private Route Table-1
resource "aws_route_table_association" "pri-rta-1" {
  subnet_id = var.private_cidrs[0]
  route_table_id = aws_route_table.pri-rt-1.id
}

# Associate Private Subnet-2 with Private Route Table-2
resource "aws_route_table_association" "pri-rta-2" {
  subnet_id = var.private_cidrs[1]
  route_table_id = aws_route_table.pri-rt-2.id
}

