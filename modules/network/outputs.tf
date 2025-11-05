output "vnet_id" { value = azurerm_virtual_network.vnet.id }
output "vnet_name" { value = azurerm_virtual_network.vnet.name }
output "subnet_app_integration_id" { value = azurerm_subnet.app_integration.id }
output "subnet_privatelink_id" { value = azurerm_subnet.privatelink_endpoints.id }
