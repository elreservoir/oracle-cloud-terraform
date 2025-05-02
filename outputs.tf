resource "vault_kv_secret_v2" "add_secrets" {
  mount = "kv"
  name  = "oracle-cloud/generated"

  delete_all_versions = true

  data_json = jsonencode(
    merge(
        {
            SSH_PRIVATE_KEY = tls_private_key.ssh.private_key_pem
            SSH_PUBLIC_KEY = tls_private_key.ssh.public_key_openssh
            IP_ADDRESS_i = i.public_ip
        },
        {
            for idx, inst in sort(oci_core_instance._) :
            "IP_ADDRESS_${idx + 1}" => inst.public_ip
        }
    )
  )
}
