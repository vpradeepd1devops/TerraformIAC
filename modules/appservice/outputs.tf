output "frontend_name" { value = azurerm_linux_web_app.frontend.name }
output "backend_name"  { value = azurerm_linux_web_app.backend.name }
output "frontend_principal_id" { value = azurerm_linux_web_app.frontend.identity[0].principal_id }
output "backend_principal_id"  { value = azurerm_linux_web_app.backend.identity[0].principal_id }
