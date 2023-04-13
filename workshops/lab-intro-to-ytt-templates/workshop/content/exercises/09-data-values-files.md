In order to override the default data values for a template we set each
explicitly on the command line when running ``ytt``. There is a lot more to
specifying what data values a ``ytt`` template can accept, including being
able to define a schema declaring the types of the values, e.g., string,
integers etc.

A separate workshop will cover data values and schema files in more depth, but
we will look at one more basic use case here before we end this workshop.

We already saw in our last example how the ``values.yaml`` file declared
the default values.

```editor:open-file
file: ~/exercises/templates-v2/values.yaml
```

In addition to overriding specific values on the command line, we can create
a separate data values files with any data value overrides.

Create a file ``override-values.yaml`` in the current directory.

```editor:append-lines-to-file
file: ~/exercises/override-values.yaml
text: |-
  website:
    ingress:
      hostname: {{session_namespace}}-website
      domain: {{ingress_domain}}
```

You can see that this YAML file mirrors the structure of the data values file
containing the defaults, but only overrides just the values we want to.

Ensure that the override data values file has been saved and run ``ytt``
so the data values are read from it using:

```terminal:execute
command: ytt -f templates-v2 --data-values-file override-values.yaml | kapp deploy -a website -f - -y
```

The ``--data-values-file`` option indicates it has the override data values.
The data values declared in it will be applied on top of the default data
values read from the ``templates-v2`` directory specified by the ``-f``
option.

Note that it wasn't necessary to include a YAML structure annotation of the
form ``#@data/values`` as that is implied from the fact that the
``--data-values-file`` option was used.

List the ingress again to verify it is correct:

```terminal:execute
command: kubectl get ingresses
```

and test the application:

```terminal:execute
command: curl http://{{session_namespace}}-website.{{ingress_domain}}/
```

When done delete the application.

```terminal:execute
command: kapp delete -a website -y
```
