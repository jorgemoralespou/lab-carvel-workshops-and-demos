The `ytt` tool from [Carvel](https://carvel.dev/) is known as being useful for
helping to process YAML configuration, especially for Kubernetes. It provides
the ability to turn YAML configuration into templates, or it can be used to
patch existing YAML configuration using overlays to create the required
configuration.

Adhering to the UNIX philosophy of being a standalone tool which is independent
of how the YAML configuration is then consumed, it is possible to adapt `ytt`
for a range of uses. ...
