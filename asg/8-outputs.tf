output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}


output "databasec_subnet_ids" {
  value = aws_subnet.database_subnets[*].id
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}
