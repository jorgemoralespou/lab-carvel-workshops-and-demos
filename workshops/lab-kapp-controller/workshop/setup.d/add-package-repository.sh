#!/bin/bash

set -x

# We need to first check that the packagerepositories.packaging.carvel.dev
# custom resource type exists. Because kapp-controller is getting installed
# in parallel to the workshop starting we will need to poll to check for
# when it is ready. We can then go ahead with adding the package repository.
# We run the command in background so that it doesn't delay the workshop
# starting, but the workshop instructions will need to have the user verify
# that the package repository has been reconciled before proceeding.

function add_repository() {
    STATUS=1
    ATTEMPTS=0
    COMMAND="kubectl get crd/packagerepositories.packaging.carvel.dev -o name"

    until [ $STATUS -eq 0 ] || $COMMAND || [ $ATTEMPTS -eq 12 ]; do
    sleep 5; $COMMAND; STATUS=$?; ATTEMPTS=$((ATTEMPTS + 1))
    done

    kctrl package repository add -r tce-repo --url projects.registry.vmware.com/tce/main:stable --dangerous-allow-use-of-shared-namespace
}

add_repository &
