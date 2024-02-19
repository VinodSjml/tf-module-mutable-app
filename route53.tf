resource "aws_route53_record" "docdb_dns" {
  zone_id = var.INTERNAL ? data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID : data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTED_ZONE_ID
  name    = var.INTERNAL ? "${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_NAME}" : "${var.COMPONENT}-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTED_ZONE_NAME}"
  type    = "CNAME"
  ttl     = 10
  records = var.INTERNAL ? data.terraform_remote_state.alb_private.PRIVATE_ALB_ADDRESS : data.terraform_remote_state.alb_public.PUBLIC_ALB_ADDRESS
}