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
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

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

  kind = "Linux" # Assurez-vous de spécifier le type d'OS avec 'kind' pour Linux ou Windows selon le besoin
  reserved = true
}

#resource "azurerm_app_service" "example" {
#  name                = "myAppServiceNew"
#  location            = azurerm_resource_group.example.location
#  resource_group_name = azurerm_resource_group.example.name
#  app_service_plan_id = azurerm_app_service_plan.example.id
#}


resource "azurerm_app_service" "example" {
  name                = "myAppServiceNew"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITES_PORT"                       = "5000"  # Port par défaut pour Flask
    "FLASK_APP"                           = "app.py"
  }

  site_config {
    linux_fx_version = "PYTHON|3.9"
  }

  https_only = true
}
resource "azurerm_app_service_source_control" "source_control" {
  app_id     = azurerm_app_service.example.id
  repo_url   = "https://github.com/nesrinechaouani/Terraform-cicd.git"
  branch     = "main"
  use_manual_integration = true
}
