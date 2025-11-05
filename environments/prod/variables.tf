variable "env" {}
variable "location" {}
variable "name" {}
variable "address_space" {}
variable "app_integration_cidr" {}
variable "privatelink_cidr" {}
variable "plan_sku" {}
variable "sql_sku_name" {}
variable "sql_azuread_admin_login" {}
variable "sql_azuread_admin_object_id" {}
variable "tenant_id" {}
variable "tags" { type = map(string) default = {} }
