To deploy an application in Kubernetes you need the set of resources which
defines the deployment. You would then use ``kubectl apply`` or ``kapp``
to apply them to the cluster.

For this workshop we are going to start out with the resources in the
``resources-v1`` sub directory.

```terminal:execute
command: tree resources-v1/
```

To apply these to the cluster we are going to use ``kapp`` rather than use
``kubectl apply`` as ``kapp`` provides various benefits in allowing us to
review changes and confirm we want to apply them.

To apply the resources to the cluster therefore run:

```terminal:execute
command: kapp deploy -a website -f resources-v1/
```

The ``kapp`` command will show you what resources will be created. Enter ``y``
to confirm.

```terminal:input
text: y
```

One of the great things about ``kapp`` is that it will track what applications
have been deployed. The ``-a website`` argument to ``kapp`` in this case says
we want to label the application as being called ``website``. You can later
list all the applications ``kapp`` knows about by running:

```terminal:execute
command: kapp list
```

This should now yield something like:

```
Target cluster 'https://10.96.0.1:443'

Apps in namespace '{{session_namespace}}'

Name     Namespaces                  Lcs   Lca  
website  {{session_namespace}}  true  5s  

Lcs: Last Change Successful
Lca: Last Change Age

1 apps

Succeeded
```

You can also use ``kapp`` to inspect the application afterwards as well.

```terminal:execute
command: kapp inspect -a website
```

Once deployed, just to verify that the application is started you can run:

```terminal:execute
command: curl http://website.{{session_namespace}}.svc.cluster.local
```

You may have to keep running ``curl`` until it works as it can take a few
moments for deployment to finish and the service hostname to be registered
within the internal cluster DNS.
