# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
# Create target group
resource "aws_lb_target_group" "front-prod" {
  name     = "application-front-prod"
  target_type = "ip"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
# Attached Target Group with first instance
resource "aws_lb_target_group_attachment" "attach-app1" {
  # count            = length(aws_instance.app-server)
  target_group_arn = aws_lb_target_group.front-prod.arn
  target_id        = var.server_private_ip
  port             = 80
}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
# Attached Target Group with second instance
# resource "aws_lb_target_group_attachment" "attach-app2" {
#   # count            = length(aws_instance.app-server)
#   target_group_arn = aws_lb_target_group.front.arn
#   target_id        = var.server_private_ip_2
#   port             = 80
# }
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
# Create Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front-prod.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front-prod.arn
  }
}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
# Create resource alb
resource "aws_lb" "front-prod" {
  name               = "front-prod"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.securitygroups_id
  subnets            = [var.subnetId, var.subnetId_1b]

  enable_deletion_protection = false

  tags = {
    Environment = "front"
  }
}