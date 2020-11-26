To be able to install Contour we first need to install the TMC extensions manager, Carvel Kapp controller and ``cert-manager``.

Change back to the directory ``~/work/tkg-extensions-v1.2.0+vmware.1``:

```execute-1
cd ~/work/tkg-extensions-v1.2.0+vmware.1
```

To deploy the TMC extensions manager run:

```execute-1
kubectl apply -f extensions/tmc-extension-manager.yaml
```

To monitor the rollout of the TMC extension manager and wait for it to complete before continuing run:

```execute-1
kubectl rollout status deployment.apps/extension-manager -n vmware-system-tmc
```

To deploy the Kapp controller run:

```execute-1
kubectl apply -f extensions/kapp-controller.yaml
```

To monitor the rollout of the Kapp controller and wait for it to complete before continuing run:

```execute-1
kubectl rollout status deployment.apps/kapp-controller -n vmware-system-tmc
```

To deploy ``cert-manager`` run:

```execute-1
kubectl apply -f cert-manager
```

To monitor the rollout of the main ``cert-manager`` deployment and wait for it to complete before continuing run:

```execute-1
kubectl rollout status deployment.apps/cert-manager -n cert-manager
```

To deploy Contour, first create the namespace and service accounts for it:

```execute-1
kubectl apply -f extensions/ingress/contour/namespace-role.yaml
```

Make a copy of the default configuration by running:

```execute-1
cp extensions/ingress/contour/aws/contour-data-values.yaml.example extensions/ingress/contour/aws/contour-data-values.yaml
```

Create the secret from the configuration:

```execute-1
kubectl create secret generic contour-data-values --from-file=values.yaml=extensions/ingress/contour/aws/contour-data-values.yaml -n tanzu-system-ingress
```

and deploy Contour by running:

```execute-1
kubectl apply -f extensions/ingress/contour/contour-extension.yaml
```

To monitor the state of the Contour deployment run:

```execute-1
kubectl get app contour -n tanzu-system-ingress -w
```

This will provide continuous updates as deployment proceeds. Wait until it shows a stable status of "Reconcile succeeded".

```
NAME      DESCRIPTION           SINCE-DEPLOY   AGE
contour   Reconcile succeeded   60s            120s
```

You can then interrupt the monitor:

```terminal:interrupt
session: 1
```

The workload cluster is then all setup ready to deploy an application. Before we do that though, calculate the IP address for the inbound ingress router of Contour, as we will need that when working out the hostname for our test application.

First grab the hostname of the inbound ingress router.

```execute-1
CLUSTER_ROUTER_HOSTNAME=`kubectl get svc envoy -n tanzu-system-ingress -o jsonpath='{.status.loadBalancer.ingress[0].hostname}{"\n"}'`; echo $CLUSTER_ROUTER_HOSTNAME
```

Then work out the IP address of it.

```execute-1
CLUSTER_ROUTER_ADDRESS=`python3 -c "import socket; print(socket.gethostbyname('$CLUSTER_ROUTER_HOSTNAME'))"`; echo $CLUSTER_ROUTER_ADDRESS
```

We will use this in a ``nip.io`` hostname later so you don't need to have your own DNS name.
