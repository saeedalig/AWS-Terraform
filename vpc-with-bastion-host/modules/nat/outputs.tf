# ID of the NAT Gateways
output "nat_az1_id" {
  value = aws_eip.eip_nat.id
}

# Elastic IP address associated with the NAT Gateways
output "eip_nat_az1_pubIP" {
  value = aws_eip.eip_nat.public_ip
}

