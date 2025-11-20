variable "apim_name" {
    type = string
    default = "apim-poc-iris"
  
}

variable "resource_group_name" {
    type = string
    default = "infra-poc"
}


variable "apim_sku_name" {
    type = string
    default = "Developer_1"
  
}

variable "locations" {
    type = list(string)
    default = [ "southcentralus", "northcentralus", "eastus" , "westus2"]
  
}

variable "rg_name" {
    type = string
    default = "infra-poc-rg"
  
}

variable "vnet1_name" {
    type = string
    default = "infra-poc1"
  
}

variable "subnet1_name" {
    type = string
    default = "infra-poc1"
  
}



variable "network_config" {
    type = tuple([ string, string, string, string ,number ])
    default = [ "10.0.0.0/16", "10.0.1.0", "10.1.0.0/16", "10.1.1.0", 24 ]
}

variable "allowed_ports" {
  type = string
  default = "80,443,3306,22"
}

variable "allowed_protocol" {
  type = string
  default = "Tcp,Tcp,Rdp,Ssh"
}

variable "nsg1_name" {
    type = string
    default = "Vm1-app"
  
}


variable "api_management_named_values" {
  description = "A map of named value configurations for API Management."
  type = map(object({
    display_name = string
    value        = string
    secret       = bool
  }))

  default = {
    "MyApiKeyName" = {
      display_name = "APIKEY"
      value        = "your-api-key-value-here"
      secret       = true # Consider making actual API keys secret
    }
    # Example 2: A secret named value (e.g., for a password or connection string)
    "DbConnectionString" = {
      display_name = "Database"
      value        = "Server=tcp:myserver.database.windows.net;Initial Catalog=mydb;Persist Security Info=False;User ID=myuser;Password=mypassword;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
      secret       = true
    }
    # Example 3: Another non-secret value
    "ServiceEndpointUrl" = {
      display_name = "ServiceURL"
      value        = "https://api.example.com/v1"
      secret       = false
    }
    # Add more named values as needed
  }
}



