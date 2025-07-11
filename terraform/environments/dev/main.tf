provider "azurerm" {
  features {}
}

module "cosmosdb" {
  source = "../../modules/cosmosdb"

  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_name                  = var.account_name
  offer_type                    = var.offer_type
  kind                          = var.kind
  automatic_failover_enabled    = var.automatic_failover_enabled
  capabilities                  = var.capabilities
  consistency_level             = var.consistency_level
  max_interval_in_seconds       = var.max_interval_in_seconds
  max_staleness_prefix          = var.max_staleness_prefix
  geo_locations                 = var.geo_locations
  tags                          = var.tags
}