#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}
SENV=${3:?'site env?'}

ansible ${SERVER} \
    -s \
    -i inventory.py \
    -m git \
    -a "dest=/home/tsadm/sites/${SITE}/${SENV} repo=ssh://${SITE}@tsadm.tincan.co.uk:28128/~/${SITE}.git key_file=/home/tsadm/.ssh/id_rsa accept_hostkey=yes"
