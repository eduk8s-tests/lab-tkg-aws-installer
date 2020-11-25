The management cluster now knows which cluster is being used for the shared services such as Harbor. In order that any workload clusters which are subsequently created can use the Harbor instance, it is necessary to provide further details about how to access the Harbor instance to the management cluster. When the management cluster is used to create new workload clusters, those details will also be supplied to the workload cluster.

In order to have these details for Harbor injected into the workload cluster, it is necessary to install the Tanzu Kubernetes Grid Connectivity API into the management cluster. The connectivity API connects Kubernetes nodes that are running in workload clusters to the Harbor shared service. It also injects the Harbor CA certificate and other connectivity API related configuration into workload cluster nodes.

The connectivity API bundle was already downloaded previously and can be found in the ``~/work/manifests`` directory.

Change the working directory to that directory.

```execute-1
cd ~/work/manifests
```

The specific file we need to update is ``tanzu-registry/values.yaml``. Run:

```execute-1
cat tanzu-registry/values.yaml
```

to see the current contents of the file. You should find:

```
#@data/values
---
image: registry.tkg.vmware.run/tkg-connectivity/tanzu-registry-webhook:v1.2.0_vmware.2
imagePullPolicy: IfNotPresent
registry:
  # [REQUIRED] If "true", configures every Machine to enable connectivity to Harbor, do nothing otherwise.
  enabled:
  # [REQUIRED] If "true", override DNS for Harbor's FQDN by injecting entries into /etc/hosts of every machine, do nothing otherwise.
  dnsOverride:
  # [REQUIRED] FQDN used to connect Harbor
  fqdn:
  # [REQUIRED] the VIP used to connect to Harbor.
  vip:
  # [REQUIRED] If "true", iptable rules will be added to proxy connections to the VIP to the harbor cluster.
  # If "false", the IP address specified the 'vip' field should be a routable address in the network.
  bootstrapProxy:
  # [REQUIRED] The root CA containerd should trust in every cluster.
  rootCA:
```

Make a copy of the original file before making changes to it:

```execute-1
cp tanzu-registry/values.yaml tanzu-registry/values.yaml.example
```

None of the settings have default values, so it is necessary to set all values.

Set ``registry.enabled`` to ``true`` by running:

```execute-1
sed -i 's/^\( *\)enabled: *$/\1enabled: "true"/' tanzu-registry/values.yaml
```

This setting enables the configuration of workload clusters which are created to use the Harbor instance.

Set ``registry.dnsOverride`` to ``false``.

```execute-1
sed -i 's/^\( *\)dnsOverride: *$/\1dnsOverride: "false"/' tanzu-registry/values.yaml
```

This is disabled because the hostname we are using for Harbor is public. 

Set ``registry.fqdn`` to be the hostname for the Harbor instance. We have the hostname saved away in the ``HARBOR_HOSTNAME`` environment variable, so run:

```execute-1
sed -i "s/^\( *\)fqdn: *$/\1fqdn: $HARBOR_HOSTNAME/" tanzu-registry/values.yaml
```

Set ``registry.vip`` to be the IP address of the inbound ingress for the Contour load balancer. We have the IP address saved away in the ``CONTOUR_ROUTER_ADDRESS`` environment variable, so run:

```execute-1
sed -i "s/^\( *\)vip: *$/\1vip: $CONTOUR_ROUTER_ADDRESS/" tanzu-registry/values.yaml
```

Set ``registry.bootstrapProxy`` to the ``false``.

```execute-1
sed -i 's/^\( *\)bootstrapProxy: *$/\1bootstrapProxy: "false"/' tanzu-registry/values.yaml
```

This is not required as for this guided installer we will not be populating the Harbor instance with images used when creating workload clusters. Also, because we aren't overriding DNS and are relying on a public hostname, the IP address also shouldn't strictly be used, but we set it anyway just in case.

Finally, we need to set ``registry.rootCA``. This has to be set to the certificate authority (CA) used for the inbound ingress of the Harbor instance.

The CA was previously saved to the file ``~/work/harbor-tls-ca-crt.txt``. To add this to the settings file run:

```execute-1
sed -i "s/^\( *\)rootCA: *$/\1rootCA: |/" tanzu-registry/values.yaml && \
  cat ~/work/harbor-tls-ca-crt.txt | sed -e 's/^/    /' | sed -i "/^\( *\)rootCA:/r /dev/stdin" tanzu-registry/values.yaml
```

To see the end result of the changes run:

```execute-1
cat tanzu-registry/values.yaml
```

As this is a values file for input to ``ytt``, all values need to be strings, thus the boolean values were quoted.

The Tanzu Kubernetes Grid Connectivity API consists of two components, a webhook service and an operator.

To deploy the webhook service run:

```execute-1
ytt --ignore-unknown-comments -f tanzu-registry | kubectl apply -f - 
```

This should output:

```
namespace/tanzu-system-registry created
issuer.cert-manager.io/tanzu-registry-webhook created
certificate.cert-manager.io/tanzu-registry-webhook-certs created
configmap/tanzu-registry-configuration created
service/tanzu-registry-webhook created
serviceaccount/tanzu-registry-webhook created
clusterrolebinding.rbac.authorization.k8s.io/tanzu-registry-webhook created
clusterrole.rbac.authorization.k8s.io/tanzu-registry-webhook created
deployment.apps/tanzu-registry-webhook created
mutatingwebhookconfiguration.admissionregistration.k8s.io/tanzu-registry-webhook created
```

To monitor the the status of the deployment run:

```execute-1
kubectl rollout status deployment/tanzu-registry-webhook -n tanzu-system-registry
```

To install the operator run:

```execute-1
ytt -f tkg-connectivity-operator | kubectl apply -f -
```

This should output:

```
namespace/tanzu-system-connectivity created
serviceaccount/tkg-connectivity-operator created
deployment.apps/tkg-connectivity-operator created
clusterrolebinding.rbac.authorization.k8s.io/tkg-connectivity-operator created
clusterrole.rbac.authorization.k8s.io/tkg-connectivity-operator created
configmap/tkg-connectivity-docker-image-config created
```

To monitor the the status of the deployment run:

```execute-1
kubectl rollout status deployment/tkg-connectivity-operator -n tanzu-system-connectivity
```
