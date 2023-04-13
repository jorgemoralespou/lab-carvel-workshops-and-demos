Creating a YAML file can obviously be done with any editor, but sometimes you
need to be able to create a YAML file programmatically on the fly, from a shell
script, or even manually on the command line.

One method of doing this within a shell script is to use inline configuration
specified in the shell script with it saved to a file. For example:

```
#!/bin/bash

cat >> config.yaml << EOF
name: example
workshop: $WORKSHOP_NAME
EOF
```

In this solution the YAML configuration can use fixed values, reference
environment variables, or local shell variables.

With the `yttv` utility script which we will look at we can instead do this
using:

```terminal:execute
command: yttv -v name=example -v workshop=$WORKSHOP_NAME
```
