To install one of the available packages you can use the `kctrl package
install` command.

When installing a package you must provide both the package name, the specific
version you want to install, and a local name for the installed application.

To install version `1.5.4` of the `cert-manager` package you will need to run:

```terminal:execute
command: kctrl package install --package-install cert-manager --package cert-manager.community.tanzu.vmware.com --version 1.5.4 --dangerous-allow-use-of-shared-namespace
```

Note that we have cheated a bit here. Best practice would be to create a new
namespace to hold package repository metadata and details of packages to
be installed. In this case we have used the `default` namespace, which `kctrl`
will by default block. In order to override `kctrl` we supply the special
option `--dangerous-allow-use-of-shared-namespace`. What we should have done
is create a separate namespace and use the `-n` option to designate use of
that namespace.

When complete the output should be similar to:

```
Target cluster 'https://my-vcluster.{{session_namespace}}-vc.svc.cluster.local' (nodes: educates-control-plane)

Creating service account 'cert-manager-default-sa'

Creating cluster admin role 'cert-manager-default-cluster-role'

Creating cluster role binding 'cert-manager-default-cluster-rolebinding'

Creating package install resource

Waiting for PackageInstall reconciliation for 'cert-manager'

1:25:17AM: packageinstall/cert-manager (packaging.carvel.dev/v1alpha1) namespace: default: Reconciling
1:25:50AM: packageinstall/cert-manager (packaging.carvel.dev/v1alpha1) namespace: default: ReconcileSucceeded

Succeeded
```

To view a list of what packages have been installed you can run:

```terminal:execute
command: kctrl package installed list
```

which since we only have the one package installed should display:

```
Target cluster 'https://my-vcluster.{{session_namespace}}-vc.svc.cluster.local' (nodes: educates-control-plane)

Installed packages in namespace 'default'

Name          Package Name                             Package Version  Status  
cert-manager  cert-manager.community.tanzu.vmware.com  1.5.4            Reconcile succeeded  

Succeeded
```
