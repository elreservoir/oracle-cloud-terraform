terraform {
  backend "http" {
    # The address will be provided by GitLab CI
  }

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "6.35.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "4.8.0"
    }
  }
}

provider "oci" {
  tenancy_ocid = data.vault_kv_secret_v2.oracle-cloud_secrets.data["TENANCY_OCID"]
  user_ocid = data.vault_kv_secret_v2.oracle-cloud_secrets.data["USER_OCID"]
  region = data.vault_kv_secret_v2.oracle-cloud_secrets.data["REGION"]
  private_key = data.vault_kv_secret_v2.oracle-cloud_secrets.data["PRIVATE_KEY"]
  fingerprint = data.vault_kv_secret_v2.oracle-cloud_secrets.data["FINGERPRINT"]
}

provider "vault" {
  address = var.vault_address
  token = var.vault_token
  skip_tls_verify = true
}