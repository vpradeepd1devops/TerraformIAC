resource "azurerm_service_plan" "plan" {
  name                = "${var.name}-${var.env}-plan"
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.plan_sku
  tags                = var.tags
}

resource "azurerm_linux_web_app" "frontend" {
  name                = "${var.name}-${var.env}-fe"
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan.id
  https_only          = true
  identity { type = "SystemAssigned" }
  site_config {
    application_stack { node_version = "20-lts" }
    vnet_route_all_enabled = true
  }
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "0"
    "AZURE_STORAGE_BLOB_ENDPOINT" = var.storage_blob_endpoint
  }
  tags = var.tags
}

resource "azurerm_linux_web_app" "backend" {
  name                = "${var.name}-${var.env}-be"
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan.id
  https_only          = true
  identity { type = "SystemAssigned" }
  site_config {
    application_stack { dotnet_version = "8.0" }
    vnet_route_all_enabled = true
  }
  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = var.env
    "SQL_SERVER_FQDN"   = var.sql_server_fqdn
    "SQL_DATABASE_NAME" = var.sql_database_name
  }
  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "fe_integ" {
  app_service_id = azurerm_linux_web_app.frontend.id
  subnet_id      = var.subnet_app_integration_id
}

resource "azurerm_app_service_virtual_network_swift_connection" "be_integ" {
  app_service_id = azurerm_linux_web_app.backend.id
  subnet_id      = var.subnet_app_integration_id
}

resource "azurerm_role_assignment" "fe_blob_reader" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_linux_web_app.frontend.identity[0].principal_id
}

resource "azurerm_role_assignment" "be_blob_contrib" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_web_app.backend.identity[0].principal_id
}
