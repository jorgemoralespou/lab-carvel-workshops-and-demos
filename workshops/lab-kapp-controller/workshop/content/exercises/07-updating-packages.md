When installing a package you must supply the version you want installed.

If at a later time a newer version becomes available, because the contents of
any package repositories will periodically be refreshed, the new version will
become available for installation, but a prior version of the package will not
be upgraded automatically.

The versions of `cert-manager` which were available could be viewed by
running:

```terminal:execute
command: kctrl package available list --package cert-manager.community.tanzu.vmware.com
```

We installed version 1.5.4, however a newer version 1.6.1 was also available.

To upgrade the installed version of the package to 1.6.1 you can run the
`kctrl package installed update` command.

```terminal:execute
command: kctrl package installed update --package-install cert-manager --version 1.6.1 --dangerous-allow-use-of-shared-namespace
```

The output should be similar to:

```
Target cluster 'https://my-vcluster.{{session_namespace}}-vc.svc.cluster.local' (nodes: educates-control-plane)

Getting package install for 'cert-manager'

Updating package install for 'cert-manager'

Waiting for PackageInstall reconciliation for 'cert-manager'

2:28:08AM: packageinstall/cert-manager (packaging.carvel.dev/v1alpha1) namespace: default: Reconciling
2:29:01AM: packageinstall/cert-manager (packaging.carvel.dev/v1alpha1) namespace: default: ReconcileSucceeded

Succeeded
```

If a configuration values file had been supplied when the package was installed
the cached version of the values file will also be used when installing the
newer version.

If the newer version required additional configuration, you will need to supply
the `--values-file` option with the new version of the configuration values when
the update is being done.

Were you needing to update the configuration for an already installed version of
the package, but you didn't want to change the version which was installed, you
can still use the `kctrl package installed update` command, but you would not
need to supply the version.

```terminal:execute
command: kctrl package installed update --package-install cert-manager --values-file cert-manager-values.yaml --dangerous-allow-use-of-shared-namespace
```
