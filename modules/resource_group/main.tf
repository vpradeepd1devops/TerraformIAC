resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-${var.env}-rg"
  location = var.location
  tags     = var.tags
}
