Contour is an ingress controller for Kubernetes which uses the Envoy proxy as a reverse proxy and load balancer. In addition to supporting use of the standard Kubernetes Ingress resource, Contour implements a custom resource called ``HTTPProxy`` for more advanced functionality over and above the standard ingress mechanism.

The Kubernetes resources used for deploying Contour can be found in the ``tkg-extensions-v1.2.0+vmware.1/extensions/ingress/contour`` directory.

Installation of Contour involves a number of steps as it is necessary to prepare the configuration which customizes the Contour deployment.

The first step is to create the namespace in which Contour will be deployed, along with a service account with required roles.

To create these run:

```execute-1
kubectl apply -f tkg-extensions-v1.2.0+vmware.1/extensions/ingress/contour/namespace-role.yaml
```

This should output:

```
namespace/tanzu-system-ingress created
serviceaccount/contour-extension-sa created
role.rbac.authorization.k8s.io/contour-extension-role created
rolebinding.rbac.authorization.k8s.io/contour-extension-rolebinding created
clusterrole.rbac.authorization.k8s.io/contour-extension-cluster-role created
clusterrolebinding.rbac.authorization.k8s.io/contour-extension-cluster-rolebinding created
```

The next step is to declare the configuration for Contour and sample configuration files are provided for this depending on what infrastructure provider is being used. The sample configuration for AWS EC2 can be found at ``tkg-extensions-v1.2.0+vmware.1/extensions/ingress/contour/aws/contour-data-values.yaml.example``.

To view the contents of the same configuration run:

```execute-1
cat tkg-extensions-v1.2.0+vmware.1/extensions/ingress/contour/aws/contour-data-values.yaml.example
```

It should contain:

```
#@data/values
#@overlay/match-child-defaults missing_ok=True
---
infrastructure_provider: "aws"
contour:
  image:
    repository: registry.tkg.vmware.run
envoy:
  image:
    repository: registry.tkg.vmware.run
```

The configuration is in a format for use with the Carvel ``ytt`` template that is used for deployment of Contour.

For our use case the default configuration is sufficient, so we can copy the sample configuration as is:

```execute-1
cp tkg-extensions-v1.2.0+vmware.1/extensions/ingress/contour/aws/contour-data-values.yaml.example tkg-extensions-v1.2.0+vmware.1/extensions/ingress/contour/aws/contour-data-values.yaml
```

If you a need to customize the configuration an explanation of the settings values that can be set are listed in the file ``tkg-extensions-v1.2.0+vmware.1/ingress/contour/README.md``.

Having copied and customized the configuration if necessary, a Kubernetes secret needs to be created which holds the configuration.

```execute-1
kubectl create secret generic contour-data-values --from-file=values.yaml=tkg-extensions-v1.2.0+vmware.1/extensions/ingress/contour/aws/contour-data-values.yaml -n tanzu-system-ingress
```

This should output:

```
secret/contour-data-values created
```

This secret is created in the namespace ``tanzu-system-ingress`` created above for deployment of Contour. The configuration needs to be loaded as a secret into Kubernetes so that the TMC extension manager can find it when Contour is being deployed.

To perform the deployment of Contour run:

```execute-1
kubectl apply -f tkg-extensions-v1.2.0+vmware.1/extensions/ingress/contour/contour-extension.yaml
```

This should output:

```
extension.clusters.tmc.cloud.vmware.com/contour created
```

To view the state of the deployment using the TMC extension manager, you can run:

```execute-1
kubectl get extension contour -n tanzu-system-ingress
```

This should output:

```
NAME      STATE   HEALTH   VERSION
contour   3 
```

To monitor the state of the Contour application as it is in turn deployed by the Kapp controller run:

```execute-1
kubectl get app contour -n tanzu-system-ingress -w
```

This will provide continuous updates as deployment proceeds. Wait until it shows a status of "Reconcile succeeded".

```
NAME      DESCRIPTION           SINCE-DEPLOY   AGE
contour   Reconcile succeeded   60s            120s
```

You can then interrupt the monitor:

```terminal:interrupt
session: 1
```

The state of individual pods which make up the deployment of Contour can be seen by running:

```execute-1
kubectl get pods -n tanzu-system-ingress
```

The output should be similar to:

```
NAME                       READY   STATUS    RESTARTS   AGE
contour-59cdc65ff7-48jmr   1/1     Running   0          180s
contour-59cdc65ff7-rfpvp   1/1     Running   0          180s
envoy-7pdbv                2/2     Running   0          180s
```

When the Contour extension is deployed to AWS EC2, it will be automatically assigned an external load balancer and made public. You can view the hostname assigned to the load balancer by running:

```execute-1
kubectl get svc envoy -n tanzu-system-ingress -o jsonpath='{.status.loadBalancer.ingress[0].hostname}{"\n"}'
```

You should see something similar to:

```
a6b7ff55a1e37468c951083654265009-1928631550.ap-southeast-2.elb.amazonaws.com
```
