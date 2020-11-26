The ``tkg-services`` cluster used for shared services is currently running a Harbor instance. Before you delete this cluster you should ensure you delete the Harbor instance first. If you do not do this, the storage volumes it uses may not be cleaned up in AWS and you will need to manually go into the AWS EC2 dashboard and delete them.

Before attempting to delete the Harbor instance, ensure the current context for ``kubectl`` is set to the ``tkg-services`` cluster by running:

```execute-1
kubectl config use-context tkg-services-admin@tkg-services
```

To delete the Harbor instance first delete the extension definition used to deploy it:

```execute-1
kubectl delete extension/harbor -n tanzu-system-registry
```

Deleting this doesn't actually result in Harbor being deleted, it just removes the record of the extension. To delete the deployment of Harbor you also need to run:

```execute-1
kubectl delete app/harbor -n tanzu-system-registry
```

To monitor progress of the deployment being deleted run:

```execute-1
kubectl get app harbor -n tanzu-system-registry -w
```

This should start outputing a status line saying the deployment is being deleted.

```
NAME     DESCRIPTION   SINCE-DEPLOY   AGE
harbor   Deleting      5s             10m
```

The line with the description "Deleting" will be periodically output until the deletion has completed. When it finally stops, you can stop monitoring it.

```terminal:interrupt
session: 1
```

To double check it has been deleted you can run:

```execute-1
kubectl get app harbor -n tanzu-system-registry
```

This should indicate that the resource cannot be found.

With Harbor deleted, it is now safe to delete the cluster by running:

```execute-1
tkg delete cluster tkg-services
```

When prompted, confirm deletion by entering ``y``.

```terminal:input
text: y
```

This should output:

```
Workload cluster 'tkg-services' is being deleted
```

and deletion of the workload cluster will be scheduled.

While the cluster is being deleted, you can run:

```execute-1
tkg get clusters
```

and you should see the status as being deleted:

```
NAME        NAMESPACE  STATUS    CONTROLPLANE  WORKERS  KUBERNETES        ROLES  
tkg-services  default    deleting  1/1                    v1.19.1+vmware.2  <none> 
```

Keep running this command periodically to ensure that the workload cluster has been completely deleted before continuing.
