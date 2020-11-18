VMware products, including the installer for TKG, can be downloaded from the [my.vmware.com](https://my.vmware.com/) website. The installer environment includes a tool called ``vmw-cli`` which can be used to download application packages from the my.vmware.com website from the command line.

If you needed to download any VMware products on your own machine you could login to the my.vmware.com website using a browser and download the client directly to your own computer. Uploading any packages from your own computer into the installer environment is a bit harder, so we will be using the ``vmw-cli`` script to download any packages instead.

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

So that they are available to ``vmw-cli``, enter your my.vmware.com credentials here in the installer environment. To enter your credentials run the following and enter them when prompted.

```execute-1
read -p "Enter your my.vmware.com username: " VMWUSER && export VMWUSER && \
read -s -p "Enter your my.vmware.com password: " VMWPASS && export VMWPASS && \
echo
```

Once entered, the credentials will be saved in the ``VMWUSER`` and ``VMWPASS`` environment variables and ``vmw-cli`` will use them for any authenticated requests.
