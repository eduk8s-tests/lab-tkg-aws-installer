#!/bin/bash

NETWORK_MODE=host

if [[ "$OSTYPE" == "darwin"* ]]; then
    NETWORK_MODE=bridge
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if uname -a | grep -iq microsoft; then
        NETWORK_MODE=bridge
    fi
fi

docker-compose -f docker-compose-$NETWORK_MODE.yaml up
