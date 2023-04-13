The `kapp` tool provided with Carvel can be used as a replacement for deploying
applications using `kubectl`. The difference with `kapp` is that it treats the
set of resources being deployed as an application unit. When deploying an
application it will ensure that all the resources have been created and that
workloads created have started successfully before marking the deployment as
successful.

The `kapp` tool can also reconcile what is deployed against the original or a
modified set of resources and update the deployed resources to match. When all
done, it is possible to use `kapp` to delete the application even when you do
not have access to the original set of resources used to deploy it.

The `kapp-controller` operator provided with Carvel wraps up `kapp`, as well as
makes use of the `imgpkg`, `ytt` and `kbld` tools from Carvel for packaging
application resources as OCI image artefacts that can be easily redistributed
and deployed. It therefore serves as a basis for packaging, deploying and
managing Kubernetes applications.

Overall, `kapp-controller` along with the other Carvel tools can in part be
compared to a tool such as Helm, but overall Carvel can do much more and
provides a much richer feature set to base a complete lifecycle for managing
applications run in Kubernetes.

Details for how to install `kapp-controller`, if your Kubernetes cluster does
not already provide it out of the box, can be found in the `kapp-controller`
[documentation](https://carvel.dev/kapp-controller/docs/v0.34.0/install/). In
order to install `kapp-controller` you will need cluster admin access to the
Kubernetes cluster.

To install the latest version of `kapp-controller` you can run:

```terminal:execute
command: kapp deploy -a kc -f https://github.com/vmware-tanzu/carvel-kapp-controller/releases/latest/download/release.yml
```

We have used `kapp` here, but you could also use `kubectl`.

In the case of using `kapp`, it will by default prompt you with what will be
changed by the deployment and ask you to confirm the action. Enter `"y"` to
continue.

```terminal:input
text: y
```

The `kapp` tool will log progress as the resources are deployed and the
application checked to ensure it is running.

When `kapp` has been used to install `kapp-controller` you can validate it
is installed by list the installed applications.

```terminal:execute
command: kapp list
```

This should generate output similar to:

```
Target cluster 'https://my-vcluster.{{session_namespace}}-vc.svc.cluster.local' (nodes: educates-control-plane)

Apps in namespace 'default'

Name  Namespaces                             Lcs   Lca  
kc    (cluster),kapp-controller,kube-system  true  1m  

Lcs: Last Change Successful
Lca: Last Change Age

1 apps

Succeeded
```

You can review at any time what resources are deployed for `kapp-controller`
and their current reconcilation state by running:

```terminal:execute
command: kapp inspect -a kc
```

The name given to the `kapp-controller` application in this case was `kc`.

In this workshop we will not go through how to use `kapp-controller`, as that
being dealt with in a separate workshop.
