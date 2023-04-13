The full range of ways available for installing the Carvel tools can be found
in the [Carvel documentation](https://carvel.dev/). This includes using a
supplied script, from the Homebrew package repositories, or individually from
the GitHub package releases for Carvel.

In this workshop we will use the shell script for installing the Carvel tools
which is supplied by the Carvel project.

The location of this install script is:

* https://carvel.dev/install.sh

You can download the install script to your own local machine and verify what
it does before running it, or trust it and use `curl` or `wget` to fetch the
script and execute it directly.

Before we run the install script you need to be aware that by default the
script will assume that it can install into `/usr/local/bin`. You therefore
will need to run the script as the `root` user, or use `sudo`.

The alternative to installing the Carvel tools as the super user, is to run
the install script as your own user, but in doing this you need to make sure
the target directory where you want to install the tools exists, and tell the
installation script what that directory is.

For this workshop environment create the directory `$HOME/bin`.

```terminal:execute
command: mkdir -p $HOME/bin
```

You can now fetch the install script and run it using:

```terminal:execute
command: curl -L https://carvel.dev/install.sh | K14SIO_INSTALL_BIN_DIR=$HOME/bin bash
```

The script will download and install each of the CLI programs supplied with
Carvel, verifying the checksum of the files for each file to ensure they are
the expected binaries.

The output should be similar to:

```
Installing linux-amd64 binaries...
Installing ytt...
/tmp/ytt: OK
Installed /home/eduk8s/bin/ytt v0.40.1
Installing imgpkg...
/tmp/imgpkg: OK
Installed /home/eduk8s/bin/imgpkg v0.28.0
Installing kbld...
/tmp/kbld: OK
Installed /home/eduk8s/bin/kbld v0.33.0
Installing kapp...
/tmp/kapp: OK
Installed /home/eduk8s/bin/kapp v0.46.0
Installing kwt...
/tmp/kwt: OK
Installed /home/eduk8s/bin/kwt v0.0.6
Installing vendir...
/tmp/vendir: OK
Installed /home/eduk8s/bin/vendir v0.27.0
Installing kctrl...
/tmp/kctrl: OK
Installed /home/eduk8s/bin/kctrl v0.36.1
```

This will show the names of the CLI programs installed and the versions. The
versions shown may differ as the install script will always install the
latest versions.
