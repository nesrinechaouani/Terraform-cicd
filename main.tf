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
  client_secret   = "T7O8Q~XyRzigy6S5PkFnBEdYFUxu5wo4CMCHiagF"
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

#  kind = "Windows" # Assurez-vous de spécifier le type d'OS avec 'kind' pour Linux ou Windows selon le besoin
}

#resource "azurerm_app_service" "example" {
#  name                = "myAppService1"
#  location            = azurerm_resource_group.example.location
#  resource_group_name = azurerm_resource_group.example.name
#  app_service_plan_id = azurerm_app_service_plan.example.id
#}

resource "azurerm_app_service" "example" {
  name                     = "myAppService1"
  location                 = azurerm_resource_group.example.location
  resource_group_name      = azurerm_resource_group.example.name
  app_service_plan_id      = azurerm_app_service_plan.example.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  site_config {
    python_version = "3.8"
    linux_fx_version = "PYTHON|3.8"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_app_service_source_control" "example" {
  app_id                = azurerm_app_service.example.id
  repo_url              = "https://github.com/nesrinechaouani/Terraform-cicd"
  branch                = "main"
  use_manual_integration = false
  scm_type              = "GitHub"
}

