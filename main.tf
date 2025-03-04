provider "azurerm" {
  subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  features {}
}

resource "azurerm_resource_group" "labTerraform" {
  name     = "labs_plataformas_rg"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "slaks1" {
  name                = "sl-aks1"
  location            = azurerm_resource_group.labTerraform.location
  resource_group_name = azurerm_resource_group.labTerraform.name
  dns_prefix          = "sl1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "test"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.slaks1.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.slaks1.kube_config_raw

  sensitive = true
}