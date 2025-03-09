/*
output "ad" {
    value =  module.service_principal.ad
  
}
*/



output "client_id" {
  description = "The application id of AzureAD application created."
  value       = module.service_principal.client_id
}

output "client_secret" {
  description = "Password for service principal."
  value       = module.service_principal.client_secret
  sensitive = true
  //value =    nonsensitive(module.service_principal.client_secret)

}

output "kube_config" {
    value = module.aks.config
    sensitive = true
  
}

/*
output "app_client_secret" {
  description = "Password for app service principal."
  value       =   module.service_principal.app_client_secret
  sensitive = true
 
}
*/
