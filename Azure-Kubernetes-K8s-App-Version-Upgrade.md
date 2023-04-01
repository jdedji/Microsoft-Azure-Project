# Kubernete Application version upgrade
kubectl get pod ==== to make sure Application are running before to satart.
kubectl config current-context === to make sure Im connected to the correct K8s,otherwise , I switch to the correct k8s using "export KUBECONFIG=<k8s name" or "az aks get-credentials --resource-group myResourceGroup --name myAKSCluster"
list the name space : kubectl get ns
kubectl get deploy -n <name space> -o wide ==== to see the current version .
I take backup of the current version so I can rollback to it in case the upgrade failed
kubectl edit deploy <applictaion name> -n <name space> === this will open kubernates yaml file where I change the App version to newer version.
kubectl get pod <name space> === to see if all app are running.
Check App logs.
Restart graphql-gateway only if the App updated is in the backend
After the upgrade activity, I inform the Application team for verification. 
