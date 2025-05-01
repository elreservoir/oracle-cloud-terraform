
resource "null_resource" "install_config" {
  for_each = oci_core_instance._

  provisioner "file" {
    source      = "./resources/install_k3s.sh"
    destination = "/home/docker/install.sh"

    connection {
      type = "ssh"
      user = "docker"
      host = each.value.public_ip
      private_key  = tls_private_key.ssh.private_key_pem
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/docker/install.sh",
    ]

    connection {
      type = "ssh"
      user = "docker"
      host = each.value.public_ip
      private_key  = tls_private_key.ssh.private_key_pem
    }
  }
}
