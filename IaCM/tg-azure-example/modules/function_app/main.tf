variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_account_key" {
  type = string
}

resource "azurerm_service_plan" "plan" {
  name                = "${var.name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "func" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan.id

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_key

  site_config {}
}

output "url" {
  value = azurerm_linux_function_app.func.default_hostname
}
