variable "name" { type = string }
variable "env"  { type = string }
variable "rg_name" { type = string }
variable "location" { type = string }
variable "subnet_privatelink_id" { type = string }
variable "sql_dns_zone_id" { type = string }
variable "sql_sku_name" { type = string }
variable "sql_azuread_admin_login" { type = string }
variable "sql_azuread_admin_object_id" { type = string }
variable "tags" { type = map(string) default = {} }
