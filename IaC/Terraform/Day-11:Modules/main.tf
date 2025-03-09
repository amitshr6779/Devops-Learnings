resource "azurerm_resource_group" "rg1" {
  name     = var.rg_name
  location = var.locations[0]
}

module "service_principal" {
  source                 = "./modules/service_principal"
  service_principal_name = var.service_principal_name

  depends_on = [
    azurerm_resource_group.rg1
  ]

}

resource "azurerm_role_assignment" "rolespn" {

  scope                = "/subscriptions/${var.SUB_ID}"
  role_definition_name = "Contributor"
  principal_id         = module.service_principal.service_principal_object_id

  depends_on = [
    module.service_principal
  ]
}

module "aks" {
  source = "./modules/aks"
  client_id              = var.client_id
  client_secret          = var.client_secret
  locations               = var.locations[0]
  rg_name    = var.rg_name
  
}

resource "local_file" "kubeconfig" {
  depends_on   = [module.aks]
  filename     = "./kubeconfig"
  content      = module.aks.config
  
}

module "key-vault" {
    source = "./modules/key-vault"
    kv_name =  "sotestkvpoc6779"
    locations = var.locations[0]
    rg_name =   var.rg_name  
    client_id = module.service_principal.client_id
    client_secret = module.service_principal.client_secret

    depends_on = [ module.service_principal ]
}