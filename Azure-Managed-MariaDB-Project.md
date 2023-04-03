# Azure Managed MariaDB instance:
## Step1
I Start by creating a new branch from our github main branch, switch to my branch created, making sure to be in the client Kubernetes Cluster and then Run terraform init and plan to ensure no changes are pending. 
## Step2
#### Terraform file creation or update of existing files: 
### Provider.tf
		• Add cloud provider

		• Subscription ID

		• Tenant ID

		• Client ID

		• Client Secret ID

#### mariadb.tf (where mariadb resources are created)
		• Name

		• Location

		• Resource group

		• sku_name

		• storage size

		• version="10.2"

		• backup_retention_days( Backup retention days for the server, supported values are between 7 and 35 days.)

		• geo_redundant_backup_enabled

		• public_network_access_enabled

		• auto_grow_enabled

		• administrator_login

		• administrator_login_passwor
	
### Vault.tf file , where I stored keys and password.
 I provide the value of the password declared in mariadb.tf file
	
### Variable.tf
	where I provide value to all variables declared in mariadb.tf and provider.ft files.
	
## Step3
	After all code change , I then run:
		• Terraform init

		• Terraform plan

		• Terraform Apply
## Step4
	 After deployment I finally
	 
		• Configure Azure Private endpoint

		• Configure Azure private DNS Zone

		• Create Azure record set to existing Vnet

		• Test connection using Dbeaver

		• Share all login credential with data science team. 

		• After migrating from VM to the new MariaDB created I then connect to the client Kubernetes cluster to update hostname and username
		
		• Push the code to my github branch
		
		• Create pull request for code to be merged to the master branch 
		

