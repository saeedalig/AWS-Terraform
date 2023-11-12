output "vpc_id" {
  value = aws_vpc.myvpc.id
}


output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

# Internet Gateway
output "igw_id" {
  value = aws_internet_gateway.igw
}
