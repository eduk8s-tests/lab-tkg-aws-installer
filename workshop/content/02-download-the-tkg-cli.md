The first step you need to perform is download the ``tkg`` command line tool.

The installer environment includes a tool called ``vmw-cli``. This tool can be used to download application packages from the my.vmware.com website.

To obtain a listing of all VMware product categories from the my.vmware.com website using ``vmw-cli`` run:

```execute-1
vmw-cli ls
```

This should generate a listing starting with:

```
[GET] https://my.vmware.com/channel/public/api/v1.0/products/getProductsAtoZ
<category>
...
```

Before you can use ``vmw-cli`` to download any application packages, you will need to already have an account on the my.vmware.com website. If you don't have an account, create one.

> Note: If you needed the ``tkg`` command line tool on your own machine you could login to the my.vmware.com website using a browser and download the client directly to your own computer. Uploading the client from your own computer into the installer environment is a bit harder, so we will use the ``vmw-cli`` script to download the client instead.

So that they are available to ``vmw-cli``, enter your my.vmware.com credentials here in the installer environment. To enter your credentials run the following and enter them when prompted.

```execute-1
read -p "Enter your my.vmware.com username: " VMWUSER && export VMWUSER && \
read -s -p "Enter your my.vmware.com password: " VMWPASS && export VMWPASS && \
echo
```

Once entered, the credentials will be saved in the ``VMWUSER`` and ``VMWPASS`` environment variables.

Next list the available product binaries from the my.vmware.com site for TKG.

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

Move these into the ``bin`` directory and make them executable by running:

```execute-1
mkdir -p $HOME/bin && \
mv tkg/tkg-* $HOME/bin/tkg && \
mv tkg/kapp-* $HOME/bin/kapp && \
mv tkg/ytt-* $HOME/bin/ytt && \
mv tkg/imgpkg-* $HOME/bin/imgpkg && \
mv tkg/kbld-* $HOME/bin/kbld && \
chmod +x $HOME/bin/*
```

Verify that the ``tkg`` command can be found by running:

```execute
tkg version
```
