Before installing any of the extensions into a cluster it is necessary to install the TMC extension manager, Carvel Kapp controller and Kubernetes ``cert-manager``.

Since we are going to perform a number of steps against the ``tkg-services`` cluster where the Harbor registry is to be installed, we will first ensure it is set as the current context for any actions performed using ``kubectl`` or the Carvel tools.

To see what current contexts are registered, run:

```execute-1
kubectl config get-contexts
```

You should see output similar to the following:

```
CURRENT   NAME                                                            CLUSTER                       AUTHINFO                            NAMESPACE
*         tkg-mgmt-aws-20201119022317-admin@tkg-mgmt-aws-20201119022317   tkg-mgmt-aws-20201119022317   tkg-mgmt-aws-20201119022317-admin
```

At present only the management cluster should be listed.

To fetch the credentials for the ``tkg-services`` cluster and add it as a context that can be selected run:

```execute-1
tkg get credentials tkg-services
```

This should output:

```
Credentials of workload cluster 'tkg-services' have been saved 
You can now access the cluster by running 'kubectl config use-context tkg-services-admin@tkg-services'
```

Run again:

```execute-1
kubectl config get-contexts
```

This should generate output similar to:

```
CURRENT   NAME                                                            CLUSTER                       AUTHINFO                            NAMESPACE
*         tkg-mgmt-aws-20201119022317-admin@tkg-mgmt-aws-20201119022317   tkg-mgmt-aws-20201119022317   tkg-mgmt-aws-20201119022317-admin   
          tkg-services-admin@tkg-services                                 tkg-services                  tkg-services-admin  
```

The management cluster is still selected as the current context, so you must set the current context to the ``tkg-services`` cluster by running:

```execute-1
kubectl config use-context tkg-services-admin@tkg-services
```

This should confirm the switch by outputting:

```
Switched to context "tkg-services-admin@tkg-services".
```

You can also confirm it is the current context by running:

```execute-1
kubectl config current-context
```

Any operations run using ``kubectl`` or the Carvel tools should now act upon the ``tkg-services`` cluster.
