Harbor is a registry for storing content such as container images and Helm charts.

The Kubernetes resources used for deploying Harbor can be found in the ``tkg-extensions-v1.2.0+vmware.1/extensions/registry/harbor`` directory.

Installation of Harbor involves a number of steps as it is necessary to prepare the configuration which customizes the Harbor deployment.

The first step is to create the namespace in which Harbor will be deployed, along with a service account with required roles.

To create these run:

```execute-1
kubectl apply -f tkg-extensions-v1.2.0+vmware.1/extensions/registry/harbor/namespace-role.yaml
```

This should output:

```
namespace/tanzu-system-registry created
serviceaccount/harbor-extension-sa created
role.rbac.authorization.k8s.io/harbor-extension-role created
rolebinding.rbac.authorization.k8s.io/harbor-extension-rolebinding created
clusterrole.rbac.authorization.k8s.io/harbor-extension-cluster-role created
clusterrolebinding.rbac.authorization.k8s.io/harbor-extension-cluster-rolebinding created
```

The next step is to declare the configuration for Harbor and a sample configuration file is provided for this which can be found at ``tkg-extensions-v1.2.0+vmware.1/extensions/registry/harbor/harbor-data-values.yaml.example``.

...


The instructions for installing Harbor are not yet complete. [Jump ahead](../deleting-the-clusters/01-delete-workload-clusters) to section on deleting clusters.
