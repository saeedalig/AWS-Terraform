# Create Security Group  for the Application Load Balancer
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "enable http/https access on port 80/443"
  vpc_id      = var.vpc_id

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "https access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "${var.name}-alb-sg"
  }
}

# Create security group for the bastion host
resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Security group for bastion host"
   vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "${var.name}-bastion-sg"
  }
}