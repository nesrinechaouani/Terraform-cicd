variable "location" {
  description = "The location where resources will be created"
  default     = "North Europe"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "myResourceGroup"
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  default     = "myAppServicePlan"
}

variable "app_service_name" {
  description = "The name of the App Service"
  default     = "myAppService"
}
variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret"{
 type = string
}
