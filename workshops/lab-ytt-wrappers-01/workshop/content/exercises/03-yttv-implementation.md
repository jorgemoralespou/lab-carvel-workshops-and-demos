Lets look at the contents of our `yttv` shell script.

```editor:open-file
file: ~/bin/yttv
```

If you ignore the argument parsing it is pretty simple isn't it. All we have
done is execute `ytt`, allowing a subset of the `ytt` arguments to be passed
through, but also supplying it with the argument `--data-values-inspect`.

Usually when using `ytt` you are providing it with an existing set of YAML
files and these are passed through to the output, but with modifications as
per any parameterization or overlay changes.

In this case there is no existing YAML configuration and instead we are using
the debugging option `--data-values-inspect` to display the set of data values
given as input to `ytt` via the `-v` options.
