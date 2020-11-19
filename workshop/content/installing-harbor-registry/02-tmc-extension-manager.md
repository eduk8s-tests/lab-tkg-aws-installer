The TMC extension manager implements a Kubernetes API providing services for tracking the installation of extensions. Although it references "Tanzu Mission Control" within the name, it is not the whole TMC product which is being installed, but is an API which just so happens to be usable in both TMC clusters and TKG clusters.

The Kubernetes resources for deploying the TMC extension manager can be found in the file ``tkg-extensions-v1.2.0+vmware.1/extensions/tmc-extension-manager.yaml``.

To deploy the Kapp controller run:

```execute-1
kubectl apply -f tkg-extensions-v1.2.0+vmware.1/extensions/tmc-extension-manager.yaml
```

This should output:

```
namespace/vmware-system-tmc created
customresourcedefinition.apiextensions.k8s.io/agents.clusters.tmc.cloud.vmware.com created
customresourcedefinition.apiextensions.k8s.io/extensions.clusters.tmc.cloud.vmware.com created
customresourcedefinition.apiextensions.k8s.io/extensionresourceowners.clusters.tmc.cloud.vmware.com created
customresourcedefinition.apiextensions.k8s.io/extensionintegrations.clusters.tmc.cloud.vmware.com created
customresourcedefinition.apiextensions.k8s.io/extensionconfigs.intents.tmc.cloud.vmware.com created
serviceaccount/extension-manager created
clusterrole.rbac.authorization.k8s.io/extension-manager-role created
clusterrolebinding.rbac.authorization.k8s.io/extension-manager-rolebinding created
service/extension-manager-service created
deployment.apps/extension-manager created
```

Note that the first thing created is the namespace ``vmware-system-tmc``. This namespace must exist when the subsequent step of installing the Kapp controller is run. Thus, it is important that the TMC extension manager is always installed first, as later steps will fail without it.

To monitor the rollout of the TMC extension manager and wait for it to complete before continuing, you can run:

```execute-1
kubectl rollout status deployment.apps/extension-manager -n vmware-system-tmc
```

When the deployment is complete it should output:

```
deployment "extension-manager" successfully rolled out
```
