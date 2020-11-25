Installation of Harbor has been completed, but in order to be able to use it from any separate workload clusters, there are a few more steps that need to be done. These changes are going to be run in the management cluster so we need to switch the context back to it.

First see what the available contexts are by running:

```execute-1
kubectl config get-contexts
```

This should output:

```
CURRENT   NAME                                                            CLUSTER                       CURRENT   NAME                              CLUSTER        AUTHINFO             NAMESPACE
          mgmt-cluster-admin@mgmt-cluster   mgmt-cluster   mgmt-cluster-admin   
*         tkg-services-admin@tkg-services   tkg-services   tkg-services-admin 
```

To set the context for ``kubectl`` to the management cluster run:

```execute-1
kubectl config use-context mgmt-cluster-admin@mgmt-cluster
```

Now that we are working with the managment cluster, use ``tkg`` to get a list of all clusters which exists, including the management cluster.

```execute-1
tkg get clusters --include-management-cluster
```

This should yield output similar to:

```
NAME          NAMESPACE   STATUS   CONTROLPLANE  WORKERS  KUBERNETES        ROLES      
tkg-services  default     running  1/1           1/1      v1.19.1+vmware.2  <none>     
mgmt-cluster  tkg-system  running  1/1           1/1      v1.19.1+vmware.2  management 
```

We need to update the role label shown for the shared services cluster which you can currently see is set to ``<none>``. This information is maintained in the management cluster and why we need to switch the context back to it.

To update the role and set it to ``tanzu-services``, run:

```execute-1
kubectl label cluster.cluster.x-k8s.io/tkg-services cluster-role.tkg.tanzu.vmware.com/tanzu-services="" --overwrite=true
```

List the clusters again:

```execute-1
tkg get clusters --include-management-cluster
```

You should now see that the role is updated.

```        
NAME          NAMESPACE   STATUS   CONTROLPLANE  WORKERS  KUBERNETES        ROLES          
tkg-services  default     running  1/1           1/1      v1.19.1+vmware.2  tanzu-services 
mgmt-cluster  tkg-system  running  1/1           1/1      v1.19.1+vmware.2  management   
```

This step is required so that the management cluster knows that specific cluster is dedicated to shared services such as Harbor.
