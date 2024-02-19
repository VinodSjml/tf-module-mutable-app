resource "aws_lb_target_group" "app" {
  name        = "${var.COMPONENT}-${var.ENV}-tg"
  target_type = "ip"
  port        = 80
  protocol    = "TCP"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID
}

resource "aws_lb_target_group_attachment" "app" {
    count          = local.INSTANCE_COUNT
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = element(local.INSTANCE_PRIVATE_IPS, count.index)
  port             = 80
}