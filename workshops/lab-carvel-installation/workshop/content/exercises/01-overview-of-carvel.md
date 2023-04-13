The Carvel package consists of a number of different tools, including:

* `ytt` - Template and overlay Kubernetes configuration via YAML structures, not
  text documents. No more counting spaces, or manual quoting.

* `kapp` - Install, upgrade, and delete multiple Kubernetes resources as one
  "application". Be confident your application is fully reconciled.

* `kbld` - Build or reference container images in Kubernetes configuration in an
  immutable way.

* `imgpkg` - Bundle and relocate application configuration (with images) via
  Docker registries. Be assured app contents are immutable.

* `vendir` - Declaratively state what files should be in a directory.

The philosophy upon which the tools is based is much like the UNIX philosophy.
That is, separate tools which each perform one set of tasks very well, but
which can be used together to perform larger tasks.

These tools would be installed in your local development environment, but can
also serve a role in production environments or even used inside of
containerized applications.

In addition to the command line tools, Carvel also provides a number of
Kubernetes operators, including:

* `kapp-controller` - A Package Manager that is compatible with Gitops ideas.
  Continuous delivery for Kubernetes Apps and Packages.

* `secretgen-controller` - Generate various types of Secrets in-cluster as well
  as export and import Secrets across namespaces.
