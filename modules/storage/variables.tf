variable "name" { type = string }
variable "env"  { type = string }
variable "rg_name" { type = string }
variable "location" { type = string }
variable "subnet_privatelink_id" { type = string }
variable "blob_dns_zone_id" { type = string }
variable "tags" { type = map(string) default = {} }
