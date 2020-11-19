Tanzu Kubernetes Grid provides extensions that allow you to configure the Kubernetes clusters with the following services:

* Ingress control with Contour
* Log forwarding with Fluentbit
* Monitoring with Prometheus and Grafana
* User authentication with Dex and Gangway

Tanzu Kubernetes Grid also provides a Harbor registry, that you can deploy as a shared service for use by multiple Kubernetes clusters.

The resources required to install these extensions and shared services can be downloaded from my.vmware.com.

To download the extensions bundle, first list the available product binaries from the my.vmware.com site for TKG under the category ``vmware_tanzu_kubernetes_grid/1_x``:

```execute-1
vmw-cli ls vmware_tanzu_kubernetes_grid/1_x/PRODUCT_BINARY
```

This ensures we are working against the correct context before downloading any packages.

To download the package for the extensions bundle run:

```execute-1
vmw-cli cp tkg-extensions-manifests-v1.2.0-vmware.1.tar-2.gz
```

This should leave the package file ``tkg-extensions-manifests-v1.2.0-vmware.1.tar-2.gz`` in the current directory.

Extract the contents of the package file by running:

```execute-1
tar xvf tkg-extensions-manifests-v1.2.0-vmware.1.tar-2.gz
```

The directory ``tkg-extensions-v1.2.0+vmware.1`` should be created.

To see the list of subdirectories this contains for each extension and any common files, run:

```execute-1
tree -L 1 tkg-extensions-v1.2.0+vmware.1
```

You should see:

```
tkg-extensions-v1.2.0+vmware.1
├── authentication
├── bom
├── cert-manager
├── common
├── extensions
├── ingress
├── logging
├── monitoring
└── registry

9 directories, 0 files
```

These resources are designed to be used in conjunction with the Carvel tools ``kapp``, ``ytt``, ``imgpkg`` and ``kbld`` which you downloaded in an earlier step.
