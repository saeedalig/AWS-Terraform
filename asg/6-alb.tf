
################################################################
# Application Load Balancer
################################################################
resource "aws_lb" "alb" {
  name               = "${local.env}-${local.app}-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnets[*].id
  depends_on         = [aws_internet_gateway.igw]
}

################################################################
# Target Group for ALB
################################################################
resource "aws_lb_target_group" "alb_ec2_tg" {
  name     = "${local.env}-${local.app}-alb-ec2-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  # health check (cost associated)
  # health_check {
  #   path                = "/health"
  #   interval            = 30
  #   timeout             = 5
  #   healthy_threshold   = 2
  #   unhealthy_threshold = 2
  # }

  tags = {
    Name = "${local.env}-${local.app}-alb-ec2-tg"
  }
}

################################################################
# Listner for ALB
################################################################
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  }
  tags = {
    Name = "${local.env}-${local.app}-alb-listener"
  }
}