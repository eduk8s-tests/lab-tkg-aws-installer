The ``tkg`` command line client, in addition to being used to create management clusters, is also used to interact with the management cluster and create workload clusters.

To see the full list of commands that ``tkg`` provides run:

```execute-1
tkg help
```

To see the current management cluster, run:

```execute-1
tkg get management-clusters
```

You should see the output:

```
MANAGEMENT-CLUSTER-NAME  CONTEXT-NAME                     STATUS  
mgmt-cluster *           mgmt-cluster-admin@mgmt-cluster  Success  
```

The only management cluster you should see is the one you just created.

If a name for the management cluster hadn't been provided, a generated name will have been used.

The '*' along side the name of the cluster indicates it is the current management cluster which subsequent actions performed using ``tkg`` will operate against.

If you were to run ``tkg init`` again, you could create additional management clusters and more than one would be listed. In the case of multiple management clusters you would need to ensure you have correctly selected the management cluster you want to work with. This can be done using the ``tkg set management-cluster`` command.

The details of the clusters you can interact with using the ``tkg`` command line tool are stored in the file ``$HOME/.tkg/config.yaml``.

```execute-1
cat $HOME/.tkg/config.yaml
```

This in turn references the file ``$HOME/.kube-tkg/config``, which contains the client certificates which permit access to the management cluster.

```execute-1
cat $HOME/.kube-tkg/config
```

Do not accidentally delete any files in these directories as you will need them in order to easily delete any clusters, including the management cluster. If you loose copies of these files, you will need to manually delete the various components which make up the deployed clusters using the AWS EC2 management console.
