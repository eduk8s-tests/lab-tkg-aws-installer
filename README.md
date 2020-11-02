Guided installer for TKG on AWS
===============================

This is a guided installer for deploying a Tanzu Kubernetes Grid (TKG)
management cluster to Amazon Web Services (AWS).

The installer also provides some examples for creating additional workload
clusters and managing them.

The installer is intended to be run on your local docker service using
``docker-compose``. You will then be provided with a web interface which
steps you through the installation.

The installer mounts the docker service socket from your local machine and
during an install will temporarily deploy a ``kind`` Kubernetes cluster to
your local docker service. For this to work, if you are using Docker Desktop
on macoOS or Windows, your local docker service must be configured with at
least 6 GB of memory and that amount of memory should be available for use.

To build the installer, first run:

```
docker-compose build
```

To run the installer, then run:

```
docker-compose up --renew-anon-volumes
```

The installer can then be accessed at the URL:

* http://workshop.127.0.0.1.nip.io:10080

To stop the installer, use ``ctrl-c`` or run ``docker-compose stop``.
