The expression which was supplied with the value annotation uses an embedded
variant of the Starlark programming language. Starlark is a dialect of Python
intended for use as a configuration language.

To illustrate how Starlark comes into play, let's separate the Starlark code
from the YAML file.

```editor:open-file
file: ~/exercises/starlark-v1/example.star
```

The first line in this file is a function call to load the ``data`` module
which provides us access to the calculated set of input data values for the
template.

```editor:select-matching-text
file: ~/exercises/starlark-v1/example.star
text: "load(.*)"
isRegex: true
```

We didn't highlight this previously in the YAML file, but it was there at
the start of the file. As with all code when being included in the YAML
file, it was within a comment with the prefix ``#@`` but with that ever
important space after the prefix marking it as executable code.

If you are familiar with the Python programming language, you could view this
as being equivalent to a Python ``import`` statement.

Next up we have the reference to the input data value as used on the value
annotation.

```editor:select-matching-text
file: ~/exercises/starlark-v1/example.star
text: "print(.*)"
isRegex: true
```

Note that since a value annotation must be an expression, we have used
``print()`` here so we could see the value. Normally when a value annotation
is used in the YAML file the value resulting from evaluating the expression is
used to set the value in the YAML.

Process this with ``ytt`` by running:

```terminal:execute
command: ytt -f starlark-v1/
```

and the result should be:

```
website
```

We still had a default value because the directory still contained a data
values file.

```editor:open-file
file: ~/exercises/starlark-v1/values.yaml
```

As with when we were applying ``ytt`` to the resource templates, we can
still override the data values for this example when running ``ytt``.

```terminal:execute
command: ytt -f starlark-v1/ -v website.name=website-1
```

As can be seen, the template feature of ``ytt`` is therefore a YAML file
interspersed with Starlark code.

The Starlark code can appear in two contexts within the YAML file.

The first is a Starlark expression in a value annotation where the result of
evaluating the expression is assigned to an object property, or as an item in
a list.

The second are Starlark statements. These can be included at global scope
in the YAML file, or even interspersed within the YAML definition as we will
see in our next example.

Note that although we used a ``print()`` statement in the example here of some
standalone Starlark code, you would normally never use ``print()`` when using
Starlark in a set of ``ytt`` templates. The only time you might is as a
temporary debugging aid when working out why your templates aren't producing
the desired result.
