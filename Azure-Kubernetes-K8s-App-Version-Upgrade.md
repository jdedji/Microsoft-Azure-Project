# Kubernetes Application Image version upgrade
To make sure our AKS Clusters are maintained on regular base, we keep our Applications images version upgraded. Bellow commands are used to upgrade our Applications Images version:

    •	Make sure Applications are in running state before to start

          $ kubectl get pod

    •	Make sure to be  connected to the correct K8s, otherwise , I switch to the correct k8s

          $ kubectl config current-context 

          $ "export KUBECONFIG=<k8s name" or

          $ "az aks get-credentials --resource-group myResourceGroup --name myAKSCluster"

    •	List the name space 

          $ kubectl get ns 

    •	Check the current version

          $ kubectl get deploy -n <name space> -o wide

    •	Take backup of the current version so I can rollback to it in case the upgrade failed

    •	Edit  Kubernates yaml file to upgrade version.

          $ kubectl edit deploy <applictaion name> -n <name space> 

    •	Verify if all application are at running state

          $ kubectl get pod <name space>.

    •	I finally Check the Application logs and restart graphql-gateway only if the App updated is in the backend. After the upgrade activity, I inform the Application team for verification.
