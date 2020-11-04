Rather than deploy your applications into the management cluster, you would create a new workload cluster and use it.

To see what workload clusters may already exist you can run:

```execute-1
tkg get clusters
```

For now there should not be any and this will return:

```
NAME  NAMESPACE  STATUS  CONTROLPLANE  WORKERS  KUBERNETES  ROLES
```

To create a new workload cluster, you can use the ``tkg create cluster`` command.

To see the options the command accepts, run:

```execute-1
tkg create cluster --help
```

Besides providing a name for the workload cluster, the one option you must supply is that specifying the plan to use when creating the workload cluster. This is done using the ``--plan`` option.

Two different plans are provided which you can select from. These are:

* ``dev`` - Deploys a cluster with one control plane node and one worker node.
* ``prod`` - Deploys a cluster with three control plane nodes and three worker nodes.

If you provide no other options then details such as the Kubernetes version, and the instance size for the control plane and worker nodes, are inherited from what was used to deploy the management cluster.

The Kubernetes version can be overridden using the ``--kubernetes-version`` option, but you will need to know the version identifier string corresponding to the version you wish to use. You can get a listing of the versions available by running:

```execute-1
tkg get kubernetesversions
```

The instance types used for the control plane and worker nodes can be overridden using the ``--controlplane-size`` and ``--worker-size`` options. If you are intending to scale out the number of worker nodes, you would want to override the size of the control plane node. Guidelines for the size of the control plane node were referenced previously when working through the steps to deploy the management cluster.

The number of control plane and worker nodes will be dictated by the plan. The number of each can be overridden using the ``--controlplane-machine-count`` and ``--worker-machine-count`` options.

Before actually committing to creating a workload cluster, you can use the ``--dry-run`` option to see what resources would be created. To see the resources for a development cluster with 2 worker nodes and instance type of ``m4.xlarge``, run:

```execute-1
tkg create cluster dev-1 --plan=dev --worker-size=m4.xlarge --worker-machine-count=2 --dry-run
```

Now create the cluster by running:

```execute-1
tkg create cluster dev-1 --plan=dev --worker-size=m4.xlarge --worker-machine-count=2
```

Because we now have the management cluster in AWS, it handles the creation of the new workload cluster, and there is no need to create a local management cluster to bootstrap it.

The output from the command should be similar to:

```
Logs of the command execution can also be found at: /tmp/tkg-20201104T080926981867688.log
Validating configuration...
Creating workload cluster 'dev-1'...
Waiting for cluster to be initialized...
Waiting for cluster nodes to be available...
Waiting for addons installation...

Workload cluster 'dev-1' created
```

How long this takes will depend on the size of the cluster. For a small cluster of this size it should take about 10 minutes.

To verify the cluster is registered with the management cluster, run:

```execute-1
tkg get clusters
```

This should yield:

```
NAME   NAMESPACE  STATUS   CONTROLPLANE  WORKERS  KUBERNETES        ROLES  
dev-1  default    running  1/1           2/2      v1.19.1+vmware.2  <none>
```
