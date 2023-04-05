# Overview 
This document aims to provide how I have deployed an Azure Databricks cluster on Azure with its supporting infrastructure using Terraform. 
Before to start my deployment I gather :

    • Information on the storage account and container to be mounted on databricks workspace.

    • List of all users that need access to azure databricks .

    • List of keys and secret that need to be access via databricks. 

    • Create branch from the main branch 

    • Clone repo  and switch to my newly branch created. 

    • Connect to the client Kubernetes Cluster.

  below are the terraform files that I will talk about. 

    • Provider.tf

    • Main.tf

    • Storage.tf

    • Vault.tf
 
Provider.tf: 
A key file here is providers.tf, this is where I usually  declare the providers require and any configuration parameters that I need to pass to them.

 <img width="480" alt="azprovider" src="https://user-images.githubusercontent.com/55653989/229962948-d3c4fb6e-bac7-47bf-a9e4-bdae66b106bb.PNG">

Man.tf
is where I usually declare all  foundational , an example of this for Azure is broadly an azurerm_resource_group as this is likely to be consumed by any other code written. By splitting out the code into different files it helps developers more easily understand what is going on in the codebase.
In my main.tf as can be seen below I’m declaring a few things.

    • Resource group (Azurerm_resource_group": inside this , location(region) and name are specified 

    • Azure databricks workspace(3 worksapces stage,qa,prod) : location , name and resource group name

    • Databricks_node_type

    • Databricks_spark_version

    • Databricks_instance_pool : 

    • databricks_cluster: 

    • data "azurerm_client_config"

<img width="478" alt="AZmain" src="https://user-images.githubusercontent.com/55653989/229963203-1fe4275b-47f4-4ff3-a160-17b6d61661fc.PNG">
<img width="493" alt="Azmain2" src="https://user-images.githubusercontent.com/55653989/229963238-2e53fa02-e732-4cf3-993a-a5467bd46aa9.PNG">

Storage.tf: Where I create all  storage account  and containers

<img width="477" alt="AZStorage" src="https://user-images.githubusercontent.com/55653989/229963319-b02800c5-a505-46c2-ab54-9ae0d35db744.PNG">

Vault.tf :
This is where I define my key vault, my secret key, secret scope and access policy. 

<img width="396" alt="Azvault" src="https://user-images.githubusercontent.com/55653989/229963424-41ece067-e04f-4c9d-b0c9-f91a00b0e729.PNG">


<img width="952" alt="KeyVaul Secret" src="https://user-images.githubusercontent.com/55653989/230125223-0c4dfa32-0970-4cb2-9514-32e17dca4c1d.PNG">



Deploying the environment:
Now that I have all my code ready I run:

    • Terraform init

    • Terraform plan

    • Terraform apply
  
  
<img width="959" alt="databrickWorkspace" src="https://user-images.githubusercontent.com/55653989/229963569-a2fc8301-9add-4dda-9bc4-329eab24d1a1.PNG">

<img width="956" alt="Workspace2" src="https://user-images.githubusercontent.com/55653989/229963582-8e4f5ce9-ff96-48c8-9ef4-6fe67b9dda02.PNG">

<img width="952" alt="KeyVaul Secret" src="https://user-images.githubusercontent.com/55653989/230125621-af1930f9-306d-4561-8bd9-9052e8160bcc.PNG">

<img width="953" alt="storageAcct" src="https://user-images.githubusercontent.com/55653989/230125574-bc4e5751-a587-4bd7-b5f7-8e5765559ea0.PNG">
