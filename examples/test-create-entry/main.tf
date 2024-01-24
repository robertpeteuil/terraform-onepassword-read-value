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
  # values below are populated into the 1pasword item
  op_item        = "Example-Test"
  op_section     = "Tokens"
  op_field       = "api-token"
  value_username = "test@example.com"
  value_password = "supersecretpassword"
  value_field    = "11111111"
}

provider "onepassword" {
  account = local.op_account
}

# each onepassword_vault data-block requires 1password 2FA auth
data "onepassword_vault" "vault" {
  name = local.op_vault
}

resource "onepassword_item" "example" {
  vault    = data.onepassword_vault.vault.uuid
  category = "login"

  title    = local.op_item
  username = local.value_username
  password = local.value_password

  section {
    label = local.op_section

    field {
      label = local.op_field
      type  = "CONCEALED"
      value = local.value_field
    }
  }
}

