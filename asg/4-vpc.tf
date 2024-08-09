
################################################################
# VPC
################################################################
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.env}_${local.app}_vpc"
  }
}


################################################################
# Internet Gateway
################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.env}_${local.app}_igw"
  }
}


################################################################
# Data block for azs
################################################################
data "aws_availability_zones" "azs" {
  state = "available"
}

################################################################
# Public Subnets
################################################################
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "public-subnet-${data.aws_availability_zones.azs.names[count.index]}"
  }
}

################################################################
# Private Subnets
################################################################
resource "aws_subnet" "private_subnets" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "private-subnet-${data.aws_availability_zones.azs.names[count.index]}"
  }
}

################################################################
# Database Subnets
################################################################
resource "aws_subnet" "database_subnets" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.databasee_subnets[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "database-subnet-${data.aws_availability_zones.azs.names[count.index]}"
  }
}

################################################################
# EIP
################################################################
resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "${local.env}-${local.app}-eip"
  }
}

################################################################
# NAT Gateway
################################################################
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${local.env}-${local.app}-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

################################################################
# Private Route Table
################################################################
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${local.env}-${local.app}-private-rt"
  }
}

################################################################
# Public Route Table
################################################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.env}-${local.app}-public-rt"
  }
}

################################################################
# Private Route Table Associations
################################################################
resource "aws_route_table_association" "private_rta" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}


################################################################
# Public Route Table Associations
################################################################
resource "aws_route_table_association" "public_rta" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

################################################################
# Database Route Table Associations
################################################################
resource "aws_route_table_association" "database_rta" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.database_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}