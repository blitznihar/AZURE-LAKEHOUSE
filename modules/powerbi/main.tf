resource "azurerm_powerbi_embedded" "azure_powerbi_embedded" {
  name                = var.azure_powerbi_embedded_name
  location            = var.azure_resource_group_lh_location
  resource_group_name = var.azure_resource_group_lh_name
  sku_name            = "A1"
  administrators      = ["nmalali@nationallife.com"]
  tags                = var.azure_resource_tags
}