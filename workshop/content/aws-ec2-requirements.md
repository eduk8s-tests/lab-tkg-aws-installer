In order to create Tanzu Kubernetes Grid clusters in AWS, you need to satisfy the following requirements:

* You must have the access key and access key secret for an active AWS account.
* The AWS account must have Administrator privileges.
* The AWS account must have sufficient resource quotas for creating Virtual Private Cloud (VPC) instances and Elastic IP (EIP) addresses.
* The AWS account must have an SSH key pair registered against the AWS region you intend to use.

For details on resource quota requirements for deploying TKG on AWS see:

* https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-mgmt-clusters-aws.html#aws-resources

For details on how to register an SSH key pair with AWS see:

* https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.2/vmware-tanzu-kubernetes-grid-12/GUID-mgmt-clusters-aws.html#register-ssh
* https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
