# VPC ID
output "vpc_id" {
  value = aws_vpc.vpc.id
}

# Public Subnets Ids
output "pub_sub_ids" {
  value = aws_subnet.pub_sub[*].id
}

# Private Subnets Ids
output "pri_sub_ids" {
  value = aws_subnet.pri_sub[*].id
}

# Database Subnets Ids
output "db_sub_ids" {
  value = aws_subnet.db-pri-sub[*].id
}

# Internet Gatewat ID
output "igw_id" {
  value = aws_internet_gateway.igw.id
}

# Name(Project) to be used in other module
output "name" {
  value = var.name
}