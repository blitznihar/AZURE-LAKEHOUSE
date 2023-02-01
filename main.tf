# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
    databricks = {
      source = "databricks/databricks"
    }
  }
}

provider "azurerm" {
  features {}
}


module "resource" {
  source = "./modules/resource"
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

# module "network" {
#   source                             = "./modules/network"
#   azurerm_resource_group_ng_id       = module.resource.azurerm_resource_group_ng_id
#   azurerm_resource_group_ng_name     = module.resource.azurerm_resource_group_ng_name
#   azurerm_resource_group_ng_location = module.resource.azurerm_resource_group_ng_location
# }


module "adf" {
  source                           = "./modules/adf"
  azure_adf_service_name           = "adf_${random_string.naming.result}"
  azure_resource_group_lh_location = module.resource.azurerm_resource_group_ng_location
  azure_resource_group_lh_name     = module.resource.azurerm_resource_group_ng_name
  azure_resource_tags              = var.resource_tags
}

module "eventhub" {
  source                           = "./modules/eventhub"
  azure_eventhub_service_name      = "eventhub_${random_string.naming.result}"
  azure_resource_group_lh_location = module.resource.azurerm_resource_group_ng_location
  azure_resource_group_lh_name     = module.resource.azurerm_resource_group_ng_name
  azure_resource_tags              = var.resource_tags
}
module "purview" {
  source                           = "./modules/purview"
  azure_purview_service_name       = "purview_${random_string.naming.result}"
  azure_resource_group_lh_location = module.resource.azurerm_resource_group_ng_location
  azure_resource_group_lh_name     = module.resource.azurerm_resource_group_ng_name
  azure_resource_tags              = var.resource_tags
}
module "powerbi" {
  source                           = "./modules/powerbi"
  azure_powerbi_embedded_name      = "purview_${random_string.naming.result}"
  azure_resource_group_lh_location = module.resource.azurerm_resource_group_ng_location
  azure_resource_group_lh_name     = module.resource.azurerm_resource_group_ng_name
  azure_resource_tags              = var.resource_tags
}

module "adls" {
  source                           = "./modules/adls"
  azure_storage_service_name       = "storage-${random_string.naming.result}"
  azure_adls_service_name          = "adls-${random_string.naming.result}"
  azure_resource_group_lh_location = module.resource.azurerm_resource_group_ng_location
  azure_resource_group_lh_name     = module.resource.azurerm_resource_group_ng_name
  azure_resource_tags              = var.resource_tags
}

module "databricks" {
  source                           = "./modules/databricks"
  azure_databricks_workspace       = "blitzdatabricks-${random_string.naming.result}"
  azure_resource_group_lh_location = module.resource.azurerm_resource_group_ng_location
  azure_resource_group_lh_name     = module.resource.azurerm_resource_group_ng_name
  azure_resource_tags              = var.resource_tags
}

module "databrickscluster" {
  source                        = "./modules/databrickscluster"
  azure_databricks_workspace_id = module.databricks.azure_databricks_workspace_id
  azure_databricks_cluster      = "blitzdatabrickscluster-${random_string.naming.result}"
}