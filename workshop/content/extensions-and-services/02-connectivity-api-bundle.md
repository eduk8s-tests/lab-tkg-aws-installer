When installing a Harbor registry for workload clusters to use, an additional resource bundle is required. This is the connectivity API bundle and will be used to setup the management cluster such than when additional workload clusters are created those workload clusters are automatically configured to be able to access the Harbor registry.

To download the connectivity API bundle, first list the available product binaries from the my.vmware.com site for TKG under the category ``vmware_tanzu_kubernetes_grid/1_x``:

```execute-1
vmw-cli ls vmware_tanzu_kubernetes_grid/1_x/PRODUCT_BINARY
```

This ensures we are working against the correct context before downloading any packages.

To download the package for the connectivity API bundle run:

```execute-1
vmw-cli cp tkg-connectivity-manifests-v1.2.0-vmware.2.tar
```

This should leave the package file ``tkg-connectivity-manifests-v1.2.0-vmware.2.tar`` in the current directory.

Extract the contents of the package file by running:

```execute-1
tar xvf tkg-connectivity-manifests-v1.2.0-vmware.2.tar
```

The directory ``manifests`` should be created.

To see the list of subdirectories this contains run:

```execute-1
tree -L 1 manifests
```

You should see:

```
manifests
├── tanzu-registry
└── tkg-connectivity-operator

2 directories, 0 files
```
