
################################################################
#. Security Group for ALB (Internet -> ALB)
################################################################
resource "aws_security_group" "alb_sg" {
  name        = "${local.env}-${local.app}-alb-sg"
  description = "Security Group for Application Load Balancer"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.env}-${local.app}-alb-sg"
  }
}


################################################################
# Security Group for EC2 Instances (ALB -> EC2)
################################################################
resource "aws_security_group" "ec2_sg" {
  name        = "${local.env}-${local.app}-ec2-sg"
  description = "Security Group for Web Server Instances"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.env}-${local.app}-ec2-sg"
  }
}