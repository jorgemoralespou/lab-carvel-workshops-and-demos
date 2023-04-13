In addition to templating, `ytt` offers another way to customize application configuration.

Instead of relying on the provider of an application using templating to expose a set of configuration knobs, configuration consumers can use the [ytt overlay](https://github.com/k14s/ytt/blob/master/docs/lang-ref-ytt-overlay.md) feature to apply arbitrary patches to existing YAML configuration resources.

For example, our simple application configuration templates do not provide a way to parameterize the value of `spec.replicas`, which controls how may instances (pods) of the application should be run.

Instead of asking an author of an application to expose yet another data value input for a template, we can create an overlay file that changes `spec.replicas` to a new value.

An example configuration for `ytt` which does this can be found in the `config-step-2a-overlays/custom-scale.yml` file.

To view the full file run:

```execute
cat config-step-2a-overlays/custom-scale.yml
```

The key part of the overlay file is:

```
#@overlay/match by=overlay.subset({"kind": "Deployment"})
---
spec:
  #@overlay/match missing_ok=True
  replicas: 2
```

This says that for any `Deployment` resource, patch `spec.replicas` so the resulting value is `2`. This will be added even if `spec.replicas` was not present in the first place.

To update the application deployment using this configuration run:

```execute
ytt template -f config-step-2-template/ -f config-step-2a-overlays/custom-scale.yml -v hello_msg="carvel user" | kapp deploy -a simple-app -f- --diff-changes --yes
```

The output should be similar to:

```
@@ update deployment/simple-app (apps/v1) namespace: {{session_namespace}} @@
  ...
104,104   spec:
    105 +   replicas: 2
105,106     selector:
106,107       matchLabels:

Changes

Namespace                         Name        Kind        Age  Op      Op st.  Wait to    Rs  Ri  
{{session_namespace}}  simple-app  Deployment  13m  update  -       reconcile  ok  -  

Op:      0 create, 0 delete, 1 update, 0 noop, 0 exists
Wait to: 1 reconcile, 0 delete, 0 noop

7:08:34AM: ---- applying 1 changes [0/1 done] ----
7:08:35AM: update deployment/simple-app (apps/v1) namespace: {{session_namespace}}
7:08:35AM: ---- waiting on 1 changes [0/1 done] ----
7:08:35AM: ongoing: reconcile deployment/simple-app (apps/v1) namespace: {{session_namespace}}
7:08:35AM:  ^ Waiting for generation 8 to be observed
7:08:35AM:  L ok: waiting on replicaset/simple-app-9d9bddc89 (apps/v1) namespace: {{session_namespace}}
7:08:35AM:  L ok: waiting on replicaset/simple-app-7466d7df75 (apps/v1) namespace: {{session_namespace}}
7:08:35AM:  L ok: waiting on replicaset/simple-app-5469bd48bf (apps/v1) namespace: {{session_namespace}}
7:08:35AM:  L ok: waiting on pod/simple-app-5469bd48bf-8hrkm (v1) namespace: {{session_namespace}}
7:08:35AM:  L ongoing: waiting on pod/simple-app-5469bd48bf-6hbm2 (v1) namespace: {{session_namespace}}
7:08:35AM:     ^ Pending: ContainerCreating
7:08:36AM: ok: reconcile deployment/simple-app (apps/v1) namespace: {{session_namespace}}
7:08:36AM: ---- applying complete [1/1 done] ----
7:08:36AM: ---- waiting complete [1/1 done] ----

Succeeded
```

To verify that we now have 2 instances of our application, run:

```execute-2
kubectl get pods
```
