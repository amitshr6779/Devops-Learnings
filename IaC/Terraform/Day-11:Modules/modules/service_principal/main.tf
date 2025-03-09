data "azuread_client_config" "current" {}

resource "azuread_application" "main" {
  display_name = var.service_principal_name
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "main" {
  app_role_assignment_required = true
  client_id = azuread_application.main.client_id
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "main" {
  service_principal_id = azuread_service_principal.main.id
}




/*
resource "azuread_application_registration" "example" {
  display_name = "test-poc-app"
}

resource "azuread_application_password" "example" {
  application_id = azuread_application_registration.example.id
}
*/
