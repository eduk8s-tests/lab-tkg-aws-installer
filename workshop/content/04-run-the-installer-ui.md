The management cluster can be setup entirely from the command line using ``tkg``, or you can use a browser based web interface. We will use the browser based web interface.

In this guided installer environment, click below to open a new dashboard tab which launchers the installer.

```dashboard:create-dashboard
name: Launcher
url: terminal:tkg-installer
```

If you were launching the installer on your own local computer, you would run ``tkg init --ui``.

Now click below to open a dashboard tab on the installer web interface.

```dashboard:create-dashboard
name: Installer
url: {{ingress_protocol}}://{{session_namespace}}-installer.{{ingress_domain}}{{ingress_port_suffix}}/
```

You should be presented with:

![](images/tkg-installer-ui.png)

The browser based web interface provides three choices as to where the management cluster can be installed. These are:

* VMware vSphere
* AWS EC2
* Microsoft Azure

For this guided installer we will be using the AWS EC2 option.
