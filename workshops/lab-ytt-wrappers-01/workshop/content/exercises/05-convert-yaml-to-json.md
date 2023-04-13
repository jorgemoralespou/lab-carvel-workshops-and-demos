When run, `ytt` will by default generate YAML, it can however be told to
generate JSON instead. The option for this is `-o json`, so as the `yttv`
script allows that as well, one could run:

```terminal:execute
command: yttv --data-value-yaml replicas=2 --data-value-yaml ports='[8080, 8443]' -o json
```

In some cases though we might have an existing YAML file which we want to
convert to JSON, or another tool might generate YAML as output and we need
to convert it in a pipeline. To handle these cases one can easily create a
`yaml2json` script using `ytt`.

If needing to convert YAML to JSON in a shell pipeline, we can then say:

```terminal:execute
command: yttv --data-value-yaml replicas=2 --data-value-yaml ports='[8080, 8443]' | yaml2json
```

or we can also use a file as input:

```terminal:execute
command: |-
  yttv --data-value-yaml replicas=2 --data-value-yaml ports='[8080, 8443]' > values.yaml
  yaml2json values.yaml
```

Because we can make use of `ytt`, the implementation of our `yaml2json` script
is also very simple.

```editor:open-file
file: ~/bin/yaml2json
```

Note that the use of the `--file-mark` option is necessary as `ytt` by default
will only treat a file as YAML if it uses an extension of `.yaml` or `.yml`.
This will ensure it will still work even if the file provided uses a different
extension.
