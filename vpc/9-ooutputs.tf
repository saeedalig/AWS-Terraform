output "vpc_id" {
  value = aws_vpc.backend_vpc.id
}

output "private_subnet_ids" {
  value = aws_subnet.backend_private_subnets[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.backend_public_subnets[*].id
}