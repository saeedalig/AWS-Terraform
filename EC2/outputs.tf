# EC2 Instance Public IP
output "public_ip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.myec2.public_ip
}

# EC2 Instance Public DNS
output "public_dns" {
  description = "EC2 Instance Public DNS"
  value       = aws_instance.myec2.public_dns
}