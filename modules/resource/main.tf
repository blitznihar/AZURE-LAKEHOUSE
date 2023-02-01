resource "azurerm_resource_group" "azurerm_resource_group_blitzdataplatform_rg" {
  name     = "blitzdataplatform-rg"
  location = var.azureblitzdataplatformlocation
}