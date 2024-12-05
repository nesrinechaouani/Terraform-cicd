provider "azurerm" {
  features {}
  subscription_id = "304799ce-2258-416d-85f2-8c42149f7550"
  tenant_id       = "dbd6664d-4eb9-46eb-99d8-5c43ba153c61"
}

resource "azurerm_resource_group" "example" {
  name     = "myResourceGroup"
  location = "North Europe"
}

resource "azurerm_app_service_plan" "example" {
  name                = "myAppServicePlan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Standard"
    size = "S1"
  }

  kind = "Windows" # Assurez-vous de spécifier le type d'OS avec 'kind' pour Linux ou Windows selon le besoin
}

resource "azurerm_app_service" "example" {
  name                = "myAppService1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
}
