variable "name" { type = string }
variable "env"  { type = string }
variable "rg_name" { type = string }
variable "location" { type = string }
variable "plan_sku" { type = string }
variable "subnet_app_integration_id" { type = string }
variable "storage_account_id" { type = string }
variable "storage_blob_endpoint" { type = string }
variable "sql_server_fqdn" { type = string }
variable "sql_database_name" { type = string }
variable "tags" { type = map(string) default = {} }
