Harbor is a registry for storing content such as container images and Helm charts.

The Kubernetes resources used for deploying Harbor can be found in the ``extensions/registry/harbor`` directory.

Installation of Harbor involves a number of steps as it is necessary to prepare the configuration which customizes the Harbor deployment.

The first step is to create the namespace in which Harbor will be deployed, along with a service account with required roles.

To create these run:

```execute-1
kubectl apply -f extensions/registry/harbor/namespace-role.yaml
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

The next step is to declare the configuration for Harbor and a sample configuration file is provided for this which can be found at ``extensions/registry/harbor/harbor-data-values.yaml.example``.

Make a copy of the example file:

```execute-1
cp extensions/registry/harbor/harbor-data-values.yaml.example extensions/registry/harbor/harbor-data-values.yaml
```

The key configuration settings in this file are the hostname to be used to access the Harbor instance, and an initial administrator password.

There are also settings for defining other passwords and secrets used internally between components of Harbor but these can be generated as you wouldn't normally need to know them. To set random passwords and secrets in the settings file, run:

```execute-1
extensions/registry/harbor/generate-passwords.sh extensions/registry/harbor/harbor-data-values.yaml
```

For the administrator password, change the generated value to a known password which you can remember. To set the administrator password to "Harbor1234" run:

```execute-1
sed -i "s/^harborAdminPassword:.*/harborAdminPassword: Harbor1234/" extensions/registry/harbor/harbor-data-values.yaml
```

Next you will want to override the hostname for the Harbor instance.

If you own a domain name and control your DNS server, you can setup a hostname in DNS. This should be setup to use a DNS CNAME record which refers to the hostname of the inbound ingress router for the Contour instance you deployed earlier. You can get the hostname of the inbound ingress router by running:

```execute-1
SERVICES_ROUTER_HOSTNAME=`kubectl get svc envoy -n tanzu-system-ingress -o jsonpath='{.status.loadBalancer.ingress[0].hostname}{"\n"}'`; echo $SERVICES_ROUTER_HOSTNAME
```

If you are using your own hostname for the Harbor instance and have an SSL certificate covering the hostname, you would need to add the details of it into the settings file.

For this guided installer, rather than rely on you having your own domain name, we will use a method which allows us to use a ``nip.io`` address for the Harbor instance.

To do this we first need to determine the IP address corresponding to the inbound ingress router for the Contour instance. To determine this run:

```execute-1
SERVICES_ROUTER_ADDRESS=`python3 -c "import socket; print(socket.gethostbyname('$SERVICES_ROUTER_HOSTNAME'))"`; echo $SERVICES_ROUTER_ADDRESS
```

Next we will construct a ``nip.io`` hostname for Harbor using this IP address.

```execute-1
HARBOR_HOSTNAME=harbor.$SERVICES_ROUTER_ADDRESS.nip.io; echo $HARBOR_HOSTNAME
```

To update the settings file with this hostname run:

```execute-1
sed -i "s/^hostname:.*/hostname: $HARBOR_HOSTNAME/" extensions/registry/harbor/harbor-data-values.yaml
```

For a production instance of Harbor you would want to double check whether any other settings need to be changed as well.

Once done with any changes create a secret from the settings file by running:

```execute-1
kubectl create secret generic harbor-data-values --from-file=values.yaml=extensions/registry/harbor/harbor-data-values.yaml -n tanzu-system-registry
```

This should output:

```
secret/harbor-data-values created
```

This secret is created in the namespace ``tanzu-system-registry`` created above for deployment of Harbor. The configuration needs to be loaded as a secret into Kubernetes so that the TMC extension manager can find it when Harbor is being deployed.

To perform the deployment of Harbor run:

```execute-1
kubectl apply -f extensions/registry/harbor/harbor-extension.yaml
```

This should output:

```
extension.clusters.tmc.cloud.vmware.com/harbor created
```

To view the state of the deployment using the TMC extension manager you can run:

```execute-1
kubectl get extension harbor -n tanzu-system-registry
```

This should output:

```
NAME     STATE   HEALTH   VERSION
harbor   3 
```

To monitor the state of the Harbor application as it is in turn deployed by the Kapp controller run:

```execute-1
kubectl get app harbor -n tanzu-system-registry -w
```

This will provide continuous updates as deployment proceeds. Wait until it shows a stable status of "Reconcile succeeded".

```
NAME     DESCRIPTION           SINCE-DEPLOY   AGE
harbor   Reconcile succeeded   2m             3m
```

You can then interrupt the monitor:

```terminal:interrupt
session: 1
```

The state of individual pods which make up the deployment of Harbor can be seen by running:

```execute-1
kubectl get pods -n tanzu-system-registry
```

The output should be similar to:

```
NAME                                    READY   STATUS    RESTARTS   AGE
harbor-clair-ff5b4dc8c-5wwbp            2/2     Running   0          5m
harbor-core-74894b9fd9-bsf2v            1/1     Running   0          5m
harbor-database-0                       1/1     Running   0          5m
harbor-jobservice-6f7bdbb8cb-5dwxp      1/1     Running   0          5m
harbor-notary-server-5745b94867-rw7zd   1/1     Running   0          5m
harbor-notary-signer-57c8fd7dcf-ps4nd   1/1     Running   0          5m
harbor-portal-d98ccbc79-b9r7h           1/1     Running   0          5m
harbor-redis-0                          1/1     Running   0          5m
harbor-registry-6ddc884ccd-wzmf7        2/2     Running   0          5m
harbor-trivy-0                          1/1     Running   0          5m
```

To verify that Harbor is deployed, use a separate browser window to visit the URL output by running:

```execute-1
echo https://$HARBOR_HOSTNAME/
```

With the present configuration self signed certificates are being used, so you will need to tell the browser to skip verification and allow you access.

To login to the Harbor instance, use the username "admin" and password "Harbor1234".

Because self signed certificates are being used, when the workload clusters that will use the Harbor instance are later created, they will need to be supplied with the cerificate authority (CA) used when creating the self signed certificates so the certificates can be verified. To extract the CA from the Harbor deployment for later use, run:

```execute-1
mkdir ~/work/harbor-tls && kubectl -n tanzu-system-registry get secret harbor-tls -o=jsonpath="{.data.ca\.crt}" | base64 -d > ~/work/harbor-tls/ca.crt
```
