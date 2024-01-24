terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "~> 1.4"
    }
  }
}

locals {
  op_account = "my.1password.com"
  op_vault   = "Personal"
  op_item    = "Example-New"
  op_section = "Tokens"
  op_field   = "api-token"
}

provider "onepassword" {
  account = local.op_account
}

data "onepassword_vault" "vault" {
  name = local.op_vault
}

module "op_get_secret" {
  source     = "../../"
  vault_uuid = data.onepassword_vault.vault.uuid
  item       = local.op_item
  section    = local.op_section
  field      = local.op_field
}

output "value" {
  value     = module.op_get_secret.value
  sensitive = true
}
