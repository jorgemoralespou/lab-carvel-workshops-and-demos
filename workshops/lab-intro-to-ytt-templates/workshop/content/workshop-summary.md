This is the end of the workshop. Hopefully you have learnt a bit more about
what the Carvel tool set can be used for, and specifically how ``ytt``
templates can be used to ease application deployments.

We also used ``kapp`` to help us deploy applications to the Kubernetes
cluster. It wasn't required that we use ``kapp`` and output from ``ytt`` can
be applied direct to the cluster using ``kubectl apply``, however ``kapp``
provides various useful features including tracking of what applications are
deployed and what resources were used to create the deployment. Other useful
features provided by ``kapp`` are the ability to see what changes are going to
be made before actually applying them the cluster, and deletion of all
resources for an application without needing to have access to the original
resources used to create the deployment.

For more information check out the [Carvel](https://carvel.dev/) web site.

Also check out the other workshops on using the Carvel tools.
