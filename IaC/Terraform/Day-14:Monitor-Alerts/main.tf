resource "azurerm_resource_group" "poc-test-rg" {
  name     = var.rg_name
  location = var.locations[0]
}

resource "azurerm_application_insights" "example" {
  name                = "example-ai"
  location            = azurerm_resource_group.poc-test-rg.location
  resource_group_name = azurerm_resource_group.poc-test-rg.name
  application_type    = "web"
}


resource "azurerm_application_insights_standard_web_test" "example" {
  name                    = "url-availability-test"
  location                = azurerm_resource_group.poc-test-rg.location
  resource_group_name     = azurerm_resource_group.poc-test-rg.name
  application_insights_id = azurerm_application_insights.example.id

  enabled = true

  frequency     = 300 # Runs every 5 minutes
  timeout       = 30  # Request timeout after 30 seconds
  retry_enabled = true

  geo_locations = ["us-tx-sn1-azr"]

  request {
    url = "https://no-assist-ai-dev-sc-omni-comm-appsvc.azurewebsites.net/"
  }

  validation_rules {
    expected_status_code = 200
  }
}

resource "azurerm_monitor_action_group" "teams" {
  name                = "teams-alert-group"
  resource_group_name = azurerm_resource_group.poc-test-rg.name
  short_name          = "teams-ag"

  email_receiver {
    name          = "alert-emails"
    email_address = "goamitgogo87@gmail.com"
  }

  webhook_receiver {
    name = "TeamsWebhook"
    #service_uri = "https://nowoptics.webhook.office.com/webhookb2/32b9a40f-989b-486e-8d77-97fab1e3fc17@e0d21cb3-860e-4c0f-9c20-ef1b7466a95c/IncomingWebhook/1e8d65bde82d4b7c814f53657bf79329/6c7454bc-2406-42af-93dd-72f885c2e0ed/V2ZOc8QF3jG1wW3kFl-30u5UoD5t6i7aH06SblUbQ6Vjg1"
    service_uri = "https://hooks.slack.com/services/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"
  }
}

resource "azurerm_monitor_metric_alert" "url_alert" {
  name                = "url-down-alert"
  resource_group_name = azurerm_resource_group.poc-test-rg.name
  scopes              = [azurerm_application_insights.example.id]
  severity            = 0
  auto_mitigate       = false

  frequency   = "PT5M" # Check every 5 minutes
  window_size = "PT5M" # Evaluate over a 5-minute window

  criteria {
    metric_namespace = "Microsoft.Insights/Components"
    metric_name      = "availabilityResults/availabilityPercentage"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 50 # Alert if availability is less than 95%
  }

  action {
    action_group_id = azurerm_monitor_action_group.teams.id
  }

  tags = {
    environment = "production"
    severity    = "high"
  }
}


