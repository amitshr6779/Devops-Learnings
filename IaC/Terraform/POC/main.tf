locals {
  function_apps = {
    func1 = {
      name         = "example-function-app6779"
      saname        = "examplesapoc"
      code_folder  = "${path.module}/function-code/app"
    }
    func2 = {
      name         = "demo-function-app6779"
      saname        = "demosapoc"
      code_folder  = "${path.module}/function-code/app"
    }
  }
}


resource "azurerm_storage_account" "example" {
  for_each    = local.function_apps
  name                = each.value.saname
  resource_group_name = var.resource_group_name
  location            = var.locations[0]
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_service_plan" "example" {
  name                = "example-service-plan"
  resource_group_name = var.resource_group_name
  location            = var.locations[0]
  os_type             = "Windows"
  sku_name            = "S1"
}


resource "azurerm_windows_function_app" "apps" {

  for_each = local.function_apps

  name                = each.value.name  
  resource_group_name = var.resource_group_name
  location            = var.locations[0]
  service_plan_id     = azurerm_service_plan.example.id

  storage_account_name       =  azurerm_storage_account.example[each.key].name
  storage_account_access_key =  azurerm_storage_account.example[each.key].primary_access_key

  app_settings = {

    ENV = "test"
  }
  
  site_config {
    application_stack {
      dotnet_version = "v8.0"
    }
  }
}


data "archive_file" "function_package" {
  for_each    = local.function_apps
  type        = "zip"
  source_dir  = each.value.code_folder
  output_path = "${path.module}/functionapp_${each.key}.zip"
}


resource "null_resource" "deploy_function_code" {

  for_each = local.function_apps

  triggers = {
    source_hash = data.archive_file.function_package[each.key].output_base64sha256
  }

  depends_on = [
    azurerm_windows_function_app.apps,
    data.archive_file.function_package
  ]

  provisioner "local-exec" {
    command = <<EOT
      az functionapp deployment source config-zip \
        --resource-group ${var.resource_group_name} \
        --name ${azurerm_windows_function_app.apps[each.key].name} \
        --src ${data.archive_file.function_package[each.key].output_path}
    EOT
  }
}

data "azurerm_function_app_host_keys" "hostkeys" {
  for_each = azurerm_windows_function_app.apps

  name                = each.value.name
  resource_group_name = var.resource_group_name
}

output "master_key" {
  value = data.azurerm_function_app_host_keys.hostkeys["func1"].primary_key
  sensitive = true
}





resource "azurerm_api_management" "main_apim" {
  name                = var.apim_name
  resource_group_name = var.resource_group_name
  location            = var.locations[0]
  publisher_name      = "My Company"
  publisher_email     = "company@terraform.io"
  sku_name            = var.apim_sku_name # e.g., "Developer_1" or "Standard_1"

}


/*
resource "azurerm_api_management_named_value" "example" {
  name                = "example-apimg"
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.main_apim.name
  display_name        = "ExampleProperty"
  value               = "Example Value"
  secret = true
}
*/


resource "azurerm_api_management_named_value" "api_named_values" {
  for_each = data.azurerm_function_app_host_keys.hostkeys

  name                = each.value.name
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.main_apim.name

  # Access the properties defined in the map object
  display_name        = each.value.name
  value               = each.value.primary_key
  secret              = true
}

resource "azurerm_api_management_product" "example" {
  product_id            = "test-product"
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.main_apim.name
  display_name          = "Test Product"
  subscription_required = true
  published             = true
}

resource "azurerm_api_management_policy_fragment" "example" {
  api_management_id = azurerm_api_management.main_apim.id
  name              = "Inbound-Intake-dr"
  format            = "xml"
  value             = file("Inbound-intake-dr.xml")
}


resource "azurerm_api_management_api" "example" {
  name                = "example-api"
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.main_apim.name
  revision            = "1"
  display_name        = "Example API"
  path                = "example"
  protocols           = ["https"]

  import {
    content_format = "swagger-link-json"
    content_value  = "https://petstore.swagger.io/v2/swagger.json"
  }
}

resource "azurerm_api_management_api_operation" "example" {
  operation_id        = "user-delete"
  api_name            = azurerm_api_management_api.example.name
  api_management_name = azurerm_api_management.main_apim.name
  resource_group_name = var.resource_group_name
  display_name        = "Delete User Operation"
  method              = "DELETE"
  url_template        = "/users/{id}/delete"
  description         = "This can only be done by the logged in user."

  template_parameter {
    name     = "id"
    type     = "number"
    required = true
  }

  response {
    status_code = 200
  }
}


resource "azurerm_api_management_api" "d365" {
  name                = "termianl-api"
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.main_apim.name
  revision            = "1"
  display_name        = "terminal API"
  service_url =  "https://no-iris-payment-terminal-pdev-sc-func.azurewebsites.net"
  path                = "terminal"
  protocols           = ["https"]

  import {
    content_format = "openapi"
    content_value  = file("${path.module}/Terminal.openapi+json.json")
  }

}

resource "azurerm_api_management_product_api" "example" {
  api_name            = azurerm_api_management_api.d365.name
  product_id          = azurerm_api_management_product.example.product_id
  api_management_name = azurerm_api_management.main_apim.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_api_management_api_policy" "example" {
  api_name            = azurerm_api_management_api.d365.name
  api_management_name = azurerm_api_management.main_apim.name
  resource_group_name = var.resource_group_name

  xml_content = file("${path.module}/terminal-policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "ops_policy" {
  api_name            = azurerm_api_management_api.d365.name
  operation_id        = "post-postinvoicescarecreditsrefunds" 
  api_management_name = azurerm_api_management.main_apim.name
  resource_group_name = var.resource_group_name
  xml_content = file("${path.module}/ops-policy.xml")

}

resource "azurerm_api_management_api_operation_policy" "base-with_policy" {
  api_name            = azurerm_api_management_api.d365.name
  operation_id        = "post-postinvoicescomplete"
  api_management_name = azurerm_api_management.main_apim.name
  resource_group_name = var.resource_group_name
  xml_content = file("${path.module}/ops-policy-with-base.xml")

}

/* All APIs */

resource "azurerm_api_management_policy" "global_policy" {
  api_management_id = azurerm_api_management.main_apim.id 
  xml_content = file("${path.module}/global-policy.xml")
}





