The deployment of the management cluster to AWS is a two step process. The ``tkg`` installer doesn't create the management cluster directly in AWS. What happens is that the ``tkg`` installer will first create a local management cluster running in your local docker service.

The local management cluster is a normal Kubernetes cluster created using [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/). Kind is a tool which is usually used for creating disposable Kubernetes clusters for helping develop and test Kubernetes itself, although it can also be used for deploying your own applications during development. Kind is not regarded as a production grade cluster.

Into the Kubernetes cluster created using Kind is deployed a set of services which implement the Kubernetes [cluster management API](https://github.com/kubernetes-sigs/cluster-api). This API provides a mechanism for creating additional  Kubernetes clusters using the declarative API model of Kubernetes.

The Kubernetes cluster management API supports a range of different providers. That is, it can work with managed Infrastructure as a Service providers such as AWS EC2 and Microsoft Azure, or with VMware vSphere.

In our current case, the cluster management API provider for AWS EC2 is being used.

The sequence therefore is that the local management cluster is created using Kind with the cluster management API installed, and the provider for AWS EC2 available.

Once the local management cluster is up and running, the Kubernetes API for the local management cluster is used to create the resources describing the details of a Kubernetes cluster hosted in AWS. The cluster management API services will then create a Kubernetes cluster in AWS matching the requirements specified by the resource.

As the intent is for the Kubernetes cluster in AWS to be the management cluster, the cluster management API is also installed into that cluster. This turns the Kubernetes cluster in AWS into a full fledged management cluster.

With the management cluster now running in AWS, the local management cluster created using Kind is deleted. The local configuration for ``tkg`` is updated to point to the management cluster in AWS, and the local configuration for ``kubectl`` also updated to refer to the same cluster.

This whole process can take a little while, especially the first time it is run, as the container images required to run the Kind cluster and implement the cluster management API need to be pulled down to the local machine and run. This then needs to be repeated in AWS, although instead of a Kind cluster being used in that case, it is Tanzu Kubernetes Grid (TKG) cluster which is beind deployed to AWS.

When the process is complete, the ``tkg`` installer should output in the log view within the browser the following messages.

```
ℹ [1104 00:36:45.77844]: client.go:147] Deleting kind cluster: tkg-kind-bugv734fh0bgtp7jq3e0
ℹ [1104 00:36:47.12364]: init.go:144] Management cluster created!
ℹ [1104 00:36:47.12375]: init.go:145] You can now create your first workload cluster by running the following:
ℹ [1104 00:36:47.12391]: init.go:146] tkg create cluster [name] --kubernetes-version=[version] --plan=[plan]
```

Once you see these messages indicating the process has completed, you can close the installer dashboard by clicking below.

```dashboard:delete-dashboard
name: Installer
```

and also the dashboard used to launch the installer.

```dashboard:delete-dashboard
name: Launcher
```


