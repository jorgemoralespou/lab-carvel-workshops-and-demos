Before you can install any application packages using `kctrl` and
`kapp-controller` from a package repository, the package repository needs to be
registered with `kapp-controller`.

Because registering a package repository and syncing across details about
available packages can take a little while the first time, in this workshop
environment we have already kicked that process off to save some time.

The command which has already been run for you is:

```
kctrl package repository add tce-repo --url projects.registry.vmware.com/tce/main:stable
```

To verify the package repository has been registered correctly you can run:

```terminal:execute
command: kctrl package repository list
```

It should output:

```
Target cluster 'https://my-vcluster.{{session_namespace}}-vc.svc.cluster.local' (nodes: educates-control-plane)

Repositories in namespace 'default'

Name      Source                                                 Status  
tce-repo  (imgpkg) projects.registry.vmware.com/tce/main:stable  Reconcile succeeded  

Succeeded
```

where the status shows `Reconcile succeeded`.

If the status shows as `Reconciling`, keep running this command until it shows
as having reconciled successfully.

In this case the package repository that has been added for you is the TCE
package repository. You are not however restricted to a single package
repository and you can add any number of publicly available repositories, or
internal organization package repositories for your own packages.
