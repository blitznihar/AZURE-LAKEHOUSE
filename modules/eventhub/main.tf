resource "azurerm_eventhub_namespace" "example" {
  name                = var.azure_eventhub_service_name
  location            = var.azure_resource_group_lh_location
  resource_group_name = var.azure_resource_group_lh_name
  sku                 = "Standard"
  capacity            = 2
  tags                = var.azure_resource_tags
}