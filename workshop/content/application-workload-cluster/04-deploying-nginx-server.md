A sample set of resources for deploying nginx can be found in the directory ``~/nginx-sample``. We will need to customize these so that they use the container image we pushed into the Harbor registry, as well as set the hostname for the ingress to use a ``nip.io`` address which maps to the inbound ingress router for Contour.

To setup the changes run:

```execute-1
cat ~/nginx-sample/deployment.yaml.in| HARBOR_HOSTNAME=$HARBOR_HOSTNAME envsubst > ~/nginx-sample/deployment.yaml && \
cat ~/nginx-sample/ingress.yaml.in| CLUSTER_ROUTER_ADDRESS=$CLUSTER_ROUTER_ADDRESS envsubst > ~/nginx-sample/ingress.yaml
```

Now deploy the nginx server using these resources by running:

```execute-1
kubectl apply -f ~/nginx-sample -n default
```

Monitor the deployment of the server:

```execute-1
kubectl rollout status deployment/nginx -n default
```

Once the deploy was completed, test that the nginx server is responding by running:

```execute-1
curl nginx.$CLUSTER_ROUTER_ADDRESS.nip.io/
```

You should see the generic response page for an unconfigured nginx server.

This validates that pulling of container images from the Harbor registry in the shared services cluster is working, even though self signed cerificates is being used. It also shows that making a web application public using an ingress and Contour works.

Do note though that we didn't need to supply login credentials for the Harbor registry in the deployment resources as the image when pushed will default to being public. If you had reconfigured the Harbor registry to make container images private, you will need to ensure you supply the appropriate pull secret with any deployment resources.
