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
#export ARM_CLIENT_ID=7ed1097c-36a3-4b50-9bc6-c0b2f91968fc
#export ARM_CLIENT_SECRET=S-88Q~ppK10dMxkusnTJS4L8wlvDff3CagXRTazg
#export ARM_SUBSCRIPTION_ID=304799ce-2258-416d-85f2-8c42149f7550
#export ARM_TENANT_ID=dbd6664d-4eb9-46eb-99d8-5c43ba153c61

