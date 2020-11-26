If you no longer require a workload cluster, it can be deleted using the ``tkg delete cluster`` command.

Do note however that it may be necessary to first ensure you have deleted any applications deployed to the cluster.

This is necessary to ensure that any load balancers, storage volumes, or managed services created in AWS due to a deployment are properly cleaned up. If you do not do this and delete the cluster, controllers running in Kubernetes which would normally cleanup such resources in AWS, may not get enough time to run to do the job before they get deleted.

Any such manual steps you may need to take are explained in:

* https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-tanzu-k8s-clusters-delete-cluster.html

For the ``appl-cluster`` cluster we created for deploying applications, it is now empty and Contour doesn't consume and storage, so it is safe to delete it.

To delete it run:

```execute-1
tkg delete cluster appl-cluster
```

When prompted, confirm deletion by entering ``y``.

```terminal:input
text: y
```

This should output:

```
Workload cluster 'appl-cluster' is being deleted
```

and deletion of the workload cluster will be scheduled.

While the cluster is being deleted, you can run:

```execute-1
tkg get clusters
```

and you should see the status as being deleted:

```
NAME          NAMESPACE  STATUS    CONTROLPLANE  WORKERS  KUBERNETES        ROLES  
appl-cluster  default    deleting  1/1                    v1.19.1+vmware.2  <none> 
```

Keep running this command periodically to ensure that the workload cluster has been completely deleted before continuing.
