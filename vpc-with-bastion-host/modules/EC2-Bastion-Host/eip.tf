# Elastic IP for Bastion Host
resource "aws_eip" "eip-bastion" {
  instance = aws_instance.bastion_host.id
  domain   = "vpc"
  tags = {
    Name = "${var.name}-EIP-Bastion"
  }
  depends_on = [ aws_instance.bastion_host, var.vpc_id ]
}

