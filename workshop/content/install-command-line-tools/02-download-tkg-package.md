To deploy a TKG cluster and manage it, you need to download the ``tkg`` command line tool.

To do this, first list the available product binaries from the my.vmware.com site for TKG under the category ``vmware_tanzu_kubernetes_grid/1_x``:

```execute-1
vmw-cli ls vmware_tanzu_kubernetes_grid/1_x/PRODUCT_BINARY
```

This should yield a list of product binaries similar to:

```
<fileName>                                         <fileType>  <version>  <releaseDate>  <fileSize>  <canDownload>
tkg-darwin-amd64-v1.2.0-vmware.1.tar.gz            gz          1.2.0      2020-10-15     74.76 MB    true         
tkg-linux-amd64-v1.2.0-vmware.1.tar.gz             gz          1.2.0      2020-10-15     74 MB       true         
tkg-windows-amd64-v1.2.0-vmware.1.tar.gz           gz          1.2.0      2020-10-15     73.49 MB    true         
photon-3-kube-v1.19.1-vmware.2.ova                 ova         1.19.1     2020-10-15     1.04 GB     true         
photon-3-kube-v1.18.8-vmware.1.ova                 ova         1.18.8     2020-10-15     1.05 GB     true         
photon-3-kube-v1.17.11-vmware.1.ova                ova         1.17.11    2020-10-15     1.04 GB     true         
kubectl-mac-v1.19.1-vmware.2.gz                    gz          1.19.1     2020-10-15     22.51 MB    true         
kubectl-linux-v1.19.1-vmware.2.gz                  gz          1.19.1     2020-10-15     22.69 MB    true         
kubectl-windows-v1.19.1-vmware.2.exe.gz            gz          1.19.1     2020-10-15     22.95 MB    true         
tkg-extensions-manifests-v1.2.0-vmware.1.tar-2.gz  gz          1.2.0      2020-10-15     241.7 KB    true         
tkg-connectivity-manifests-v1.2.0-vmware.2.tar     tar         1.2.0      2020-10-15     20 KB       true         
crashd-darwin-v0.3.1-vmware.4.gz                   gz          0.3.1      2020-10-15     9.39 MB     true         
crashd-linux-v0.3.1-vmware.4.gz                    gz          0.3.1      2020-10-15     8.93 MB     true
```

The full list of available versions and when they were updated may differ.

To download the package containing the ``tkg`` command line tool run:

```execute-1
vmw-cli cp tkg-linux-amd64-v1.2.0-vmware.1.tar.gz
```

This should leave the package file ``tkg-linux-amd64-v1.2.0-vmware.1.tar.gz`` in the current directory.

Extract the contents of the package file by running:

```execute-1
tar xvf tkg-linux-amd64-v1.2.0-vmware.1.tar.gz
```

The following directory and files should be extracted.

```
tkg/
tkg/tkg-linux-amd64-v1.2.0+vmware.1
tkg/kapp-linux-amd64-v0.33.0+vmware.1
tkg/ytt-linux-amd64-v0.30.0+vmware.1
tkg/imgpkg-linux-amd64-v0.2.0+vmware.1
tkg/kbld-linux-amd64-v0.24.0+vmware.1
```

Move the ``tkg`` program into the ``bin`` directory and make it executable by running:

```execute-1
mkdir -p $HOME/bin && \
mv tkg/tkg-* $HOME/bin/tkg && \
chmod +x $HOME/bin/*
```

Verify that the ``tkg`` command can be found by running:

```execute
tkg version
```
