At this point you could deploy an application using a container image hosted on a public image registry such as Docker Hub. Since we have the local Harbor registry which has been deployed to the shared services cluster, lets use that instead.

Note that in this guided installer the Harbor registry is using a self signed certificate. This means that if you were going to build images on your local machine using docker and push images to it, you will need to configure your local docker service or operating system with the CA so that the image registry is trusted. To avoid you needing to do that, we will use ``skopeo`` to copy an image from a public registry into the Harbor registry.

```execute-1
cat ~/.docker/config.json.in | HARBOR_HOSTNAME=$HARBOR_HOSTNAME envsubst > ~/.docker/config.json
```

```execute-1
skopeo copy docker://docker.io/library/nginx:latest docker://$HARBOR_HOSTNAME/library/hello:latest --dest-cert-dir $HOME/work/harbor-tls
```
