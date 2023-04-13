Once a package repository has been added, you can list the available packages
by running:

```terminal:execute
command: kctrl package available list
```

For the TCE package repository you should see output similar to:

```
Target cluster 'https://my-vcluster.{{session_namespace}}-vc.svc.cluster.local' (nodes: educates-control-plane)

Available summarized packages in namespace 'default'

Name                                           Display name  
cert-manager.community.tanzu.vmware.com        cert-manager  
contour.community.tanzu.vmware.com             contour  
external-dns.community.tanzu.vmware.com        external-dns  
fluent-bit.community.tanzu.vmware.com          fluent-bit  
gatekeeper.community.tanzu.vmware.com          gatekeeper  
grafana.community.tanzu.vmware.com             grafana  
harbor.community.tanzu.vmware.com              harbor  
knative-serving.community.tanzu.vmware.com     knative-serving  
local-path-storage.community.tanzu.vmware.com  local-path-storage  
multus-cni.community.tanzu.vmware.com          multus-cni  
prometheus.community.tanzu.vmware.com          prometheus  
velero.community.tanzu.vmware.com              velero  
whereabouts.community.tanzu.vmware.com         whereabouts  

Succeeded
```

The exact packages shown may be different as we added the latest stable version
of the package repository and it may have been updated since this workshop was
created.

To see more details about a specific package you can inspect it by running
the command `kctrl package available get` with the name of the package as
argument.

```terminal:execute
command: kctrl package available get --package cert-manager.community.tanzu.vmware.com
```

The output should be similar to:

```
Target cluster 'https://my-vcluster.{{session_namespace}}-vc.svc.cluster.local' (nodes: educates-control-plane)

Name                 cert-manager.community.tanzu.vmware.com  
Display name         cert-manager  
Categories           - certificate management  
Short description    Certificate management  
Long description     Provides certificate management provisioning within the cluster  
Provider             VMware  
Maintainers          - name: Nicholas Seemiller  
Support description  Go to https://cert-manager.io/ for documentation or the #cert-manager channel on  
                     Kubernetes slack  

Version  Released at  
1.3.3    2021-08-06 12:31:21 +0000 UTC  
1.4.4    2021-08-23 16:47:51 +0000 UTC  
1.5.4    2021-08-23 17:22:51 +0000 UTC  
1.6.1    2021-10-29 12:00:00 +0000 UTC  

Succeeded
```

This will include a list of the available versions of the package.

To view just the list of versions you can also run:

```terminal:execute
command: kctrl package available list --package cert-manager.community.tanzu.vmware.com
```

which should yield out similar to:

```
Target cluster 'https://my-vcluster.{{session_namespace}}-vc.svc.cluster.local' (nodes: educates-control-plane)

Available packages in namespace 'default'

Name                                     Version  Released at  
cert-manager.community.tanzu.vmware.com  1.3.3    2021-08-06 12:31:21 +0000 UTC  
cert-manager.community.tanzu.vmware.com  1.4.4    2021-08-23 16:47:51 +0000 UTC  
cert-manager.community.tanzu.vmware.com  1.5.4    2021-08-23 17:22:51 +0000 UTC  
cert-manager.community.tanzu.vmware.com  1.6.1    2021-10-29 12:00:00 +0000 UTC  
```
