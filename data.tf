data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Devops-labimage-centos7-ansible"
  owners           = ["self"]
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "cdtf-state"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}