
################################
# Data block for azs
################################

data "aws_availability_zones" "azs" {
  state = "available"
}

################################
# Public Subnets
################################


resource "aws_subnet" "backend_public_subnets" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.backend_vpc.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "public-subnet-${data.aws_availability_zones.azs.names[count.index]}"
  }
}

################################
# Private Subnets
################################
resource "aws_subnet" "backend_private_subnets" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.backend_vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "private-subnet-${data.aws_availability_zones.azs.names[count.index]}"
  }
}

################################
# Database Subnets
################################

resource "aws_subnet" "backend_database_subnets" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.backend_vpc.id
  cidr_block        = var.databasee_subnets[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "database-subnet-${data.aws_availability_zones.azs.names[count.index]}"
  }
}