#!/bin/bash

# If the Kind API proxy is enabled, we need to modify the the TKG installer
# BOM files which setup the Kind cluster. These don't exist initially so
# need to make sure they are generated. This can be done by trying to list
# the available management clusters.

tkg get management-clusters > /dev/null 2>&1

# Calculate the list of BOM files that need to be modified.

BOM_FILES=`grep -rl kubeadmConfigPatches $HOME/.tkg/bom/bom-*.yaml`

# Patch each of the BOM files and add a well known port for Kind to use for
# the Kubernetes REST API endpoint.

for file in $BOM_FILES; do
    if ! grep "apiServerPort: 11111" $file > /dev/null 2>&1; then
        sed -i.bak -e "/kubeadmConfigPatches:/i \- 'networking:'\n\- '  apiServerPort: 11111'" $file
    fi
done

# Finally run the tkg installer in a loop so can restart if necessary.

while true; do
    echo "Executing: tkg init --ui"
    echo
    tkg init --ui --bind workshop-installer.127.0.0.1.nip.io:8080 --browser=none
    sleep 5
    echo
    echo
    read -p "The tkg installer has exited. Press enter to restart."
    echo
done
