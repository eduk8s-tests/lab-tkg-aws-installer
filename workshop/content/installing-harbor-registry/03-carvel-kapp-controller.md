The Carvel Kapp controller is used to manage the deployment of the TKG extensions.

The controller implements a Kubernetes API for facilitating deployment of applications by specifying the details of the application to be deployed using a custom resource. The controller includes support for deploying applications which make use of plain Kubernetes resources, Helm charts, Carvel ``ytt`` templates, or Jsonnet templates.

The Kubernetes resources for deploying the controller can be found in the file ``extensions/kapp-controller.yaml``.

To deploy the Kapp controller run:

```execute-1
kubectl apply -f extensions/kapp-controller.yaml
```

This should output:

```
serviceaccount/kapp-controller-sa created
customresourcedefinition.apiextensions.k8s.io/apps.kappctrl.k14s.io created
deployment.apps/kapp-controller created
clusterrole.rbac.authorization.k8s.io/kapp-controller-cluster-role created
clusterrolebinding.rbac.authorization.k8s.io/kapp-controller-cluster-role-binding created
```

To monitor the rollout of the Kapp controller and wait for it to complete before continuing, you can run:

```execute-1
kubectl rollout status deployment.apps/kapp-controller -n vmware-system-tmc
```

When the deployment is complete it should output:

```
deployment "kapp-controller" successfully rolled out
```
