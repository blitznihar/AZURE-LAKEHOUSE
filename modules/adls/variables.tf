variable "azure_storage_service_name" {
  type = string
}
variable "azure_adls_service_name" {
  type = string
}

variable "azure_resource_group_lh_name" {
  type = string
}

variable "azure_resource_group_lh_location" {
  type = string
}
variable "azure_resource_tags" {
  type = map(string)
}