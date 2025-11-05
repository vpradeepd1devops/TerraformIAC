resource "azurerm_storage_account" "sa" {
  name                     = lower(replace("${var.name}${var.env}", "-", ""))
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false
  tags = var.tags
}

resource "azurerm_storage_container" "assets" {
  name                  = "assets"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_private_endpoint" "sa_pe" {
  name                = "${var.name}-${var.env}-sa-pe"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_privatelink_id

  private_service_connection {
    name                           = "blob"
    private_connection_resource_id = azurerm_storage_account.sa.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "blob-dns"
    private_dns_zone_ids = [var.blob_dns_zone_id]
  }
}
