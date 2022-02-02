terraform {
  required_version = ">= 0.14"
  required_providers {

    azurerm = {
      source = "hashicorp/azurerm"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }

    helm = {
      source = "hashicorp/helm"
    }

  }
}
