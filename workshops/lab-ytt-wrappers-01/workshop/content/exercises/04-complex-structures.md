The set of `ytt` options which are being passed through are:

* `-v`, `--data-value stringArray` - Set specific data value to given value, as string (format: all.key1.subkey=123).

* `--data-value-file stringArray` - Set specific data value to given file contents, as string (format: all.key1.subkey=/file/path).

* `--data-value-yaml stringArray` - Set specific data value to given value, parsed as YAML (format: all.key1.subkey=true).

* `--data-values-env stringArray` - Extract data values (as strings) from prefixed env vars (format: PREFIX for PREFIX_all__key1=str).

* `--data-values-env-yaml stringArray` - Extract data values (parsed as YAML) from prefixed env vars (format: PREFIX for PREFIX_all__key1=true).

* `--data-values-file stringArray` - Set multiple data values via a YAML file (format: /file/path.yml).

The range of options, and that they can all be specified more than once,
provides various means for creating more complex YAML structures, exactly as can
be done if using `ytt` for more traditional uses. This can included nest YAML
structures:

```terminal:execute
command: yttv -v credentials.username=john -v credentials.password=secret
```

or non string values, including lists defined using YAML (JSON).

```terminal:execute
command: yttv --data-value-yaml replicas=2 --data-value-yaml ports='[8080, 8443]'
```
