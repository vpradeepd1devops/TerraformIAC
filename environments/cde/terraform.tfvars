env         = "cde"
location    = "eastus"
name        = "webapp"
address_space        = "10.20.0.0/16"
app_integration_cidr = "10.20.1.0/24"
privatelink_cidr     = "10.20.2.0/24"
plan_sku    = "S1"
sql_sku_name = "GP_S_Gen5_2"
sql_azuread_admin_login     = "myproject-sql-admins"
sql_azuread_admin_object_id = "00000000-0000-0000-0000-000000000000" # replace
tenant_id   = "1f247da7-fbef-491d-b061-607878fc9fcd" # replace
tags = { env = "cde", app = "webapp" }
