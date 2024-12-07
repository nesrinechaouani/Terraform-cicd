terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.12.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "304799ce-2258-416d-85f2-8c42149f7550"
  client_id       = "7ed1097c-36a3-4b50-9bc6-c0b2f91968fc"
  client_secret   = "S-88Q~ppK10dMxkusnTJS4L8wlvDff3CagXRTazg"
  tenant_id       = "dbd6664d-4eb9-46eb-99d8-5c43ba153c61"
}

resource "azurerm_resource_group" "example" {
  name     = "myResourceGroup"
  location = "North Europe"
}

resource "azurerm_service_plan" "example" {
  name                = "myAppServicePlan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  # Required argument for OS type (either "Windows" or "Linux")
  os_type = "Windows"

  # Required argument for SKU
  sku_name = "S1"  # Example SKU, change as necessary

  # Specify the kind (Windows or Linux) depending on your requirements
  kind = "Windows"
}

resource "azurerm_app_service" "example" {
  name                = "myAppService1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_service_plan.example.id
}
