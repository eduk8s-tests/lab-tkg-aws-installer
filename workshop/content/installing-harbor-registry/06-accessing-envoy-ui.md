To further validate that Contour has been deployed correctly, you can access the Envoy administration user interface. This isn't publicly exposed, so you will need to setup port forwarding to your local machine for the Envoy pod.

To determine the name of the Envoy pod run:

```execute-1
ENVOY_POD=$(kubectl -n tanzu-system-ingress get pod -l app=envoy -o name | head -1)
```

The name of the pod will be saved into the ``ENVOY_POD`` environment variable.

Now set up the port forwarding by running:

```execute-1
kubectl -n tanzu-system-ingress port-forward $ENVOY_POD 9001
```

If you were doing this on your own machine you would now be able to access the Envoy administration user interface at ``http://localhost:9001``. Because you are running this in the environment of the guided installer, instead open a new dashboard tab by clicking below.

```dashboard:create-dashboard
name: Envoy
url: {{ingress_protocol}}://{{session_namespace}}-envoy.{{ingress_domain}}{{ingress_port_suffix}}/
```

Because of how the Envoy user interface is embedded within the guided installer environment, depending on the browser being used, in order to go back to the previous page in the Envoy user interface you will need to use "Back" from the context menu brought up by right clicking in the Envoy page. Using the browser back button may not work and may throw you out of the installer, so use the context menu instead.

When finished looking around close the dashboard tab by clicking below.

```dashboard:delete-dashboard
name: Envoy
```

Also stop the port forwarding.

```terminal:interrupt
session: 1
```
