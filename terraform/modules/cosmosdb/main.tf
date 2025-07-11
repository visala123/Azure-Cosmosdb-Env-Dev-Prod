resource "azurerm_resource_group" "cosmosdb_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = var.account_name
  location            = var.location
  resource_group_name = azurerm_resource_group.cosmosdb_rg.name
  offer_type          = var.offer_type
  kind                = var.kind

  automatic_failover_enabled = var.automatic_failover_enabled

  dynamic "capabilities" {
    for_each = var.capabilities
    content {
      name = capabilities.value
    }
  }

  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = var.max_interval_in_seconds
    max_staleness_prefix    = var.max_staleness_prefix
  }

  dynamic "geo_location" {
    for_each = var.geo_locations
    content {
      location          = geo_location.value.location
      failover_priority = geo_location.value.failover_priority
    }
  }

  tags = var.tags
}
