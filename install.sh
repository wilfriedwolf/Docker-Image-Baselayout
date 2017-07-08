#!/bin/sh

set -o pipefail  ## trace ERR through pipes
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

umask 0022

if [ -f "/sbin/apk" ]; then
    # Alpine linux
    apk add --no-cache ca-certificates wget --virtual .webdevops-baselayout-deps
    update-ca-certificates
    wget -O /tmp/baselayout.tar.gz https://github.com/webdevops/Docker-Image-Baselayout/archive/latest.tar.gz
    apk del .webdevops-baselayout-deps
else
    # General linux
    wget -O /tmp/baselayout.tar.gz https://github.com/webdevops/Docker-Image-Baselayout/archive/latest.tar.gz
fi


tar --no-same-permissions --strip-components=2 -xf /tmp/baselayout.tar.gz  -C
rm -f /tmp/baselayout.tar.gz