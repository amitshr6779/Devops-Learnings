//To View All Attributes fetched dynamically
output "resource_group_details" {
  value = data.azurerm_resource_group.rg_shared
}
