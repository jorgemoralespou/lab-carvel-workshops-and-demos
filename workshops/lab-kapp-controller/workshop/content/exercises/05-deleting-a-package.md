If you wish to delete an installed package you can use the `kctrl package
installed delete` command. You need to specify the local name for the installed
application. No version is required.

```terminal:execute
command: kctrl package installed delete --package-install cert-manager
```

You will be prompted to confirm the deletion. Enter `y` to accept.

```terminal:input
text: y
```

The output should be similar to:

```
Target cluster 'https://my-vcluster.{{session_namespace}}-vc.svc.cluster.local' (nodes: educates-control-plane)

Deleting package install 'cert-manager' from namespace 'default'

Waiting for deletion of package install 'cert-manager' from namespace 'default'

2:03:44AM: packageinstall/cert-manager (packaging.carvel.dev/v1alpha1) namespace: default: Deleting
2:03:53AM: packageinstall/cert-manager (packaging.carvel.dev/v1alpha1) namespace: default: DeletionSucceeded

Deleting 'ServiceAccount': cert-manager-default-sa

Deleting 'ClusterRole': cert-manager-default-cluster-role

Deleting 'ClusterRoleBinding': cert-manager-default-cluster-rolebinding

Succeeded
```

You can supply the `--yes` or `-y` option to skip the prompt asking for
confirmation.
