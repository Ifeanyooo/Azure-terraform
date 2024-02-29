terraform {    
  required_providers {    
    azurerm = {    
      source = "hashicorp/azurerm"    
    }    
  }    
} 
   
provider "azurerm" {    
  features {}    

  subscription_id = "23c14808-504c-4ae4-91cb-2a2f2f6cb725"
  tenant_id       = "9e90a546-532f-4ccb-a93e-3384b6c0661b"


}

resource "azurerm_resource_group" "resource_group" {
  name     = "walure-resource"
  location = "North Europe"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "ASP-waluregroup-9613"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "rezumiistaging"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    # Additional app settings can be defined here
  }
}
