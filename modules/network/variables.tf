variable "name" { type = string }
variable "env"  { type = string }
variable "location" { type = string }
variable "rg_name" { type = string }
variable "address_space" { type = string }
variable "app_integration_cidr" { type = string }
variable "privatelink_cidr" { type = string }
variable "tags" { type = map(string) default = {} }
