module "rg" {
  source   = "../../modules/resource_group"
  name     = var.name
  env      = var.env
  location = var.location
  tags     = var.tags
}

module "net" {
  source                = "../../modules/network"
  name                  = var.name
  env                   = var.env
  location              = var.location
  rg_name               = module.rg.name
  address_space         = var.address_space
  app_integration_cidr  = var.app_integration_cidr
  privatelink_cidr      = var.privatelink_cidr
  tags                  = var.tags
}

module "dns" {
  source  = "../../modules/dns"
  rg_name = module.rg.name
  vnet_id = module.net.vnet_id
  env     = var.env
}

module "storage" {
  source                = "../../modules/storage"
  name                  = var.name
  env                   = var.env
  rg_name               = module.rg.name
  location              = var.location
  subnet_privatelink_id = module.net.subnet_privatelink_id
  blob_dns_zone_id      = module.dns.blob_zone_id
  tags                  = var.tags
}

module "sql" {
  source                = "../../modules/sql"
  name                  = var.name
  env                   = var.env
  rg_name               = module.rg.name
  location              = var.location
  subnet_privatelink_id = module.net.subnet_privatelink_id
  sql_dns_zone_id       = module.dns.sql_zone_id
  sql_sku_name          = var.sql_sku_name
  sql_azuread_admin_login     = var.sql_azuread_admin_login
  sql_azuread_admin_object_id = var.sql_azuread_admin_object_id
  tags                  = var.tags
}

module "kv" {
  source                = "../../modules/keyvault"
  name                  = var.name
  env                   = var.env
  rg_name               = module.rg.name
  location              = var.location
  tenant_id             = var.tenant_id
  subnet_privatelink_id = module.net.subnet_privatelink_id
  enable_private_endpoint = true
  tags                  = var.tags
}

module "app" {
  source                    = "../../modules/appservice"
  name                      = var.name
  env                       = var.env
  rg_name                   = module.rg.name
  location                  = var.location
  plan_sku                  = var.plan_sku
  subnet_app_integration_id = module.net.subnet_app_integration_id
  storage_account_id        = module.storage.account_id
  storage_blob_endpoint     = "https://${module.storage.account_name}.blob.core.windows.net"
  sql_server_fqdn           = "${module.sql.server_name}.database.windows.net"
  sql_database_name         = module.sql.database_name
  tags                      = var.tags
}
