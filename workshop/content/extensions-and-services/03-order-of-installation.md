The TKG extensions which are supported are not totally independent of each other. A number of the extensions require that the Contour extension be installed into the cluster first. It is also required that before installing any extension that the Tanzu Mission Control (TMC) extension manager, Carvel Kapp controller and Kubernetes ``cert-manager`` be installed into the cluster.

If you intend setting up a shared Harbor registry there is also an additional requirement that it be deployed to a dedicated cluster before creating any workload clusters which would need to use it. This is because the management cluster needs to be configured with details of the Harbor registry with those details being injected into a workload cluster at the point the workload cluster is first created.

> NOTE: Details of the Harbor registry will subsequently be injected into an existing workload cluster which had been created prior to Harbor being deployed, when the existing workload cluster is upgraded. It is not known at this point whether this process of injecting details into an existing cluster can be triggered manually.

The order of the next set of installation steps, once you have the management cluster created, is as follows:

* Create a workload cluster for deployment of shared services. This will be where the Harbor registry is deployed and could also be used to host Grafana when monitoring services are added to clusters. For this guided installer, we will use the ``tkg-services`` workload cluster which was already created for this purpose.
* Install in the shared services cluster the TMC extension manager, Carvel Kapp controller and Kubernetes ``cert-manager``.
* Install in the shared services cluster the Contour ingress controller.
* Install in the shared services cluster the Harbor registry.

With the Harbor registry deployed, the management cluster then needs to be setup with details of the Harbor registry, and a service, which ensure that details of the Harbor registry are injected into any workload clusters which are subsequently created. These steps are:

* Identify with the management cluster the name of the cluster used for shared services.
* Install in the management cluster the connectivity API operator, configuring it with details of the Harbor registry deploy to the shared services cluster.
* Annotate in the shared services cluster the inbound HTTP route used by the Harbor registry.

Once these steps have been completed, then additional workload clusters can be created for deploying applications. Assuming that at least Contour will be added to each of these workload clusters, the steps required for each workload cluster is as follows:

* Create the workload cluster for deploying applications.
* Install in the shared services cluster the TMC extension manager, Carvel Kapp controller and Kubernetes ``cert-manager``.
* Install in the shared services cluster the Contour ingress controller.

If Contour is not being installed to a workload cluster, the TMC extension manager, Carvel Kapp controller and Kubernetes ``cert-manager`` must still be installed if deploying any other TKG extension.
