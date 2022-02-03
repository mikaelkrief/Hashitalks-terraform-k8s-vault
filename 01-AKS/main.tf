

############################################################
# PROVIDERS
############################################################

provider "azurerm" {
  features {}
}







############################################################
# RESOURCES
############################################################


# Create the AKS cluster

resource "azurerm_resource_group" "aks" {
  name     = "${var.prefix}-aks"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "vault" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.prefix
  kubernetes_version  = var.aks_version

  default_node_pool {
    name               = "default"
    node_count         = 3
    vm_size            = var.agents_size
    type               = "VirtualMachineScaleSets"
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  identity {
    type                      = "SystemAssigned"
  }
}



############################################################
# OUTPUTS
############################################################

output "aks_resource_group" {
  value = azurerm_kubernetes_cluster.vault.resource_group_name
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.vault.name
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.vault.node_resource_group
}
