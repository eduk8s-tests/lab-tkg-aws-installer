The Kubernetes ``cert-manager`` is used to manage the generation of certificates for use with secure connections between services, including use with externally exposed ingress routes.

The Kubernetes resources for deploying ``cert-manager`` can be found in the ``cert-manager`` directory.

To deploy ``cert-manager`` run:

```execute-1
kubectl apply -f cert-manager
```

This will generate a long list of resources which were created.

To monitor the rollout of the main ``cert-manager`` deployment and wait for it to complete before continuing, you can run:

```execute-1
kubectl rollout status deployment.apps/cert-manager -n cert-manager
```

When the deployment is complete it should output:

```
deployment "cert-manager" successfully rolled out
```
