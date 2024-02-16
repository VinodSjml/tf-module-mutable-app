# create spot instance
resource "aws_spot_instance_request" "spot" {
  count                = var.SPOT_INSTANCE_COUNT
  ami                  = data.aws_ami.ami.name
  instance_type        = var.SPOT_INSTANCE_TYPE 
  wait_for_fulfillment = true
  subnet_id            = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
  vpc_security_group_ids = [aws_security_group.allows_app.id]
}

# created OD instamces
resource "aws_instance" "od" {
 count                 = var.OD_INSTANCE_COUNT
  ami                  = data.aws_ami.ami.name
  instance_type        = var.OD_INSTANCE_TYPE 
  subnet_id            = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
  vpc_security_group_ids = [aws_security_group.allows_app.id]
}

resource "tags" "name" {
  count = locals.INSTANCE_COUNT
  resource_id = element(locals.INSTANCE_IDS, count.index)
  name = "${var.COMPONENT}-${var.ENV}"
}