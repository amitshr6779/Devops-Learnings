data "azurerm_kubernetes_service_versions" "current" {
  location = var.locations
  include_preview = false  
}
 

resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                  = "poc-aks-cluster"
  location              = var.locations
  resource_group_name   = var.rg_name
  dns_prefix            = "${var.rg_name}-cluster"           
  kubernetes_version    =  data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${var.rg_name}-nrg"
  
  default_node_pool {
    name       = "defaultpool"
    vm_size    = "Standard_DS2_v2"
    zones   = [1, 2, 3]
    auto_scaling_enabled = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = "prod"
      "nodepoolos"       = "linux"
     } 
   tags = {
      "nodepool-type"    = "system"
      "environment"      = "prod"
      "nodepoolos"       = "linux"
   } 
  }

  service_principal  {
    client_id = var.client_id
    client_secret = var.client_secret
  }

# to do: generate the ssh keys using tls_private_key
# upload the key to key vault

linux_profile {
  admin_username = "ubuntu"
  ssh_key {
    key_data = file("~/.ssh/id_rsa.pub")
  }
}


  network_profile {
      network_plugin = "azure"
      load_balancer_sku = "standard"
  }

    
  }