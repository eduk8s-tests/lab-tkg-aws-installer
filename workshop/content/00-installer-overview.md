This is a guided installer for deploying Tanzu Kubernetes Grid (TKG) to Amazon Web Services (AWS). It will step you through deploying a TKG management cluster, a shared services cluster hosting the Harbor registry, and a workload cluster for developing and/or deploying your applications.

The guide is for first time users to introduce you to the steps required to set up Tanzu Kubernetes Grid on AWS. The installer follows one specific path to get everything working. For an actual development/production cluster you will likely want to make customizations as to how everything is setup, so you should also refer to the Tanzu Kubernetes Grid documentation.

As you progress through these instructions you will be shown commands which you need to run in the terminals provided by the installer environment. To execute the command you do not need to enter them into the terminal yourself, instead click on the command in the instructions and it will be run for you.

In order to deploy a management cluster to AWS, a temporary management cluster will first be deployed to your local docker service. This local management cluster will then be used to bootstrap the management cluster in AWS.

To check that your local docker service is contactable from within the installer environment, run:

```execute-1
docker info
```

Installation of the temporary management cluster to the local docker service will require 6GB of memory.

Note that these instructions will result in Kubernetes clusters being deployed to your AWS account. If you do not go through all steps and perform the deletion of the clusters before destroying this installer environment, or otherwise transfer configuration and credentials for working with the management cluster to a separate environment, you will need to manually cleanup anything left in your AWS account.
