terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateaccountv"
    container_name       = "tfstate"
    key                  = "cosmosdb-prod.tfstate"
  }
  
}
