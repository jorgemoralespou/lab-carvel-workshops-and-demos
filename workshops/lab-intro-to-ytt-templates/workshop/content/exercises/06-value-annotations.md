We have seen how to process a set of templates using ``ytt`` and one way of
how we can provide data input values for our template. Now let's look at the
template files themselves and how the data values are inserted into the
resource definition.

Open up the ``templates-v1/deployment.yaml`` template file.

```editor:select-matching-text
file: ~/exercises/templates-v1/deployment.yaml
text: "name: (.*)"
isRegex: true
```

Focusing on the name property of the resource we find:

```
name: #@ data.values.website.name
```

The file format here is YAML, but against the ``name`` property we do not have
a value but instead have an annotation where the value should be, in the form
of a comment.

All ``ytt`` templates are valid YAML files but details about variable
sustitutions and everything else you can place in the template is handled
through embedding comments in the YAML file.

All comments which pertain to ``ytt`` template processing start with the
``#@`` prefix.

In this case the value annotation is providing an expression which will be
evaluated to derive what the value should be set to.

Very important to note in this case is that there is a space after the ``#@``
comment prefix. This is different to the structure annotation we saw
previously which was used to mark a YAML file as being a data values file.

The simple rule here is that a space must be used where what follows is
executable code. In this case the code was an expression generating the value
to use.
