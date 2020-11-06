Guided installer for TKG on AWS
===============================

This is a guided installer for deploying a Tanzu Kubernetes Grid (TKG)
management cluster to Amazon Web Services (AWS). The installer also provides
some examples for creating additional workload clusters and managing them.

![](screenshot.png)

The installer is intended to be run on your local docker service using
``docker-compose``. You will then be provided with a web interface which
steps you through the installation.

The installer mounts the docker service socket from your local machine and
during an install will temporarily deploy a ``kind`` Kubernetes cluster to
your local docker service. For this to work, if you are using Docker Desktop
on macOS or Windows, your local docker service must be configured with at
least 6 GB of memory and that amount of memory should be available for use.
If running on Linux, your host needs to have that amount of memory available.

When running ``docker-compose`` there are two different configuration files
to choose from depending on the platform you are using. These are:

* ``docker-compose-bridge.yaml`` - Sets docker network mode to ``bridge``.
    Must be used if running the installer on macOS or Windows (WSL 2) with
    Docker Desktop. The port 10080 needs to be available on the host
    which docker runs.
* ``docker-compose-host.yaml`` - Sets docker network mode to ``host``.
    Must be used if running the installer on Linux. The ports 10080, 10082,
    11111 and 8080 must be available on the host docker runs.

Use the configuration file that applies to your platform in the commands
below.

If you are running docker on Windows (WSL 2), you must though also work out
the IP address used by docker under WSL 2. You then must edit the
``docker-compose-bridge.yaml`` configuration file and change the
``INGRESS_DOMAIN`` environment variable and replace ``127.0.0.1`` with the IP
address used by docker under WSL 2.

Next you need to build the installer by running:

```
docker-compose build -f docker-compose-bridge.yaml
```

To run the installer, then run:

```
docker-compose up -f docker-compose-bridge.yaml
```

If you are on macOS or Linux, the installer web interface can then be
accessed at the URL:

* http://workshop.127.0.0.1.nip.io:10080

If you are on Windows, instead of using ``127.0.0.1`` use the IP address
used by docker under WSL 2:

* http://workshop.A.B.C.D.nip.io:10080

To stop the installer, use ``ctrl-c`` or run:

```
docker-compose stop -f docker-compose-bridge.yaml
```

To clean up the stopped container when finished with the installer, run:

```
docker rm lab-tkg-aws-installer
```

The installer also creates four docker volumes. These are used for holding
the downloaded installer binaries, as well as the ``tkg`` and ``kubectl``
configuration. They exist such that if the container is stopped and you run
it again, you still have the configuration and ``tkg`` binary which allows
you to still talk to the management cluster.

To remove these volumes run:

```
docker volume rm lab-tkg-aws-installer_bin
docker volume rm lab-tkg-aws-installer_kube
docker volume rm lab-tkg-aws-installer_kube-tkg
docker volume rm lab-tkg-aws-installer_tkg
```

You should only delete these after you have deleted any workload and
management cluster, or copied the required configuration for ``tkg`` to
talk to the clusters.
