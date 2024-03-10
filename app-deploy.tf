resource "null_resource" "app" {
  count = local.INSTANCE_COUNT
  connection {
    type     = "ssh"
    user     = local.SSH_USER
    password = local.SSH_PASSWORD
    host     = element(local.INSTANCE_PRIVATE_IPS, count.index)
  }

  provisioner "remote-exec" {
    inline = [
       "sleep 30", 
      "ansible-pull -U https://github.com/VinodSjml/ansible.git -e env=${var.ENV} -e APP_VERSION=${var.APP_VERSION} -e component=${var.COMPONENT} roboshop-pull.yml"
    ]
  }
}
