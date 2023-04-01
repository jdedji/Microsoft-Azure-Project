# Azure Standard-V2-Storage deployment (Terraform is used for this deployment)
When clients migrate to databricks, they will need a new type of storage setup(a standard V2 storage account setup with RA-GRS). This storage type is recommended by Microsoft because It supports limit increases. This storage is then mounted using a new protocol, abfs in databricks; In prod is it mounted as RW and in stage and qa is  mounted as RO. This deployment is done through terraform.
## Step1: 
  •	Create new branch from main branch

  •	Clone repo and switch to my branch created

  •	I make sure to be in the client Kubernetes cluster 

  •	Run terraform init and terraform plan to ensure no changes are pending. 
## Step2: Terraform file creation or update of existing files: 
### profider.tf :
Provider file will include:

  •	The cloud provider

  •	Subscription ID

  •	Tenant ID

  •	Client ID

  •	Client Secret ID
### Storage.tf:
Storage file will include :

  •	Storage name

  •	Resource Group name

  •	Location

  •	Account tier (Standard)

  •	Access replication type(RAGRS)

  •	Account kind(SorageV2)

  •	Access tier(Hot)

  •	Deletion retention policy
### Create App reg for RW access in the storage.tf file, this terraform code code will include:

  •	Client secret

  •	RW role assignment to std storage

  •	RW ClientID 

  •	KeyVault

  •	Create App reg for RO access

  •	Service principal 
## Step3:
At this step, I gather all containers required and mount them .Containers are mounted in Prod as RW, and in qa/stage as RO
## Step4: Data copy from origin datamart :
After storage account is deployed and containers are created and mounted in databricks then the storage will need to be synced from the origin datamart
