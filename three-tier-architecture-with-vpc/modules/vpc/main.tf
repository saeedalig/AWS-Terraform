# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.name}-vpc"
  }
}

# Public Subnets
resource "aws_subnet" "pub_sub" {
  count = length(var.pub_sub-cidrs)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.pub_sub-cidrs, count.index)
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "${var.name}-pub-sub-az${count.index + 1}"
  }
}

# Private Subnets
resource "aws_subnet" "pri_sub" {
  count = length(var.pri_sub-cidrs)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.pri_sub-cidrs, count.index)
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  tags = {
    Name = "${var.name}-pri-sub-az${count.index + 1}"
  }
}

# Database Subnets
resource "aws_subnet" "db-pri-sub" {
  count = length(var.db_sub_cidrs)
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.db_sub_cidrs, count.index)
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  tags = {
    Name = "${var.name}-db-sub-az${count.index + 1}"
  }
}

# Create Internet Gateway to attach VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-IGW"
  }
}

# Create a Route Table for Public Subnets
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.name}-Pub-RT"
  }
}

# Create a Route Table Association for Public Route Table
resource "aws_route_table_association" "pub-rta" {
  count = length(var.pub_sub-cidrs)
  subnet_id = element(aws_subnet.pub_sub[*].id, count.index)
  route_table_id = aws_route_table.pub-rt.id
}
