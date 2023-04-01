# Azure Kubernetes Service voting Application deployment.
  ## Project overview:
 Kubernetes provides a distributed platform for containerized applications. With AKS, I can quickly create a production ready Kubernetes cluster. In this project, I have used Azure Container Registry (ACR) as a private registry for container images and Azure Kubernates Services to :
 
•	Deployed an ACR instance 

•	Created docker image

•	Upload my docker image to  ACR instance

•	Deployed Kubernetes AKS cluster, authenticated to my Azure Container Registry (ACR)

•	Updated my Kubernetes manifest file 

•	Runned my application in Kubernetes K8s.
#### Create a branch and clone Repo
#### Create Resource group
$ az group create --name tcb-vote --location <region>
#### Creating Azure Container Registry
$ az acr create --resource-group tcb-vote --name <acrName> --sku Basic
#### Log in to the container registry
$ az acr login --n <acrName> --expose-token
#### Copy the “accessToken” and save it!
$ docker login <acrName> 
#### Create a Docker Image
$ az acr build --image tcb-vote --registry <acrName>  --file Dockerfile .
#### Creating a cluster in the Azure Kubernetes Service (AKS)
$ az aks create \
--resource-group tcb-vote \
--name AKSClusterTCB \
--node-count 1 \
--generate-ssh-keys
#### Attaching | Associating… the ‘acr’ to the ‘aks’
$ az aks update -n AKSClusterTCB -g tcb-vote --attach-acr <acrName>  
#### Connect to cluster using kubectl
$ az aks get-credentials --resource-group tcb-vote --name AKSClusterTCB
#### verify connection to my cluster :
$ kubectl get nodes
updated the image name in the Kubernetes manifest file to include the ACR login server name because my Azure Container Registry (ACR) instance stores the container image.
#### Deploying the application into the cluster
$ kubectl apply -f tcb-vote-plus-redis.yaml
#### Get the Public IP of the Load Balancer and Testing the application
$ kubectl get service --watch
<img width="939" alt="Dockerized_App_C1" src="https://user-images.githubusercontent.com/55653989/229312420-d6cb0c79-ff92-4bdb-81b2-fbf4eb8d1fa2.PNG">
<img width="931" alt="Dockerized_App_C2" src="https://user-images.githubusercontent.com/55653989/229312429-e205afa1-4d18-4cda-825d-dad1a8c08a2f.PNG">

  <img width="957" alt="Dockerized-App" src="https://user-images.githubusercontent.com/55653989/229312439-936e3e05-c64d-45f5-98a9-459527952cb1.PNG">

  
