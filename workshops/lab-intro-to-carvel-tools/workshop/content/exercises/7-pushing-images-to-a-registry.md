The previous section showed how to use `kbld` to build the container image. It failed to deploy in the end as the Kubernetes cluster being used didn't have access to images held by the docker daemon where the build was being run.

In order to have it work for the Kubernetes cluster used by this workshop environment, we will need to push the image to an image registry the cluster can access.

The configuration we will use this time is `config-step-4-build-and-push/push.yml`. To view the file run:

```execute
cat config-step-4-build-and-push/push.yml
```

The output should be:

```
#@ load("@ytt:data", "data")
#@ load("@ytt:assert", "assert")

#@ if/end data.values.push_images:
---
apiVersion: kbld.k14s.io/v1alpha1
kind: ImageDestinations
destinations:
- image: quay.io/eduk8s-labs/sample-app-go
  #@ if not data.values.push_images_repo or len(data.values.push_images_repo) == 0:
  #@   assert.fail("Expected push_images_repo to be non-empty. Example: quay.io/eduk8s-labs/sample-app-go")
  #@ end
  newImage: #@ data.values.push_images_repo
```

The configuration specifies that `quay.io/eduk8s-labs/sample-app-go` should be pushed to an image repository with name as specified by `push_images_repo` data value.

Our local docker client is already authenticated to the registry we will be pushing to, but otherwise you would need to make sure that it can push to it.

Also, to prepare for the deployment, we need to create an image pull secret to use with the deployment, so that Kubernetes can pull images from the private repo we are using:

```execute
kubectl create secret generic registry-credentials --from-file=.dockerconfigjson=$HOME/.docker/config.json --type=kubernetes.io/dockerconfigjson
```

Run the combined command to process the template, build the image and deploy it, setting the value for `push_images_repo` in the process.

```execute-1
ytt template -f config-step-4-build-and-push/ -v hello_msg="carvel user" -v push_images=true -v push_images_repo={{ registry_host }}/carvel/sample-app-go | kbld -f- | kapp deploy -a simple-app -f- --diff-changes --yes
```

The key parts of the output which are of interest are:

```
...
quay.io/eduk8s-labs/sample-app-go | Successfully built a83b7f09eabc
quay.io/eduk8s-labs/sample-app-go | Successfully tagged kbld:rand-1652080550013293681-16623913717789-quay-io-eduk8s-labs-sample-app-go
quay.io/eduk8s-labs/sample-app-go | Untagged: kbld:rand-1652080550013293681-16623913717789-quay-io-eduk8s-labs-sample-app-go
quay.io/eduk8s-labs/sample-app-go | finished build (using Docker)
registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go | starting push (using Docker): kbld:quay-io-eduk8s-labs-sample-app-go-sha256-a83b7f09eabc8ecdaf488dc31d0b27f3eaeb59469e98aa816ca4562f86664aff -> registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go:kbld-rand-1652080550185993441-1533310120349
registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go | The push refers to repository [registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go]
registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go | 9107cef8ffb7: Preparing
registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go | 9107cef8ffb7: Pushed
registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go | kbld-rand-1652080550185993441-1533310120349: digest: sha256:10edd53bd78204aee47d6dd053b28bf11bc56fe4e4b7f4e356ee9d24527d1ad7 size: 528
registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go | finished push (using Docker)
resolve | final: quay.io/eduk8s-labs/sample-app-go -> registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go@sha256:10edd53bd78204aee47d6dd053b28bf11bc56fe4e4b7f4e356ee9d24527d1ad7

07:15:52AM: info: Resources: Falling back to checking each namespace separately (much slower)
@@ update deployment/simple-app (apps/v1) namespace: {{session_namespace}} @@
  ...
 12, 12               sha: 338d4d9e5299952a0bdb10d72b873ebbde0a1410
 13     -         url: kbld:quay-io-eduk8s-labs-sample-app-go-sha256-a83b7f09eabc8ecdaf488dc31d0b27f3eaeb59469e98aa816ca4562f86664aff
     13 +         url: registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go@sha256:10edd53bd78204aee47d6dd053b28bf11bc56fe4e4b7f4e356ee9d24527d1ad7
 14, 14     creationTimestamp: "2022-05-09T06:55:02Z"
 15, 15     generation: 10
  ...
130,130             value: carvel user
131     -         image: kbld:quay-io-eduk8s-labs-sample-app-go-sha256-a83b7f09eabc8ecdaf488dc31d0b27f3eaeb59469e98aa816ca4562f86664aff
    131 +         image: registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go@sha256:10edd53bd78204aee47d6dd053b28bf11bc56fe4e4b7f4e356ee9d24527d1ad7
132,132           name: simple-app
    133 +       imagePullSecrets:
    134 +       - name: registry-credentials
133,135   status:
134,136     availableReplicas: 1

Changes

Namespace                         Name        Kind        Age  Op      Op st.  Wait to    Rs       Ri  
{{session_namespace}}  simple-app  Deployment  20m  update  -       reconcile  ongoing  Waiting for 1 unavailable replicas  

Op:      0 create, 0 delete, 1 update, 0 noop, 0 exists
Wait to: 1 reconcile, 0 delete, 0 noop

7:15:52AM: ---- applying 1 changes [0/1 done] ----
...
```

This time the build and deployment should be successful.

If we inspect again the application we see the new image being referenced:

```execute-1
kapp inspect -a simple-app --raw --filter-kind Deployment --tty=false | kbld inspect -f-
```

The output should be similar to:

```
Images

Image     registry-{{session_namespace}}.{{ingress_domain}}/carvel/sample-app-go@sha256:10edd53bd78204aee47d6dd053b28bf11bc56fe4e4b7f4e356ee9d24527d1ad7  
Metadata  - local:  
              path: /home/eduk8s/exercises/sample-app-go  
          - git:  
              dirty: false  
              remoteURL: https://github.com/eduk8s-labs/sample-app-go  
              sha: 338d4d9e5299952a0bdb10d72b873ebbde0a1410  
Resource  deployment/simple-app (apps/v1) namespace: {{session_namespace}}  

1 images

Succeeded
```

You will note how the image name has been rewritten to reference the image from the image registry it was pushed to, rather than the original location for the image. Also you will see that the image digest reference (e.g. {{ registry_host }}/carvel/sample-app-go@sha256:4c8b96...) was used instead of a tagged reference (e.g. kbld:docker-io...).

Digest references are preferred to other image reference forms as they are immutable, hence provide a guarantee that the exact version of built software will be deployed.
