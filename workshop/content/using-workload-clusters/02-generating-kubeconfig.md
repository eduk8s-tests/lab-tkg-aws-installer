If the workload cluster is to be used by a different operations team or set of developers, you next need to generate a ``kubeconfig`` file they can use to access the cluster. This is done using the ``tkg get credentials`` command. Run this against the ``tkg-services`` workload cluster you just created.

```execute-1
tkg get credentials tkg-services --export-file kubeconfig-tkg-services.yaml
```

It should output:

```
Credentials of workload cluster 'tkg-services' have been saved 
You can now access the cluster by running 'kubectl config use-context tkg-services-admin@tkg-services' under path 'kubeconfig-tkg-services.yaml'
```

If you do not specify the ``--export-file`` option and the name of a file to save the configuration to, it will be added to your current configuration for ``kubectl``, but you will need to switch to the context for the workload cluster before you can use it.

To verify the separate generated configuration file works, run:

```execute-1
kubectl get nodes --kubeconfig=kubeconfig-tkg-services.yaml
```

In this case, since the workload cluster was created with 2 worker nodes, you should see output similar to:

```
NAME                                            STATUS   ROLES    AGE   VERSION
ip-10-0-1-136.ap-southeast-2.compute.internal   Ready    <none>   14m   v1.19.1+vmware.2
ip-10-0-1-16.ap-southeast-2.compute.internal    Ready    <none>   14m   v1.19.1+vmware.2
ip-10-0-1-18.ap-southeast-2.compute.internal    Ready    master   16m   v1.19.1+vmware.2
```
