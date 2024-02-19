resource "aws_route53_record" "alb_route53" {
  zone_id = var.INTERNAL ? data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID : data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTED_ZONE_ID
  name    = "${var.COMPONENT}-${var.ENV}"
  type    = "CNAME"
  ttl     = 10
  records = var.INTERNAL ? [data.terraform_remote_state.alb_private.outputs.PRIVATE_ALB_ADDRESS] : [data.terraform_remote_state.alb_public.outputs.PUBLIC_ALB_ADDRESS]
}