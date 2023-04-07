resource "azurerm_resource_group" "rg" {
  location = "East US"
  name = "AzureDBricks"
}

resource "azurerm_databricks_workspace" "workspace" {
  location = azurerm_resource_group.rg.location
  name = "workspaceDemo"
  resource_group_name = azurerm_resource_group.rg.name
  sku = "standard"
}

data "databricks_node_type" "smallest" {
  depends_on = [azurerm_databricks_workspace.workspace]
  local_disk= true

}

data "databricks_spark_version" "latest_lts" {
  depends_on = [azurerm_databricks_workspace.workspace]
  long_term_support = true
}

resource "databricks_instance_pool" "pool" {
  instance_pool_name = "Pool"
  min_idle_instances = 0
  max_capacity =  1
  node_type_id = data.databricks_node_type.smallest.id
  idle_instance_autotermination_minutes = 10
}

resource "databricks_cluster" "shared_autoscaller" {
  depends_on = [azurerm_databricks_workspace.workspace]
  instance_pool_id = databricks_instance_pool.pool.id
  cluster_name = "Demo1"
 spark_version = "8.0.x-scala2.12"
}
#   node_type_id = data.databricks_node_type.smallest.id
  autotermination_minutes = 20
  autoscale {
    min_workers = 0
    max_workers = 2
  }
  custom_tags = {
    "createdBy" = "jean"
  }

cluster_log_conf {
  dbfs {
    destination = "dbfs:/cluster-logs"
  }
}
  init_scripts {
    dbfs {
      destination = "dbfs:/databricks/spark-monitoring/spark-monitoring.sh"
    }
  }


resource "databricks_azure_blob_mount" "blob" {
  depends_on = [azurerm_databricks_workspace.workspace]
  container_name = azurerm_storage_container.container.name
  storage_account_name = azurerm_storage_account.storage.name
  mount_name = "custommount"
  auth_type = "ACCESS_KEY"
  token_secret_scope = databricks_secret_scope.scope.name
  token_secret_key = databricks_secret.dbsecret.key
}
