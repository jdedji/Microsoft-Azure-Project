# Overview 
This document aims to provide how I have deployed an Azure Databricks cluster on Azure with its supporting infrastructure using Terraform. 
Before to start my deployment I gather :

•	Information on the storage account and container to be mounted on databricks workspace.

•	List of all users that need access to azure databricks .

•	List of keys and secret that need to be access via databricks. 

•	Create branch from the main branch 

•	Clone repo  and switch to my newly branch created. 

•	Connect to the client Kubernetes Cluster.

below are the terraform files that I will talk about. 

  •	Provider.tf
  
  •	Main.tf
  
  •	Storage.tf
  
  •	Vault.tf
 
Provider.tf: 
A key file here is providers.tf, this is where I usually  declare the providers require and any configuration parameters that I need to pass to them.

terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
       version =  "0.3.1"
    }
  }
}

provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.workspace.id
}
provider "azurerm" {
  features {}
#   client_id = "*************************************"
#   client_secret = "*********************"
  tenant_id = "*****************************"
  subscription_id = "***************************"
}
 
Man.tf
is where I usually declare all  foundational , an example of this for Azure is broadly an azurerm_resource_group as this is likely to be consumed by any other code written. By splitting out the code into different files it helps developers more easily understand what is going on in the codebase.
In my main.tf as can be seen below I’m declaring a few things.

•	Resource group (Azurerm_resource_group": inside this , location(region) and name are specified 

•	Azure databricks workspace(3 worksapces stage,qa,prod) : location , name and resource group name

•	Databricks_node_type

•	Databricks_spark_version

•	Databricks_instance_pool : 

•	databricks_cluster: 

•	data "azurerm_client_config"

resource "azurerm_resource_group" "rg" {
  location = var.location
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

#   node_type_id = data.databricks_node_type.smallest.id
  autotermination_minutes = 20
  autoscale {
    min_workers = 0
    max_workers = 2
  }
  custom_tags = {
    "createdBy" = "jean"
  }
}
data "azurerm_client_config" "current" {}



Storage.tf: Where I create all  storage account  and containers

resource "azurerm_storage_account" "storage" {
  account_replication_type = "LRS"
  account_tier = "Standard"
  location = azurerm_resource_group.rg.location
  name = "azuredbob1289"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_storage_container" "container" {
  name = "azuredbcontainer"
  storage_account_name = azurerm_storage_account.storage.name
}

Vault.tf :
This is where I define my key vault, my secret key, secret scope and access policy. 

resource "azurerm_key_vault" "keyvault" {
  location = azurerm_resource_group.rg.location
  name = "azuredbkv1297"
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"

}

resource "azurerm_key_vault_access_policy" "kv" {
  object_id = data.azurerm_client_config.current.object_id
  tenant_id = data.azurerm_client_config.current.tenant_id
  key_vault_id = azurerm_key_vault.keyvault.id
  secret_permissions = ["delete","get","list","set"]
}


resource "databricks_secret_scope" "kv" {
  name = "keyvault-viaTf"
  keyvault_metadata {
    resource_id = azurerm_key_vault.keyvault.id
    dns_name = azurerm_key_vault.keyvault.vault_uri
  }
}

resource "azurerm_key_vault_secret" "secret" {
  name = "azuredb-storage"
  value = azurerm_storage_account.storage.primary_access_key
  key_vault_id = azurerm_key_vault.keyvault.id
}


Deploying the environment:
Now that I have all my code ready I run:

  •	Terraform init
  
  •	Terraform plan
  
  •	Terraform apply
