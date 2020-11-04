This is a guided installer for deploying a Tanzu Kubernetes Grid (TKG) management cluster to Amazon Web Services (AWS). It will step you through deploying a TKG management cluster suitable for testing or development, and then create a workload cluster to which you can deploy applications.

As you progress through these instructions you will be shown commands which you need to run in the terminals provided by the installer environment. To execute the command you do not need to enter them into the terminal yourself, instead click on the command in the instructions and it will be run for you.

In order to deploy the management cluster to AWS, a temporary management cluster will first be deployed to your local docker service. This local management cluster will then be used to bootstrap the management cluster in AWS.

To check that your local docker service is contactable from within the installer environment, run:

```execute-1
docker info
```

Installation of the temporary management cluster to the local docker service will require 6GB of memory.

Note that these instructions will result in Kubernetes clusters being deployed to your AWS account. If you do not go through all steps and perform the deletion of the clusters before destroying this installer environment, you will need to manually cleanup anything left in your AWS account.
