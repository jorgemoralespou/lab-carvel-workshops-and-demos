Finally, if we had a JSON file and needed to convert that to YAML, we can
make use of the fact that JSON is also valid YAML. In other words we can pass
it through `ytt` to convert it into a more traditional YAML structure rather
than JSON.

We can again do this as part of a pipeline:

```terminal:execute
command: yttv --data-value-yaml replicas=2 --data-value-yaml ports='[8080, 8443]' | yaml2json | json2yaml
```

or using a file as input:

```terminal:execute
command: |-
  yttv --data-value-yaml replicas=2 --data-value-yaml ports='[8080, 8443]' | yaml2json > values.json
  json2yaml values.json
```

The implementation of our `json2yaml` script is once again quite simple:

```editor:open-file
file: ~/bin/json2yaml
```

Note that with all these scripts we could just as easily have used shell
functions. Using separate shell scripts is preferable though as it means you
aren't restricted to using them in just an interactive shell and they can be
used by other scripts.
