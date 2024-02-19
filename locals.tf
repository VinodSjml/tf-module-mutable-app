locals {
  INSTANCE_COUNT = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
  INSTANCE_IDS   = concat(aws_instance.od.*.id, aws_spot_instance_request.spot.*.spot_instance_id)
  INSTANCE_PRIVATE_IPS = concat(aws_instance.od.*.private_ip, aws_spot_instance_request.spot.*.private_ip)
  SSH_USER       = "centos"
  SSH_PASSWORD   = "DevOps321"
}