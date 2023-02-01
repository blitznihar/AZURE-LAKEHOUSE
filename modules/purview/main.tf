resource "azurerm_purview_account" "azure_purview_account" {
  name                = var.azure_purview_service_name
  location            = var.azure_resource_group_lh_location
  resource_group_name = var.azure_resource_group_lh_name
  tags                = var.azure_resource_tags
}