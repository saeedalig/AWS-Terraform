# Create bastion host EC2 instance
resource "aws_instance" "bastion_host" {
  ami           = data.aws_ami_ids.amzn-linux.id           # Amazon Linux AMI, change to your desired AMI
  instance_type = var.instance_type                         # Change to your desired instance type
  subnet_id     = var.pub_sub_ids[1]
  key_name      = var.keypair
  vpc_security_group_ids = [var.bastion_sg_id]

  tags = {
    Name = "${var.name}-bastion-host-EC2"
  }
}