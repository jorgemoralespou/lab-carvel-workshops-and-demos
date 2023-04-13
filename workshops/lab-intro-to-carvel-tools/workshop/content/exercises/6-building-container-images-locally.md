Kubernetes embraced the use of container images to package source code and its dependencies. Container images can be created using tools such as `docker`, `pack` if using Buildpacks, or the Maven `spring-boot:build-image` command if developing Spring Boot applications.

To rebuild a container image when changing application source would typically involve manually running a build using one of these tools, and then pushing the resulting image to an image registry accessible to the Kubernetes cluster so it can be deployed. Any deployment resource would then need to be modified to use the specific version for the new image.

The [kbld](https://get-kbld.io/) tool from Carvel is a small tool that provides a simple way to insert container image building into a deployment workflow. `kbld` looks for images within application configuration (currently it looks for image keys), checks if there is an associated source code definition, and if so triggers a build of the container image using `docker` (or other defined build mechanism), then finally captures the image digests for any built images, and updates configuration with new image references.

As we are going to build our image locally, we first need to pull down the source code:

```execute
git clone https://github.com/eduk8s-labs/sample-app-go
```

This has created a new folder called `sample-app-go` where you can find the source code for the application.

The configuration file `config-step-3-build-local/build.yml` is a new configuration, which specifies that the image `quay.io/eduk8s-labs/sample-app-go` should be built from source code in the `sample-app-go` sub directory when `kbld` runs. To view the configuration file run:

```execute
cat config-step-3-build-local/build.yml
```

You should see:

```
apiVersion: kbld.k14s.io/v1alpha1
kind: Sources
sources:
- image: quay.io/eduk8s-labs/sample-app-go
  path: sample-app-go
```

Now insert `kbld` between `ytt` and `kapp` so that images used in our configuration are built, if necessary, before they are deployed by `kapp`.

```execute-1
ytt template -f config-step-3-build-local/ -v hello_msg="carvel user" | kbld -f- | kapp deploy -a simple-app -f- --diff-changes --yes
```

The output should be similar to the following. Note that you will see that the deployment is failing, this okay, keep reading.

```
quay.io/eduk8s-labs/sample-app-go | starting build (using Docker): sample-app-go -> kbld:rand-1652080255282173836-7080160218101-quay-io-eduk8s-labs-sample-app-go
quay.io/eduk8s-labs/sample-app-go | Sending build context to Docker daemon  78.85kB
quay.io/eduk8s-labs/sample-app-go | Step 1/9 : FROM golang:1.12 as builder
quay.io/eduk8s-labs/sample-app-go | 1.12: Pulling from library/golang
quay.io/eduk8s-labs/sample-app-go | ...
quay.io/eduk8s-labs/sample-app-go | 06036b0307c9: Pull complete
quay.io/eduk8s-labs/sample-app-go | Digest: sha256:d0e79a9c39cdb3d71cc45fec929d1308d50420b79201467ec602b1b80cc314a8
quay.io/eduk8s-labs/sample-app-go | Status: Downloaded newer image for golang:1.12
quay.io/eduk8s-labs/sample-app-go |  ---> ffcaee6f7d8b
quay.io/eduk8s-labs/sample-app-go | Step 2/9 : WORKDIR /src
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go |  ---> Running in 9d2cd9902cef
quay.io/eduk8s-labs/sample-app-go | Removing intermediate container 9d2cd9902cef
quay.io/eduk8s-labs/sample-app-go |  ---> 2009a6d58653
quay.io/eduk8s-labs/sample-app-go | Step 3/9 : COPY . .
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go |  ---> df2e60e7f536
quay.io/eduk8s-labs/sample-app-go | Step 4/9 : RUN CGO_ENABLED=0 GOOS=linux go build -v -o app
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go |  ---> Running in ed51dd1b261b
quay.io/eduk8s-labs/sample-app-go | net
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go | net/textproto
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go | internal/x/net/http/httpproxy
quay.io/eduk8s-labs/sample-app-go | crypto/x509
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go | internal/x/net/http/httpguts
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go | crypto/tls
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go | net/http/httptrace
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go | net/http
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go | _/src
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go | Removing intermediate container ed51dd1b261b
quay.io/eduk8s-labs/sample-app-go |  ---> 37c78a76faf9
quay.io/eduk8s-labs/sample-app-go | Step 5/9 : FROM scratch as runtime
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go |  ---> 
quay.io/eduk8s-labs/sample-app-go | Step 6/9 : COPY --from=builder /src/app .
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go |  ---> 6358c51d72ce
quay.io/eduk8s-labs/sample-app-go | Step 7/9 : EXPOSE 8080
quay.io/eduk8s-labs/sample-app-go | 
quay.io/eduk8s-labs/sample-app-go |  ---> Running in 6eef49e67ccd
quay.io/eduk8s-labs/sample-app-go | Removing intermediate container 6eef49e67ccd
quay.io/eduk8s-labs/sample-app-go |  ---> f16b84c38fb2
quay.io/eduk8s-labs/sample-app-go | Step 8/9 : USER 1000
quay.io/eduk8s-labs/sample-app-go |  ---> Running in 76dfb85e7490
quay.io/eduk8s-labs/sample-app-go | Removing intermediate container 76dfb85e7490
quay.io/eduk8s-labs/sample-app-go |  ---> 356cc714584a
quay.io/eduk8s-labs/sample-app-go | Step 9/9 : ENTRYPOINT ["/app"]
quay.io/eduk8s-labs/sample-app-go |  ---> Running in 2f3a630b952e
quay.io/eduk8s-labs/sample-app-go | Removing intermediate container 2f3a630b952e
quay.io/eduk8s-labs/sample-app-go |  ---> a83b7f09eabc
quay.io/eduk8s-labs/sample-app-go | Successfully built a83b7f09eabc
quay.io/eduk8s-labs/sample-app-go | Successfully tagged kbld:rand-1652080255282173836-7080160218101-quay-io-eduk8s-labs-sample-app-go
quay.io/eduk8s-labs/sample-app-go | Untagged: kbld:rand-1652080255282173836-7080160218101-quay-io-eduk8s-labs-sample-app-go
quay.io/eduk8s-labs/sample-app-go | finished build (using Docker)
resolve | final: quay.io/eduk8s-labs/sample-app-go -> kbld:quay-io-eduk8s-labs-sample-app-go-sha256-a83b7f09eabc8ecdaf488dc31d0b27f3eaeb59469e98aa816ca4562f86664aff

07:11:35AM: info: Resources: Falling back to checking each namespace separately (much slower)
@@ update deployment/simple-app (apps/v1) namespace: {{session_namespace}} @@
  ...
  4,  4       deployment.kubernetes.io/revision: "3"
      5 +     kbld.k14s.io/images: |
      6 +       - origins:
      7 +         - local:
      8 +             path: /home/eduk8s/exercises/sample-app-go
      9 +         - git:
     10 +             dirty: false
     11 +             remoteURL: https://github.com/eduk8s-labs/sample-app-go
     12 +             sha: 338d4d9e5299952a0bdb10d72b873ebbde0a1410
     13 +         url: kbld:quay-io-eduk8s-labs-sample-app-go-sha256-a83b7f09eabc8ecdaf488dc31d0b27f3eaeb59469e98aa816ca4562f86664aff
  5, 14     creationTimestamp: "2022-05-09T06:55:02Z"
  6, 15     generation: 8
  ...
104,113   spec:
105     -   replicas: 2
106,114     selector:
107,115       matchLabels:
  ...
120,128             value: carvel user
121     -         image: quay.io/eduk8s-labs/sample-app-go@sha256:5021a23e0c4a4633bfd6c95b13898cffb88a0e67f109d87ec01b4f896f4b4296
    129 +         image: kbld:quay-io-eduk8s-labs-sample-app-go-sha256-a83b7f09eabc8ecdaf488dc31d0b27f3eaeb59469e98aa816ca4562f86664aff
122,130           name: simple-app
123,131   status:

Changes

Namespace                         Name        Kind        Age  Op      Op st.  Wait to    Rs  Ri  
{{session_namespace}}  simple-app  Deployment  16m  update  -       reconcile  ok  -  

Op:      0 create, 0 delete, 1 update, 0 noop, 0 exists
Wait to: 1 reconcile, 0 delete, 0 noop

7:11:35AM: ---- applying 1 changes [0/1 done] ----
7:11:35AM: update deployment/simple-app (apps/v1) namespace: {{session_namespace}}
7:11:35AM: ---- waiting on 1 changes [0/1 done] ----
7:11:35AM: ongoing: reconcile deployment/simple-app (apps/v1) namespace: {{session_namespace}}
7:11:35AM:  ^ Waiting for generation 10 to be observed
7:11:35AM:  L ok: waiting on replicaset/simple-app-9d9bddc89 (apps/v1) namespace: {{session_namespace}}
7:11:35AM:  L ok: waiting on replicaset/simple-app-7676674444 (apps/v1) namespace: {{session_namespace}}
7:11:35AM:  L ok: waiting on replicaset/simple-app-7466d7df75 (apps/v1) namespace: {{session_namespace}}
7:11:35AM:  L ok: waiting on replicaset/simple-app-5469bd48bf (apps/v1) namespace: {{session_namespace}}
7:11:35AM:  L ongoing: waiting on pod/simple-app-7676674444-mch7c (v1) namespace: {{session_namespace}}
7:11:35AM:     ^ Pending
7:11:35AM:  L ok: waiting on pod/simple-app-5469bd48bf-8hrkm (v1) namespace: {{session_namespace}}
7:11:35AM:  L ongoing: waiting on pod/simple-app-5469bd48bf-6hbm2 (v1) namespace: {{session_namespace}}
7:11:35AM:     ^ Deleting
7:11:36AM: ongoing: reconcile deployment/simple-app (apps/v1) namespace: {{session_namespace}}
7:11:36AM:  ^ Waiting for 1 unavailable replicas
7:11:36AM:  L ok: waiting on replicaset/simple-app-9d9bddc89 (apps/v1) namespace: {{session_namespace}}
7:11:36AM:  L ok: waiting on replicaset/simple-app-7676674444 (apps/v1) namespace: {{session_namespace}}
7:11:36AM:  L ok: waiting on replicaset/simple-app-7466d7df75 (apps/v1) namespace: {{session_namespace}}
7:11:36AM:  L ok: waiting on replicaset/simple-app-5469bd48bf (apps/v1) namespace: {{session_namespace}}
7:11:36AM:  L ongoing: waiting on pod/simple-app-7676674444-mch7c (v1) namespace: {{session_namespace}}
7:11:36AM:     ^ Pending: ContainerCreating
7:11:36AM:  L ok: waiting on pod/simple-app-5469bd48bf-8hrkm (v1) namespace: {{session_namespace}}
7:11:38AM: ongoing: reconcile deployment/simple-app (apps/v1) namespace: {{session_namespace}}
7:11:38AM:  ^ Waiting for 1 unavailable replicas
7:11:38AM:  L ok: waiting on replicaset/simple-app-9d9bddc89 (apps/v1) namespace: {{session_namespace}}
7:11:38AM:  L ok: waiting on replicaset/simple-app-7676674444 (apps/v1) namespace: {{session_namespace}}
7:11:38AM:  L ok: waiting on replicaset/simple-app-7466d7df75 (apps/v1) namespace: {{session_namespace}}
7:11:38AM:  L ok: waiting on replicaset/simple-app-5469bd48bf (apps/v1) namespace: {{session_namespace}}
7:11:38AM:  L ongoing: waiting on pod/simple-app-7676674444-mch7c (v1) namespace: {{session_namespace}}
7:11:38AM:     ^ Pending: ErrImagePull (message: rpc error: code = Unknown desc = failed to pull and unpack image "docker.io/library/kbld:quay-io-eduk8s-labs-sample-app-go-sha256-a83b7f09eabc8ecdaf488dc31d0b27f3eaeb59469e98aa816ca4562f86664aff": failed to resolve reference "docker.io/library/kbld:quay-io-eduk8s-labs-sample-app-go-sha256-a83b7f09eabc8ecdaf488dc31d0b27f3eaeb59469e98aa816ca4562f86664aff": pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed)
7:11:38AM:  L ok: waiting on pod/simple-app-5469bd48bf-8hrkm (v1) namespace: {{session_namespace}}
...
```

As already mentioned the deployment is failing. This is because we haven't configured `kbld` to push the image to an image registry where Kubernetes can pull it from. We will show the required steps to push the image to an image registry in the next section. For now, stop the attempted deployment by interrupting `kapp`.

```terminal:interrupt
```

What you can see from the above output though, is how `kbld` triggered a build of the container image using `docker` based on the requirement for the image in the configuration received from `ytt`. Further, `kbld` modified the image reference to include the new image digest before passing the configuration onto `kapp` for deployment.

It's also worth noting that `kbld` not only builds images and updates references but also annotates Kubernetes resources with image metadata it collects and makes it quickly accessible for debugging. This may not be that useful during development but comes in handy when investigating environment (staging, production, etc.) state.

```execute-1
kapp inspect -a simple-app --raw --filter-kind Deployment --tty=false | kbld inspect -f-
```

The output from this will be similar to:

```
Images

Image     kbld:quay-io-eduk8s-labs-sample-app-go-sha256-a83b7f09eabc8ecdaf488dc31d0b27f3eaeb59469e98aa816ca4562f86664aff  
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
