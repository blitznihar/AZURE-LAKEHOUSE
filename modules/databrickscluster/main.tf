terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

provider "databricks" {
  azure_workspace_resource_id = var.azure_databricks_workspace_id
}

data "databricks_node_type" "smallest" {
  local_disk = true

  depends_on = [
    var.azure_databricks_workspace_id
  ]
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true

  depends_on = [
    var.azure_databricks_workspace_id
  ]
}

resource "databricks_cluster" "databricks_cluster" {
  cluster_name = var.azure_databricks_cluster

  spark_version = data.databricks_spark_version.latest_lts.id
  node_type_id  = data.databricks_node_type.smallest.id

  autotermination_minutes = 20

  spark_conf = {
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }

  custom_tags = {
    "ResourceClass" = "SingleNode"
  }
}