In this workshop we will be using a couple of different tools from the Carvel
tool set and not just ``ytt``. We will also be deploying some actual
applications to a Kubernetes cluster.

To verify that the cluster is up and running okay run:

```terminal:execute
command: kubectl get pods
```

Did you type the command in yourself? If you did, click on the highlighted
action block instead and you will find that it is executed for you. You can
click on any action block which has an icon, such as <span class="fas
fa-running"></span>, shown to the right of it and the appropriate action will
be taken.

The output from this command should be:

```
No resources found in {{session_namespace}} namespace.
```

It doesn't matter that no resources were found as we haven't deployed anything
as yet.

Now run:

```terminal:execute
command: kapp list
```

The ``kapp`` tool is the other tool from Carvel we will be using and helps
with deploying and tracking applications which have been deployed.

The output from ``kapp`` at this point should be something like:

```
Target cluster 'https://10.96.0.1:443'

Apps in namespace '{{session_namespace}}'

Name  Namespaces  Lcs  Lca  

Lcs: Last Change Successful
Lca: Last Change Age

0 apps

Succeeded
```

Again, because we haven't deployed anything yet, the list of applications
will be empty.
