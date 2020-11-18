If you no longer require a workload cluster, it can be deleted using the ``tkg delete cluster`` command.

Do note however that it may be necessary to first ensure you have manually deleted any load balancers, volumes and services. Any such manual steps you may need to take are explained in:

* https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-tanzu-k8s-clusters-delete-cluster.html

To delete the ``dev-1`` workload cluster you created, run:

```execute-1
tkg delete cluster dev-1
```

When prompted, confirm deletion by entering ``y``.

```terminal:input
text: y
```

This should output:

```
Workload cluster 'dev-1' is being deleted
```

and deletion of the workload cluster will be scheduled.

While the cluster is being deleted, you can run:

```execute-1
tkg get clusters
```

and you should see the status as being deleted:

```
NAME   NAMESPACE  STATUS    CONTROLPLANE  WORKERS  KUBERNETES        ROLES  
dev-1  default    deleting  1/1                    v1.19.1+vmware.2  <none> 
```

Keep running this command periodically to ensure that the workload cluster has been completely deleted before continuing.
