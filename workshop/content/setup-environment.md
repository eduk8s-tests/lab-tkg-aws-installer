The workshop environment will download a script when starting up. To verify that the script has been downloaded correctly run:

```execute-1
vmw-cli ls
```

This should output:

```
[GET] https://my.vmware.com/channel/public/api/v1.0/products/getProductsAtoZ
<category>
...
```

with a long list of VMware product categories available from the my.vmware.com website.

We will be using this script to download from the my.vmware.com website the ``tkg`` command line client which we will be using to create the TKG cluster.  

If you were wanting this own your own machine you could login to the my.vmware.com website and download the client directly to your own computer. Uploading the client from you own computer into the workshop environment is a bit harder, so we will use the ``vmw-cli`` script to download the client instead.

Before we do that, you will need to already have an account on the my.vmware.com website. If you don't have an account, create one.

Now enter your my.vmware.com credentials here in the workshop environment so they are available to the ``vmw-cli`` script. To enter your credentials run the following and enter them when prompted.

```execute-1
read -p "Enter your my.vmware.com username: " VMWUSER && export VMWUSER && \
read -s -p "Enter your my.vmware.com password: " VMWPASS && export VMWPASS
```

The credentials will be saved in the ``VMWUSER`` and ``VMWPASS`` environment variables.

Next list the available product binaries from the my.vmware.com site for TKG.

```execute-1
vmw-cli ls vmware_tanzu_kubernetes_grid/1_x/PRODUCT_BINARY
```

This should yield a list of product binaries similar to:

```
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

Extract the contents of the package file run:

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

Move these into the users ``bin`` directory and make them executable by running:

```execute-1
mkdir $HOME/bin && \
mv tkg/tkg-* $HOME/bin/tkg && \
mv tkg/kapp-* $HOME/bin/kapp && \
mv tkg/ytt-* $HOME/bin/ytt && \
mv tkg/imgpkg-* $HOME/bin/imgpkg && \
mv tkg/kbld-* $HOME/bin/kbld && \
chmod +x $HOME/bin/*
```

Verify that the ``tkg`` command is found and runs by running:

```execute
tkg help
```

The help documentation for ``tkg`` should be output.

If all is good, we are ready to start.
