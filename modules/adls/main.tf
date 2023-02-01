resource "azurerm_storage_account" "azure_storage_account" {
  name                     = var.azure_storage_service_name
  resource_group_name      = var.azure_resource_group_lh_name
  location                 = var.azure_resource_group_lh_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "azure_storage_data_lake_gen2_filesystem" {
  name               = var.azure_adls_service_name
  storage_account_id = azurerm_storage_account.azure_storage_account.id
  properties         = var.azure_resource_tags
}