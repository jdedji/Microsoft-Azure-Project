# Kubernetes Application Image version upgrade
To make sure our AKS Clusters are maintained on regular base, we keep our Applications images version upgraded. Bellow commands are used to upgrade our Applications Imgaes vrsion.
### kubectl get pod ==== to make sure Applications are running before to satart.
### kubectl config current-context === to make sure Im connected to the correct K8s,otherwise , I switch to the correct k8s using "export KUBECONFIG=<k8s name" or "az aks get-credentials --resource-group myResourceGroup --name myAKSCluster"
### kubectl get ns ==== list the name space : 
### kubectl get deploy -n <name space> -o wide ==== to see the current version .
I take backup of the current version so I can rollback to it in case the upgrade failed
### kubectl edit deploy <applictaion name> -n <name space> === this will open kubernates yaml file where I change the App version to newer version.
### kubectl get pod <name space> === to see if all app are running.
I finally Check the Application logs and restart graphql-gateway only if the App updated is in the backend. After the upgrade activity, I inform the Application team for verification. 
