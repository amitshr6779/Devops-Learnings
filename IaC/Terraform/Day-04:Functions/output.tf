output "tag" {
 value =  local.tags
}

output "st_name" {
    value = local.formatted_sa_name
  
}

output "ports" {
  value = local.ports
}

output "nsg_ports" {
value = local.nsg_ports  
}

output "vm_size" {
    value = local.vm_size
  
}

output "vm_name" {
  value = var.vm_name
}

output "config_status" {
  value = local.config_exists ? "File exists" : "File missing"
}

//variable as sensitive to prevent exposure.
output "json_content" {
    //value =  local.config_parsed
    //sensitive = true
    value = nonsensitive(local.config_parsed)

  
}