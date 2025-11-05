resource "azurerm_mssql_server" "sql" {
  name                = "${var.name}-${var.env}-sqlsvr"
  resource_group_name = var.rg_name
  location            = var.location
  version             = "12.0"
  minimum_tls_version = "1.2"
  public_network_access_enabled = false
  azuread_administrator {
    login_username = var.sql_azuread_admin_login
    object_id = var.sql_azuread_admin_object_id
    azuread_authentication_only = true

  }
  tags = var.tags
}

resource "azurerm_mssql_database" "db" {
  name        = "${var.name}-${var.env}-db"
  server_id   = azurerm_mssql_server.sql.id
  sku_name    = var.sql_sku_name
  max_size_gb = 32
  zone_redundant = false
  tags = var.tags
}

resource "azurerm_private_endpoint" "sql_pe" {
  name                = "${var.name}-${var.env}-sql-pe"
  resource_group_name = var.rg_name
  location            = var.location
  subnet_id           = var.subnet_privatelink_id

  private_service_connection {
    name                           = "sql"
    private_connection_resource_id = azurerm_mssql_server.sql.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "sql-dns"
    private_dns_zone_ids = [var.sql_dns_zone_id]
  }
}
