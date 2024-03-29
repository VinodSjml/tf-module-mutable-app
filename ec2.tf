# create spot instance
resource "aws_spot_instance_request" "spot" {
  count                = var.SPOT_INSTANCE_COUNT
  ami                  = data.aws_ami.ami.image_id
  instance_type        = var.SPOT_INSTANCE_TYPE 
  wait_for_fulfillment = true
  subnet_id            = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index)
  vpc_security_group_ids = [aws_security_group.allows_app.id]
}

# created OD instamces
resource "aws_instance" "od" {
 count                 = var.OD_INSTANCE_COUNT
  ami                  = data.aws_ami.ami.image_id
  instance_type        = var.OD_INSTANCE_TYPE 
  subnet_id            = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index)
  vpc_security_group_ids = [aws_security_group.allows_app.id]
}

resource "aws_ec2_tag" "app_tags" {
  count                         = local.INSTANCE_COUNT

  resource_id                   = element(local.INSTANCE_IDS, count.index)
  key                           = "Name"
  value                         = "${var.COMPONENT}-${var.ENV}"
}