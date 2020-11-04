The management cluster is a complete Kubernetes cluster with the cluster management API added to it.

Although the main purpose of the cluster is to act as a management point for creating additional workload clusters, it is still a Kubernetes cluster and you can if you wish deploy additional applications directly to it, especially common services required by any workload clusters you create. This avoids the waste from leaving the cluster otherwise sitting idle.

When the management cluster is deployed, the details are automatically added to the configuration for ``kubectl`` stored as ``$HOME/.kube/config``.

To list all the contexts which can be selected using ``kubectl`` run:

```execute-1
kubectl config get-contexts
```

This should output a result similar to:

```
CURRENT   NAME                                                            CLUSTER                       AUTHINFO                            NAMESPACE
*         tkg-mgmt-aws-20201104001924-admin@tkg-mgmt-aws-20201104001924   tkg-mgmt-aws-20201104001924   tkg-mgmt-aws-20201104001924-admin 
```

This should match the details of the management cluster returned when you ran ``tkg get management-cluster``.

The context should be marked as the current context, so you can run ``kubectl`` commands against it. If it isn't marked as the current context, run:

```
kubectl config use-context `tkg get management-clusters -o json | jq -r ".[0].context"`
```

You should then be able to do an operation such as list the nodes in the cluster.

```execute-1
kubectl get nodes
```

This should yield output similar to:

```
NAME                                            STATUS   ROLES    AGE     VERSION
ip-10-0-1-101.ap-southeast-2.compute.internal   Ready    master   4h2m    v1.19.1+vmware.2
ip-10-0-1-249.ap-southeast-2.compute.internal   Ready    <none>   3h58m   v1.19.1+vmware.2
```