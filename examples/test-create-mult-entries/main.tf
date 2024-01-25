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

  item_list = yamldecode(file("${path.module}/items.yaml"))

  default_username = "test@example.com"
  default_password = "supersecretpassword"
}

provider "onepassword" {
  account = local.op_account
}

# each onepassword_vault data-block requires seperate 1password 2FA auth
#   open before iterating items to prevent multiple auth requests
data "onepassword_vault" "vault" {
  name = local.op_vault
}

resource "onepassword_item" "example" {
  for_each = local.item_list

  vault    = data.onepassword_vault.vault.uuid
  category = try(each.value.category, "login")

  title    = each.value.item
  url      = try(each.value.url, "")
  username = try(each.value.username, local.default_username)
  password = try(each.value.password, local.default_password)

  section {
    label = each.value.section

    field {
      label = each.value.field
      type  = "CONCEALED"
      value = each.value.field_value
    }
  }
}

