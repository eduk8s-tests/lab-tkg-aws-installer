Click on the **Deploy** button for the AWS EC2 option.

This should initially bring up the form for entering you credentials for the IaaS Provider, in this case those for AWS.

![](iaas-provider-form.png)

In this form enter your AWS credentials in the **ACCESS KEY ID** and **SECRET ACCESS_KEY** fields.

For the **SSH KEY NAME** field, enter the name of the SSH Key Pair registered in EC2 against the AWS region you want to deploy the TKG management cluster. In the **REGION** field select the AWS region.

If this is the first time you have used the TKG installer with this AWS account, you should enable the **Automate creation of AWS CloudFormation Stack** option. This CloudFormation stack provides the identity and access management (IAM) resources that TKG needs to create management clusters and Tanzu Kubernetes clusters in Amazon EC2. The IAM resources are added to the control plane and node roles when they are created during cluster deployment.

Click on **CONNECT** to verify that the details you supplied are correct.
