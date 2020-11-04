If you run out of capacity in the workload cluster, you can increase the number of worker nodes. Alternatively, if you had more capacity than you needed, you could reduce the number of worker nodes. This can be done using the ``tkg scale cluster`` command.

To reduce the number of worker nodes for the ``dev-1`` cluster from 2 to 1, run:

```execute-1
tkg scale cluster dev-1 --worker-machine-count=1
```

This should return:

```
Successfully updated worker node machine deployment replica count for cluster dev-1
workload cluster dev-1 is being scaled
```

To verify the number of worker nodes the cluster now has, run again:

```execute-1
kubectl get nodes --kubeconfig=kubeconfig-dev-1.yaml
```

The output should be similar to the following, confirming that there is now only one worker node.

```
NAME                                            STATUS   ROLES    AGE   VERSION
ip-10-0-1-136.ap-southeast-2.compute.internal   Ready    <none>   22m   v1.19.1+vmware.2
ip-10-0-1-18.ap-southeast-2.compute.internal    Ready    master   24m   v1.19.1+vmware.2
```

If there had been applications deployed to the worker node which was shutdown, they would be evacuated from the node first, and provided there was sufficient remaining resources, restarted on the remaining worker node.
