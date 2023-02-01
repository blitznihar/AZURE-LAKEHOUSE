resource "azurerm_data_factory" "azure_data_factory" {
  name                = var.azure_adf_service_name
  location            = var.azure_resource_group_lh_location
  resource_group_name = var.azure_resource_group_lh_name
}