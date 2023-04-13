For the next part of this workshop we are going to use the template enabled
resource files in the ``templates-v1`` sub directory.

```terminal:execute
command: tree templates-v1/
```

Before we look at them, let's first show how the files are processed using
``ytt``. To do this run:

```terminal:execute
command: ytt -f templates-v1/
```

These resources are exactly the same as the original resources we used. You
can verify this by running:

```terminal:execute
command: |-
  ytt -f templates-v1/ > /tmp/resources.yaml && \
    kapp deploy -a website -f /tmp/resources.yaml --diff-changes
```

Note that we are using the ``--diff-changes`` option. This is another useful
feature of ``kapp`` which can tell us before updating resources in the cluster
what changes are actually going to be made.

The output should be:

```
Target cluster 'https://10.96.0.1:443'

Changes

Namespace  Name  Kind  Conds.  Age  Op  Op st.  Wait to  Rs  Ri  

Op:      0 create, 0 delete, 0 update, 0 noop
Wait to: 0 reconcile, 0 delete, 0 noop

Succeeded
```

which indicates that ``kapp`` in this case didn't actually detect any
difference in these resources output from ``ytt`` compared to what was
currently deployed. As a consequence, ``kapp`` didn't progress to applying
them to the cluster as there was no need to, so it didn't ask for
confirmation.
