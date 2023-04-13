Once you have access to a Kubernetes cluster you can immediately start deploying
applications. The main tool a developer might use is the standard Kubernetes
client `kubectl`.

If you are using the Carvel tools, an alternative to `kubectl` is `kapp`, which
provides an application centric view of deploying and managing applications.

To be really productive with Kubernetes however, you need an easily consumable
repository of applications you can deploy which you know will work with your
Kubernetes cluster.

One option for packaged applications is `helm` and the [helm package
repository](https://helm.sh/). Another is the [Bitnami application
catalog](https://bitnami.com/).

When using the Carvel tools, the `kctrl` tool can be used to access any number
of package repositories where packages can be defined using the Carvel tools, or
where they can in turn make use of application packages defined using helm
templates. This tool therefore provides a single uniform way of dealing with
different packaging mechanisms for applications.

In this workshop you will learn how to use `kctrl`. This tool is underpinned by
the `kapp-controller` operator which is deployed to your Kubernetes cluster, and
which manages package installations on your behalf.

If you are using Tanzu Kubernetes Grid (TKG) or Tanzu Community Edition (TCE),
they come pre-installed with `kapp-controller`, however it can be deployed to
any Kubernetes cluster.

If you are using TKG or TCE, the `tanzu package` command provides similar
functionality to the `kctrl package` command used in this workshop, albeit that
the names of some command line options may differ.
