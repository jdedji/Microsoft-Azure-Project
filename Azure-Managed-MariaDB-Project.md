# Azure Managed MariaDB instance:
## Step 1: 
	I Start by creating a new branch from our github main branch, switch to my branch created, making sure to be in the client Kubernetes Cluster and then Run           terraform init to ensure no changes are pending. 
## Step: 2
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
	
## Step: 3
	After all code change , I then run:
		• Terraform init

		• Terraform plan

		• Terraform Apply
## Step: 3
	 After deployment I finally
	 
		• Configure Azure Private endpoint

		• Configure Azure private DNS Zone

		• Create Azure record set to existing Vnet

		• Test connection using Dbeaver

		• Share all login credential with data science team. 

		• Replace the existing hostname and username in the Kubernetes config map by the new hostname, username created after migration is complete

