resource "aws_instance" "myec2" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  #security_groups = ["aws_security_group.ssh.id", "aws_security_group.web.id"]
  vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.web.id]

  tags = {
    Name = "test-ec2"
  }
}