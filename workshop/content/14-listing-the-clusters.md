The ``tkg`` command line client, in addition to being used to create management clusters, is also used to interact with the management cluster and create workload clusters.

To see the full list of commands that ``tkg`` provides run:

```execute-1
tkg help
```

To see the current management cluster, run:

```execute-1
tkg get management-clusters
```

You should see output similar to:

```
 MANAGEMENT-CLUSTER-NAME        CONTEXT-NAME                                                   STATUS  
 tkg-mgmt-aws-20201104001924 *  tkg-mgmt-aws-20201104001924-admin@tkg-mgmt-aws-20201104001924  Success 
```

The only management cluster you should see is the one you just created.

If you didn't provide a name for the management cluster, a generated name will have been used.

The '*' along side the name of the cluster indicates it is the current management cluster which subsequent actions performed using ``tkg`` will operate against.

If you were to run ``tkg init`` again, you could create additional management clusters and more than one would be listed. In the case of multiple management clusters you would need to ensure you have correctly select the management cluster you want to work with. This can be done using the ``tkg set management-cluster`` command.
