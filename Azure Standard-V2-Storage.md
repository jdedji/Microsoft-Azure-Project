# Azure Standard-V2-Storage deployment (Terraform is used for this deployment)
When clients migrate to databricks, they will need a new type of storage setup(a standard V2 storage account setup with RA-GRS). This storage type is recommended by Microsoft because It supports limit increases. This storage is then mounted using a new protocol, abfs in databricks; In prod is it mounted as RW and in stage and qa it's mounted as RO.
## Step1: 
I Start by creating a new branch from main branch, clone repo and swicth to my branch created, I make sure to be in the client Kubernete Cluster and then Run terraform init and terraform plan to ensure no changes are pending. 
## Step2: Terraform file creation or update of existing files: 
### profider.tf :
Provider file will include Subscription ID, Tenant ID, Client ID and Client Secret ID.
### Storage.tf:
STorage file will inlude :Storage name, Resource Group name, Location, Account tier (Standard), Access replication type(RAGRS), Account kind(SorageV2), Access tier(Hot), Deletion retention policy (days=1)
### Create App reg for RW access in the storage.tf file, this terraform code scode will includ, Client secret, RW role assignment to std storage, RW clientID, KeyVault, Create App reg for RO access, service princilpal 
## Step3:
At this step, I Garther all containers requiresd and mount them .Containers are mounted in Prod as RW, and in qa/stage as RO
## Step4: Data copy from origin datamart :
After storage account is deployed and containers are created and mounted in databricks then the storage need to be synced from the origin datamart
