So far we have the management cluster, which is used as the mechanism to create additional workload clusters, and a workload cluster called ``tkg-services``, which was created for hosting shared services such as the Harbor registry. The management cluster was then configured so that access details for the Harbor registry are injected into any new workload clusters which are subsequently created, such that they trust the Harbor registry, even when it is using a self signed certificate for secure access.

For your own applications, you should create a further cluster, thus keeping them separate from both the management cluster, and the shared services cluster. If you have multiple development teams, you could even create multiple clusters, so each team has their own. For production systems you could create one or more separate clusters. By using distinct clusters for different development teams or different production applications, you limit the risk of teams or applications interfering with each other.

For each new cluster you create for running applications, you would usually at least want to install the Contour ingress controller. As this entails installing the TMC extensions manager, Carvel Kapp controller and ``cert-manager``, the steps for each cluster are:

* Create the workload cluster for deploying applications.
* Install in the workload cluster the TMC extension manager, Carvel Kapp controller and Kubernetes ``cert-manager``.
* Install in the workload cluster the Contour ingress controller.

In this guided installer we will create one additional cluster for applications called ``appl-cluster``. To do this run:

```execute-1
tkg create cluster appl-cluster --plan=dev --worker-size=m4.large --worker-machine-count=1
```

Once creation is completed, verify the cluster is registered with the management cluster, by running:

```execute-1
tkg get clusters
```

This should yield:

```
NAME          NAMESPACE  STATUS   CONTROLPLANE  WORKERS  KUBERNETES        ROLES          
appl-cluster  default    running  1/1           1/1      v1.19.1+vmware.2  <none>         
tkg-services  default    running  1/1           1/1      v1.19.1+vmware.2  tanzu-services 
```

Query the credentials for the new cluster and add it to the configuration for ``kubectl`` by running:

```execute-1
tkg get credentials appl-cluster
```

To see the available contexts for ``kubectl`` run:

```execute-1
kubectl config get-contexts
```

This should output:

```
CURRENT   NAME                              CLUSTER        AUTHINFO             NAMESPACE
          appl-cluster-admin@appl-cluster   appl-cluster   appl-cluster-admin   
*         mgmt-cluster-admin@mgmt-cluster   mgmt-cluster   mgmt-cluster-admin   
          tkg-services-admin@tkg-services   tkg-services   tkg-services-admin
```

Select the context for the new cluster so ``kubectl`` uses it for subsequent operations.

```execute-1
kubectl config use-context appl-cluster-admin@appl-cluster
```
