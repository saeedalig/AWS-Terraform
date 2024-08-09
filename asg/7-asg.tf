
################################################################
# Launch Template for EC2 Instances
################################################################
resource "aws_launch_template" "ec2_launch_template" {
  name = "${local.env}-${local.app}-ec2-lt"

  image_id      = "ami-013e83f579886baeb" //Copy the ami id from aws console
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  # USER DATA
  # user_data = filebase64("userdata.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.env}-${local.app}-ec2-lt"
    }
  }
}

################################################################
# Auto Scaling Group
################################################################
resource "aws_autoscaling_group" "asg" {
  name = "${local.env}-${local.app}-asg"

  desired_capacity = 2
  min_size         = 2
  max_size         = 3

  target_group_arns   = [aws_lb_target_group.alb_ec2_tg.arn]
  vpc_zone_identifier = aws_subnet.private_subnets[*].id
  health_check_type   = "EC2"

  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

}












