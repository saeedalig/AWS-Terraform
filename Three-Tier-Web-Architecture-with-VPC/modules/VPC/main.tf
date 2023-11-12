# Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.business_divsion}-${var.environment}-vpc"
  }
}

# Create Public Subnets
resource "aws_subnet" "public_subnets" {
  count = length(var.public_cidrs)
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public_cidrs[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
     #Name = "${var.business_divsion}-${var.environment}-public-subnet"
    Name = "Public-Subnet-${count.index + 1}"
  }
}

# Create Private Subnets
resource "aws_subnet" "private_subnets" {
  count = length(var.private_cidrs)
  vpc_id     = aws_vpc.myvpc.id
  #cidr_block = var.private_cidrs[count.index]
  cidr_block = element(var.private_cidrs, count.index)

  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
     #Name = "${var.business_divsion}-${var.environment}-public-subnet"
    Name = "Private-Subnet-${count.index + 1}"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

# Create a Route Table for Public Subnets
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public Route Table"
  }
}

# Associate Route Table with Public Subnets 
resource "aws_route_table_association" "rta" {
  count = length(var.public_cidrs)
  #subnet_id      = aws_subnet.public_subnets.*.id[count.index]
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.rt.id
}












