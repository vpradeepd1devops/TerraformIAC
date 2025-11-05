resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-${var.env}-vnet"
  address_space       = [var.address_space]
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags
}

resource "azurerm_subnet" "app_integration" {
  name                 = "app-integration"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.app_integration_cidr]
  delegation {
    name = "appsvc"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

resource "azurerm_subnet" "privatelink_endpoints" {
  name                 = "privatelink-endpoints"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.privatelink_cidr]
}
