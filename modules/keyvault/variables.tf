variable "name" { type = string }
variable "env"  { type = string }
variable "rg_name" { type = string }
variable "location" { type = string }
variable "tenant_id" { type = string }
variable "subnet_privatelink_id" { type = string }
variable "enable_private_endpoint" { type = bool default = true }
variable "tags" { type = map(string) default = {} }
