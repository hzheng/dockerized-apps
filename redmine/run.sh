#!/bin/bash

#echo current directory is `pwd`

#[ -z "${SMTP_ADDRESS}" ] && echo "SMTP_ADDRESS is not set" && exit 1

#echo SMTP_ADDRESS=$SMTP_ADDRESS

#sed -i "s/\$SMTP_ADDRESS/$SMTP_ADDRESS/g" config/configuration.yml

/docker-entrypoint.sh rails server -b 0.0.0.0
