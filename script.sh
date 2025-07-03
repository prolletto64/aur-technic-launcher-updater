#!/bin/bash

cd "$(dirname $0)"

VERSION=$(cat ./version)
API_URL="https://api.technicpack.net/launcher/version/stable4"
UPDATED=$(curl $API_URL | jq .build)

if [ $VERSION != $UPDATED ]; then
    ./update.sh $UPDATED
fi
