resource "aws_lb_target_group" "app" {
  name        = "${var.COMPONENT}-${var.ENV}-tg"
  # target_type = "ip"
  port        = 80
  protocol    = "TCP"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  health_check {
    enabled             = true 
    healthy_threshold   = 2 
    interval            = 5 
    timeout             = 4
    path                = "/health"
    unhealthy_threshold = 2
    matcher             = "200"

  }
}

resource "aws_lb_target_group_attachment" "app" {
    count          = local.INSTANCE_COUNT
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = element(local.INSTANCE_IDS, count.index)
  port             = var.APP_PORT
}