############################################################
# VARIABLES
############################################################

variable "location" {
  type    = string
  default = "westeurope"
}

variable "vaultui_domain_label" {
  type = string
  default = "vaultdemo1"
}

variable "vault_image_tag" {
  type = string
  default = "1.9.2"
}