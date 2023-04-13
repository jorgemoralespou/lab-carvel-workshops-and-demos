In this workshop we are going to look at a small utility script you can create
which wraps `ytt` to perform a more specific task. This utility script is:

* `yttq` - Used to create a generalized query engine for YAML/JSON configuration
  using Starlark as the programmatic query language.

Other tools already exist for this purpose, such as `jq` and `yq`, but it is
interesting exercise to see how these can be implemented using `ytt` and a small
shell script.
