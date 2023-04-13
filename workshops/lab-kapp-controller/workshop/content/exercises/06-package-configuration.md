When installing a package it may accept configuration for overriding how it is
installed. In this case a YAML values file can be supplied when installing the
package.

If the package provides a schema for the accepted values, they can be queried
using the `kctrl package available get` command with the `--values-schema`
option:

```terminal:execute
command: kctrl package available get --package cert-manager.community.tanzu.vmware.com/1.5.4 --values-schema
```

The version is included as part of the package name rather than using a separate
option when using this command.

In the case of the `cert-manager` package the only configuration it accepts
is the name of the Kubernetes namespace it should be installed into.

```
Target cluster 'https://my-vcluster.{{session_namespace}}-vc.svc.cluster.local' (nodes: educates-control-plane)

Values schema for 'cert-manager.community.tanzu.vmware.com/1.5.4'

Key        Default       Type    Description  
namespace  cert-manager  string  The namespace in which to deploy cert-manager.  

Succeeded
```

To create a YAML configuration file which is suitable run:

```terminal:execute
command: |-
    cat > cert-manager-values.yaml << EOF
    namespace: cert-manager
    EOF
```

To install the package and supply the YAML configuration file you need to pass
the `--values-file` option to the `kctrl package install` command along with the
name of the file.

```terminal:execute
command: kctrl package install --package-install cert-manager --package cert-manager.community.tanzu.vmware.com --version 1.5.4 --values-file cert-manager-values.yaml --dangerous-allow-use-of-shared-namespace
```

A copy of the values file will be saved away as a secret in the namespace
`kapp-controller` uses to track the package installation.

You can therefore query what values were used to install a package using the
command:

```terminal:execute
command: kctrl package installed get --package-install cert-manager --values
```

If you want to write the raw values for a file, you can use the option
``--values-file-output`` instead, passing it the name of the file.
