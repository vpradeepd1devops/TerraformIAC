resource "azurerm_key_vault" "kv" {
  name                       = "${var.name}-${var.env}-kv"
  resource_group_name        = var.rg_name
  location                   = var.location
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = true
  soft_delete_retention_days = 7
  public_network_access_enabled = false
  tags = var.tags
}

resource "azurerm_private_endpoint" "kv_pe" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "${var.name}-${var.env}-kv-pe"
  resource_group_name = var.rg_name
  location            = var.location
  subnet_id           = var.subnet_privatelink_id

  private_service_connection {
    name                           = "vault"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
}
