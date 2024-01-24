
terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "~> 1.4"
    }
  }
}

data "onepassword_item" "opitem" {
  vault = var.vault_uuid
  title = var.item
}

locals {
  section_index  = index(data.onepassword_item.opitem.section.*.label, var.section)
  section_fields = tolist(data.onepassword_item.opitem.section)[local.section_index].field
  field_index    = index(local.section_fields.*.label, var.field)
  field_value    = sensitive(local.section_fields[local.field_index].value)
}
