The `ytt` tool from [Carvel](https://carvel.dev/) is known as being useful for
helping to process YAML configuration, especially for Kubernetes. It provides
the ability to turn YAML configuration into templates, or it can be used to
patch existing YAML configuration using overlays to create the required
configuration.

Adhering to the UNIX philosophy of being a standalone tool which is independent
of how the YAML configuration is then consumed, it is possible to adapt `ytt`
for a range of uses. In this workshop we will explore how `ytt` can be used as a
generalized query engine for YAML/JSON configuration in similar ways to tools
such as `yq` and `jq`.
