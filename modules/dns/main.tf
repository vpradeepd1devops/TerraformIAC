resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_link" {
  name                  = "${var.env}-blob-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_link" {
  name                  = "${var.env}-sql-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = var.vnet_id
}
