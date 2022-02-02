



data "azurerm_kubernetes_cluster" "cluster" {
  name                = data.terraform_remote_state.aks.outputs.aks_name
  resource_group_name = data.terraform_remote_state.aks.outputs.aks_resource_group
}

resource "azurerm_public_ip" "vault-ip" {
  allocation_method = "Static"
  location = var.location
  name = "VaultIP"
  resource_group_name = data.terraform_remote_state.aks.outputs.node_resource_group
  domain_name_label = var.vaultui_domain_label
  sku = "Standard"
}


# create the Vault namespace
resource "kubernetes_namespace" "ns" {
  metadata {
    name = "vault"
    labels = {
      name = "vault"
    }
  }
}

# deploy vault helm chart
resource "helm_release" "vault" {
  name       = "vault"
  repository = "hashicorp"
  chart      = "hashicorp/vault"
  namespace = kubernetes_namespace.ns.metadata[0].name
  version = "0.18.0"
  create_namespace = true
  wait = true

  values = [
    file("${path.module}/override-values.yml")
  ]

  set {
    name  = "ui.loadBalancerIP"
    value = azurerm_public_ip.vault-ip.ip_address
  }

  set {
    name  = "injector.enabled"
    value = false
  }

  set {
    name  = "csi.enabled"
    value = true
  }

}


output "vaultUrl" {
  value = "http://${azurerm_public_ip.vault-ip.fqdn}:8200"
}