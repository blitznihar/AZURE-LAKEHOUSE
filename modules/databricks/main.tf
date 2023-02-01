
resource "azurerm_databricks_workspace" "azure_databricks_workspace" {
  name                        = var.azure_databricks_workspace
  resource_group_name         = var.azure_resource_group_lh_name
  location                    = var.azure_resource_group_lh_location
  sku                         = "premium"
  managed_resource_group_name = "${var.azure_databricks_workspace}-workspace-rg"
  tags                        = var.azure_resource_tags
}

output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.azure_databricks_workspace.workspace_url}/"
}