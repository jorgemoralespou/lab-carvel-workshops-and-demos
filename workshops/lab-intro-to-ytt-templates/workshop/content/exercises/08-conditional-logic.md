To give a better sense of how the Starlark language can be used, let's look at
adding some conditional logic to our templates by adding the ability to
optionally create an ingress for our application.

The template files for this example can be found in the ``templates-v2`` sub
directory.

```terminal:execute
command: tree templates-v2/
```

First open up the ``values.yaml`` file.

```editor:open-file
file: ~/exercises/templates-v2/values.yaml
```

This should contain:

```
#@data/values
---
website:
  name: website

  ingress:
    hostname: null
    domain: null
    class: null

    secret:
      certificate: null
      privateKey: null
```

We have added a new set of default values which can be overridden to provide a
hostname and domain for an ingress. We have also included the option of
supplying a certificate and private key to use for secure ingress.

Now check out the ``ingress.yaml`` file to see how these are used.

```editor:open-file
file: ~/exercises/templates-v2/ingress.yaml
```

This uses value annotations as before to provide a code expression which
when executed results in a value to set the properties in the YAML:

```editor:select-matching-text
file: ~/exercises/templates-v2/ingress.yaml
text: "name: (.*)"
isRegex: true
```

but because any expression can be provided and you aren't limited to just a
single data value reference, you can create composite values.

```editor:select-matching-text
file: ~/exercises/templates-v2/ingress.yaml
text: "host: (.*)"
isRegex: true
```

In addition to the value annotations we can include arbitrary code statements
as well. This has been used to conditionally include parts of the YAML for
the resource definition.

```editor:select-matching-text
file: ~/exercises/templates-v2/ingress.yaml
text: "#@ if .*"
isRegex: true
```

Not only can these be used to conditionally include just a part of a YAML
structure, the complete YAML structure can be excluded if the appropriate data
values are not set.

Although in this example the conditional checks enclose YAML definitions,
they can also be used to enclose other code statements as well.

In either case the only requirement is that the end of an enclosed block must
be marked with ``#@ end``.

```editor:select-matching-text
file: ~/exercises/templates-v2/ingress.yaml
text: "#@ if getattr"
after: 2
```

This is a departure from the normal Starlark language (and Python from which
it borrows its syntax) where indenting is used to denote the extent of blocks.
This needs to be done with ``if`` statements, ``while`` and ``for`` loops, as
well as a function ``def``.

Run ``ytt`` to process this new set of templates, setting the hostname and
domain name for the ingress.

```terminal:execute
command: ytt -f templates-v2 -v website.ingress.hostname={{session_namespace}}-website -v website.ingress.domain={{ingress_domain}}
```

Find the ingress and you will see that neither the ingress class or a secure
ingress were defined since we didn't provide data values which would trigger
inclusion of the parts of the resource definition for that.

Deploy the complete application now by running:

```terminal:execute
command: ytt -f templates-v2 -v website.ingress.hostname={{session_namespace}}-website -v website.ingress.domain={{ingress_domain}} | kapp deploy -a website -f - -y
```

List the ingress which was created so you can see the hostname was filled out correctly.

```terminal:execute
command: kubectl get ingresses
```

This time access the application via the ingress rather than directly against
the internal Kubernetes service.

```terminal:execute
command: curl http://{{session_namespace}}-website.{{ingress_domain}}/
```

Delete the deployed application once more.

```terminal:execute
command: kapp delete -a website -y
```
