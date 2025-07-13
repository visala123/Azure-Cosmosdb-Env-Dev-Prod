resource_group_name         = "rg-cosmos-dev"
location                    = "East US"
account_name                = "cosmosdb-dev-app"
offer_type                  = "Standard"
kind                        = "MongoDB"
automatic_failover_enabled  = true
capabilities                = ["EnableAggregationPipeline", "mongoEnableDocLevelTTL", "MongoDBv3.4", "EnableMongo"]
consistency_level           = "BoundedStaleness"
max_interval_in_seconds     = 300
max_staleness_prefix        = 100000

geo_locations = [
  {
    location          = "eastus"
    failover_priority = 1
  },
  {
    location          = "westus"
    failover_priority = 0
  }
]

tags = {
  environment = "prod"
  team        = "devops"
  }