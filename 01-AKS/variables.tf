############################################################
# VARIABLES
############################################################

variable "location" {
  type    = string
  default = "westeurope"
}

variable "agents_size" {
  type    = string
  default = "Standard_B2s"
}

variable "prefix" {
  type    = string
  default = "vaultdemo"
}


variable "aks_version" {
  type = string
  default = "1.20.13"
}

variable "vaultui_domain_label" {
  type = string
  default = "vaultdemo1"
}

variable "resource_group_kv" {
  type = string
  default = "rg_kv-vaultdemo"
}