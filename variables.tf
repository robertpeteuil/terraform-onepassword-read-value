
variable "vault_uuid" {
  description = "1Password Vault UUID"
  type        = string
}

variable "item" {
  description = "1Password Item containing secret"
  type        = string
}

variable "section" {
  description = "1Password Section within Item"
  type        = string
}

variable "field" {
  description = "1Password Feidl within Section in Item"
  type        = string
}