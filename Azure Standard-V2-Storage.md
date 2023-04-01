When clients migrate to databricks, they will need a new type of storage setup - a standard V2 storage account setup with RA-GRS. This storage type is recommended by Microsoft because It supported for limit increases. This storage is then mounted using a new protocol, abfs in databricks; In prod is it mounted as RW and in stage and qa it's mounted as RO. 
Step 1: 
I Start by creating a new branch from git main branch, 
swicth to my branch created, make sure to be in the client Kubernete Cluster and then Run terraform plan for that client to ensure no changes are pending. 
Step2
Terraform file creation or update of existing files: 

profider.tf :
#Add cloud provider
#Subscription ID
#Tenant ID
#Client ID
#Client Secret ID

Storage.tf :
#creation of standard storage acct :
#Storage name 
#Resource Group name 
#Location 
#Account tier (Standard)
#Access replication type(RAGRS)
#Acc kind(SorageV2)
#Access tier(Hot)
#Deletion retention policy (days=1)

#create App reg for RW access 
#Client secret 
#add RW role assignment to std storage 
#Add RW clientID to KeyVault
#create App reg for RO access
#create service princilpal 

Step:3
# Garther containers requiresd and mount them . Containers are mounted in Prod as RW, and in qa/stage as RO
Step:4
Data copy from origin datamart :
After storage account is deployed and containers are created and mounted in databricks then the storage need to be synced from the origin datamart
