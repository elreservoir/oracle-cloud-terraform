resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

locals {
  compartment_id = oci_identity_compartment._.id
  authorized_keys = [chomp(tls_private_key.ssh.public_key_openssh)]
}
