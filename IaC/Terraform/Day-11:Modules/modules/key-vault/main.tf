data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
    name = var.kv_name
    location = var.locations
    resource_group_name = var.rg_name
    enable_rbac_authorization = false
    enabled_for_disk_encryption = true
    tenant_id = data.azurerm_client_config.current.tenant_id
    purge_protection_enabled = false
    soft_delete_retention_days = 7
    sku_name = "standard"
  
}


resource "azurerm_key_vault_secret" "secrets" {
    name = var.client_id
    value = var.client_secret
    key_vault_id =  resource.azurerm_key_vault.kv.id
    depends_on = [ azurerm_key_vault_access_policy.spn_access ]
}


resource "azurerm_key_vault_access_policy" "spn_access" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    =  data.azurerm_client_config.current.object_id  # Service Principal ID

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover", "Purge"
  ]
}
