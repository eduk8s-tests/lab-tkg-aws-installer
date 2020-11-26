If you no longer require a workload cluster, it can be deleted using the ``tkg delete cluster`` command.

Do note however that it may be necessary to first ensure you have deleted any applications deployed to the cluster.

This is necessary to ensure that any load balancers, storage volumes, or managed services created in AWS due to a deployment are properly cleaned up. If you do not do this and delete the cluster, controllers running in Kubernetes which would normally cleanup such resources in AWS, may not get enough time to run to do the job before they get deleted.

Any such manual steps you may need to take are explained in:

* https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-tanzu-k8s-clusters-delete-cluster.html
