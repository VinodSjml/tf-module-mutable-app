resource "aws_lb_listener" "private" {
    count           = var.INTERNAL ? 1 : 0
  load_balancer_arn = aws_lb.alb_private.ALB_ARN
  port              = "80"
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_lb_listener_rule" "private_lb_listner_rule" {
    count      = var.INTERNAL ? 1 : 0
  listener_arn = aws_lb_listener.private.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  condition {
    host_header {
      values = ["${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_NAME}"]
    }
  }
}

resource "aws_lb_listener" "public" {
   count           = var.INTERNAL ? 0 : 1
  load_balancer_arn = aws_lb.alb_public.ALB_ARN
  port              = "80"
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}