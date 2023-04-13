The alternative to copying and editing the files each time we want to deploy
the application under a different name is to make use of the ``ytt`` tool from
the Carvel tool set to solve the problem.

There are two different ways that ``ytt`` could be used to do this.

The first is to convert the existing resource definitions into templates which
work with ``ytt``. This involves making changes to the resource files and
adding markup and logic to them which allows us to parameterize the output
they produce.

The second is to leave the resource files as is, but create separate overlays
which when applied with ``ytt`` will result in edits being made on the fly to
the original resources before they get applied to the Kubernetes cluster.

Each approach has its own pros and cons in different circumstances so which
you use, or whether you use a combination of both, will depend on the use
case.

In this workshop we will be investigating the first approach of converting the
existing resource files to templates. The use of overlays will be covered in
a separate workshop.
