The management cluster is a complete Kubernetes cluster with the cluster management API added to it.

Although the main purpose of the cluster is to act as a management point for creating additional workload clusters, it is still a Kubernetes cluster and you can if you wish deploy additional applications directly to it, especially common services required by any workload clusters you create. This avoids the waste from leaving the cluster otherwise sitting idle.

You should though be careful in deploying to the management cluster applications which are public facing on the internet. This is because your AWS credentials are cached in a secret stored within the management cluster. If your application were compromised and an intruder gained access from the application pod to the Kubernetes REST API with cluster admin role, they could get access to your AWS credentials.

When the management cluster is deployed, the credentials for accessing the REST API for the cluster are automatically added to the configuration for ``kubectl`` stored in the ``$HOME/.kube/config`` file.

To list all the contexts which can be selected using ``kubectl`` run:

```execute-1
kubectl config get-contexts
```

This should output a result similar to:

```
CURRENT   NAME                              CLUSTER        AUTHINFO             NAMESPACE
*         mgmt-cluster-admin@mgmt-cluster   mgmt-cluster   mgmt-cluster-admin   
```

This should match the details of the management cluster returned when you ran ``tkg get management-clusters``.

The context should be marked as the current context, so you can run ``kubectl`` commands against it. If it isn't marked as the current context, run:

```execute-1
kubectl config use-context mgmt-cluster-admin@mgmt-cluster
```

With the current context set to be the management cluster you should be able to do an operation such as list the nodes in the cluster.

```execute-1
kubectl get nodes
```

This should yield output similar to:

```
NAME                                            STATUS   ROLES    AGE     VERSION
ip-10-0-1-101.ap-southeast-2.compute.internal   Ready    master   4h2m    v1.19.1+vmware.2
ip-10-0-1-249.ap-southeast-2.compute.internal   Ready    <none>   3h58m   v1.19.1+vmware.2
```
