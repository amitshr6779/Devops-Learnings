//endswith function to validate string  ends with particulr string
variable "project_name" {
    type = string
    default = "Project Alpha Resource"
    validation{
        condition = endswith(var.project_name, "Resource")
        error_message = "Resource name must end with Resource word"
    }
  
}

variable "def_tags" {
    type =  map(string)
    default = {
      "env" = "tf"
    }
  
}

variable "custom_tags" {
    type =  map(string)
    default = {
      "for" = "poc"
    }
}

variable "storage_account_name" {

    type = string
    default = "Tech Tutorials!@#"
  
}

variable "allowed_ports" {
  type = string
  default = "80,443,3306"
}

variable "environment" {
    type = string
    default = "dev"
    validation {
        condition = contains(["dev", "staging", "prod"], var.environment)
        error_message = "Enter a valid environment (dev, staging, prod)."
    }  
}

variable "vm_size" {
    type = map(string)
    default = {
    dev      = "Standard_D2s_v3"
    staging  = "Standard_D4s_v3"
    prod     = "Standard_D8s_v3"
    }
}

//Use the strcontains function to ensure the  specific string contains 
//Use the length function to check the character limit.
variable "vm_name" {
    type = string
    default = "test-poc"
    validation {
      condition = length(var.vm_name) >= 2 &&  length(var.vm_name) <=10 && strcontains(var.vm_name, "-poc")
      error_message = "please provide correct name , having name endswith -poc"
    }
}


