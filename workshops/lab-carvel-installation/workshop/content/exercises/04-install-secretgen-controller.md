When installing applications into a Kubernetes cluster one of the problems
that can arise is how to manage image pull secrets when container images are
stored in private image registries. This arises no matter the tooling used,
be it `kubectl`, `kapp` or `kapp-controller`.

To assist in part with the task of making image pull secrets available in
Kubernetes namespaces where required, Carvel provides the `secretgen-controller`
operator. The operator provides a number of other capabilities as well,
including:

* Supports generating certificates, passwords, RSA keys and SSH keys.
* Supports exporting and importing secrets across namespaces.
* Exporting/importing image registry pull secrets across namespaces

In this respect `secretgen-controller` complements `kapp-controller` further
aiding in making the task of deploying applications to Kubernetes easier.

Details for how to install `secretgen-controller`, if your Kubernetes cluster
does not already provide it out of the box, can be found in the
`secretgen-controller`
[documentation](https://github.com/vmware-tanzu/carvel-secretgen-controller/blob/develop/docs/install.md).
In order to install `secretgen-controller` you will need cluster admin access to
the Kubernetes cluster.

To install the latest version of `secretgen-controller` you can run:

```terminal:execute
command: kapp deploy -a sg -f https://github.com/vmware-tanzu/carvel-secretgen-controller/releases/latest/download/release.yml -y
```

This time we have provided the option `-y` when running `kapp` so that the
application will be deployed without prompting whether to continue.

When the deployment is complete, you can verify the set of installed
applications by again running:

```terminal:execute
command: kapp list
```

As with `kapp-controller`, how to use `secretgen-controller` will be covered
by a separate workshop.
