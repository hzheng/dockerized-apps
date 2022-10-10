#!/bin/bash

# run this script to generate/re-generate nginx certificates

read_password() {
    while true
    do
        read -sp "type SSL passphrase: " val
        if [ ${#val} -lt 4 ]; then
            echo "passphrase should be at least 4 character long" >&2
        else
            echo $val
            exit
        fi
    done
}

dir=$DOCKER_VOLUMES/nginx/certs
mkdir -p $dir || { echo "failed to created $dir" && exit 1; }

name=${1-nginx}
cd $dir
echo -n $(read_password) > ${name}.pass

openssl genrsa -des3  -passout file:${name}.pass -out ${name}.key 4096
openssl req -x509 -new -nodes -key ${name}.key -sha256 -days 3650  -passin file:${name}.pass -subj "/CN=*.your.hostname" -out ${name}.crt

