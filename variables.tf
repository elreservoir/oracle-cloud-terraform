variable "name" {
  type    = string
  default = "k3s-remote"
}

variable "shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "how_many_nodes" {
  type    = number
  default = 1
}

variable "availability_domain" {
  type    = number
  default = 0
}

variable "ocpus_per_node" {
  type    = number
  default = 4
}

variable "memory_in_gbs_per_node" {
  type    = number
  default = 24
}

/*
 * Hashicorp Vault credentials
 */

variable "vault_token" {
  type = string
  sensitive = true
}

variable "vault_address" {
  type = string
  sensitive = true
}

/*
 * Load secrets from Hashicorp Vault
 */

data "vault_kv_secret_v2" "oracle-cloud_secrets" {
  mount = "kv"
  name = "oracle-cloud/provided"
}