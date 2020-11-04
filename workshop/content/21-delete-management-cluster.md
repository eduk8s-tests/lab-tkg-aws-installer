So long as you have deleted all the workload clusters managed through the management cluster, you can also delete the management cluster itself.

Double check that the workload cluster has been deleted by running:

```execute-1
tkg get clusters
```

To delete the management cluster use the ``tkg delete management-cluster`` command. You will need to provide the name of the management cluster as argument.

Since for this guided installer a generated name may have been used for the management cluster, you can use the command:

```execute-1
tkg delete management-cluster `tkg get management-clusters -o json | jq -r ".[0].name"`
```

This will confirm that you want to delete the management cluster. Enter ``y`` when prompted.

```terminal:input
text: y
```

The management cluster cannot manage its own deletion, so what will occur is a similar process to what occurred when the management cluster was originally created.

That is, a local management cluster will be created in the local docker service using Kind. That local management cluster will then be used to coordinate the deletion of the management cluster in AWS. Once that is complete, the local management cluster will also be deleted.

The result of running ``tkg delete management-cluster`` will be similar to:

```
Verifying management cluster...
Setting up cleanup cluster...
Installing providers to cleanup cluster...
Fetching providers
Installing cert-manager Version="v0.16.1"
Waiting for cert-manager to be available...
Installing Provider="cluster-api" Version="v0.3.10" TargetNamespace="capi-system"
Installing Provider="bootstrap-kubeadm" Version="v0.3.10" TargetNamespace="capi-kubeadm-bootstrap-system"
Installing Provider="control-plane-kubeadm" Version="v0.3.10" TargetNamespace="capi-kubeadm-control-plane-system"
Installing Provider="infrastructure-aws" Version="v0.5.5" TargetNamespace="capa-system"
Moving Cluster API objects from management cluster to cleanup cluster...
Performing move...
Discovering Cluster API objects
Moving Cluster API objects Clusters=1
Creating objects in the target cluster
Deleting objects from the source cluster
Waiting for the Cluster API objects to get ready after move...
Deleting management cluster...
Management cluster 'tkg-mgmt-aws-20201104053546' deleted.
Deleting the management cluster context from the kubeconfig file '/home/eduk8s/.kube/config'
warning: this removed your active context, use "kubectl config use-context" to select a different one

Management cluster deleted!
```

To confirm it has been deleted run:

```execute-1
tkg get management-clusters
```

Since we have been deploying clusters into AWS, you should also check the AWS EC2 dashboard to confirm the infrastructure components created for the clusters have been deleted. You may see listings for the EC2 instances created, but these should be marked as ``Terminated`` and the entries removed automatically after a period of time.
