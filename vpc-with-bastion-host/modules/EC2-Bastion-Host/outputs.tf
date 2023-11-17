
output "eip_bastion_public_ip" {
  value = aws_eip.eip-bastion.public_ip
}

# Instance ID
output "ec2_bastion_pub_id" {
  value = aws_instance.bastion_host.id
}