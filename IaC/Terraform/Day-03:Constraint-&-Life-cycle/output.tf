
//output "storage_account" {
  //value = [for i in  azurerm_storage_account.example : i.name]
//}

# Output the security rules
output "security_rules" {
  value = azurerm_network_security_group.example.security_rule
}

output "demo" {
  value = [ for count in local.nsg_rules : count.description ]
}


//Splat expressions work directly on lists.
output "splat" {
  value = var.list_storage_account_name[*]
}