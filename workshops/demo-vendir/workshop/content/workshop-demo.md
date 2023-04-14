Vendir allows you to declaratively state what should be in a directory

Let's take a look at the vendir file.

```editor:open-file
file: ~/exercises/vendir.yml
```

We watch the current directory tree to see the changes.

```terminal:execute
command: watch tree
session: 2
```

Now, we create a vendir file that will synchronize files from GitHub

```terminal:execute
command: vendir sync
session: 1
```

We see that the content of the Github project was pulled and that only the desired file are kept.

Vendir supports the following sources for fetching:
- git
- hg (Mercurial)
- http
- image (image from OCI registry)
- imgpkgBundle (bundle from OCI registry)
- githubRelease
- helmChart
- directory
