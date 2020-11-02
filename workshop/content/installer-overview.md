This is a guided installer for deploying a Tanzu Kubernetes Grid (TKG) management cluster to Amazon Web Services (AWS).

The installer also provides some examples for creating additional workload clusters and managing them.

As you progress through these instructions you will be shown commands which you need to run in the terminals provided by the installer environment. To execute the command you do not need to enter them into the terminal yourself, instead click on the command in the instructions and it will be run for you.

As part of the steps to deploy the management cluster to AWS, a local Kubernetes management cluster will first be deployed to your local docker service.

To check that your local docker service is contactable from within the installer environment, run:

```execute-1
docker info
```

Installation of the local Kubernetes management cluster to the local docker service will require 6GB of memory.
