env         = "prod"
location    = "eastus2"
name        = "webapp"
address_space        = "10.40.0.0/16"
app_integration_cidr = "10.40.1.0/24"
privatelink_cidr     = "10.40.2.0/24"
plan_sku    = "P1v3"
sql_sku_name = "GP_S_Gen5_4"
sql_azuread_admin_login     = "platform-sql-admins"
sql_azuread_admin_object_id = "055cbb48-e751-435d-beba-c123b245f054" # replace
tenant_id   = "1f247da7-fbef-491d-b061-607878fc9fcd" # replace
tags = { env = "prod", app = "webapp", owner = "platform" }
