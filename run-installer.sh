#!/bin/bash

NETWORK_MODE=host

if [[ "$OSTYPE" == "darwin"* ]]; then
    NETWORK_MODE=bridge
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if uname -a | grep -iq microsoft; then
        if docker info | grep -q "Operating System: Docker Desktop"; then
            NETWORK_MODE=bridge
        fi
    fi
fi

docker-compose -f docker-compose-$NETWORK_MODE.yaml up "$@"
