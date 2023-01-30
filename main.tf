# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

module "resource" {
  source = "./modules/resource"
}

module "network" {
  source                             = "./modules/network"
  azurerm_resource_group_ng_id       = module.resource.azurerm_resource_group_ng_id
  azurerm_resource_group_ng_name     = module.resource.azurerm_resource_group_ng_name
  azurerm_resource_group_ng_location = module.resource.azurerm_resource_group_ng_location
}


module "adf" {
  source              = "./modules/adf"
  adf_service_name    = "adf_ng"
  location            = module.resource.azurerm_resource_group_ng_location
  resource_group_name = module.resource.azurerm_resource_group_ng_name
}

module "adls" {
  source                                 = "./modules/adls"
  sc_service_name                        = "adls-ng27318712357356187"
  location                               = module.resource.azurerm_resource_group_ng_location
  resource_group_name                    = module.resource.azurerm_resource_group_ng_name
  sc_law_id                              = module.loganalyticsworkspace.azurerm_log_analytics_workspace_ng_id
  app_subnet_id                          = module.network.app_subnet_id
  service_runtime_subnet_id              = module.network.service_runtime_subnet_id
  application_insights_connection_string = module.insight.application_insights_connection_string
}

module "snowflake" {
  source                                  = "./modules/snowflake"
  apim_service_name                       = "snowflake-ng27318712357356187"
  location                                = module.resource.azurerm_resource_group_ng_location
  resource_group_name                     = module.resource.azurerm_resource_group_ng_name
  application_insights_instumentation_key = module.insight.application_insights_instumentation_key
}

module "databricks" {
  source              = "./modules/databricks"
  asb_service_name     = "databricks-ng27318712357356187"
  location            = module.resource.azurerm_resource_group_ng_location
  resource_group_name = module.resource.azurerm_resource_group_ng_name
}