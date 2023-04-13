To verify that `kapp-controller` is installed into your Kubernetes cluster you
may need to ask your cluster administrator. In the case of our workshop we can
verify it is installed and running by using the command:

```terminal:execute
command: kapp list -A
```

You should see output similar to:

```
Target cluster 'https://my-vcluster.{{session_namespace}}-vc.svc.cluster.local' (nodes: educates-control-plane)

Apps in all namespaces

Namespace  Name                  Namespaces                             Lcs   Lca  
default    kapp-controller.app   (cluster),kapp-controller,kube-system  true  1m  

Lcs: Last Change Successful
Lca: Last Change Age

1 apps

Succeeded
```

with the list of applications including that for `kapp-controller.app`.

If curious to see what resources are installed as part of `kapp-controller`
you can run:

```terminal:execute
command: kapp inspect -a kapp-controller.app
```
