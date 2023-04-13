Before we start looking at using Starlark as a query language for structured
data, let's first look briefly at `jq` and `yq` to get an understanding of
what these tools can do.

In this directory we have a number of YAML files.

```terminal:execute
command: tree -P '*.yaml'  .
```

To view the contents of `single-resource.yaml` run:

```terminal:execute
command: cat single-resource.yaml
```

For the purposes of these exercises this contains a single Kubernetes resource
definition.

To view the contents of `multiple-resources.yaml` run:

```terminal:execute
command: cat multiple-resources.yaml
```

For the purposes of these exercises this contains multiple Kubernetes resource
definitions.

The purpose of `jq` and `yq` is to be able to consume a structured set of input
objects or documents and perform queries upon them, with the result being some
calculation based on, or a mutation of the input.

For example, to use `yq` to extract the name of the Kubernetes resource you can
run:

```terminal:execute
command: yq ".metadata.name" single-resource.yaml
```

In the case of there being multiple resources, the result for each resource
would be returned as separate document.

```terminal:execute
command: yq ".metadata.name" multiple-resources.yaml
```
