variable "resource_group_name" {}
variable "location" {}
variable "account_name" {}
variable "offer_type" {}
variable "kind" {}
variable "automatic_failover_enabled" { type = bool }
variable "capabilities" { type = list(string) }
variable "consistency_level" {}
variable "max_interval_in_seconds" { type = number }
variable "max_staleness_prefix" { type = number }

variable "geo_locations" {
  type = list(object({
    location          = string
    failover_priority = number
  }))
}

variable "tags" {
  type = map(string)
}
