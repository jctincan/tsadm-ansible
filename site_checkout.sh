#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}
SENV=${3:?'site env?'}

source $(dirname ${BASH_SOURCE})/env.bash

git_user="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])"

ansible ${SERVER} \
    -s -i inventory.py \
    -m git \
    -a "dest=${SITES_BASEDIR}/${SITE}/${SENV} repo=ssh://${git_user}@${MASTER_FQDN}:28128/~/${SITE}.git key_file=${TSADM_HOMEDIR}/.ssh/id_rsa accept_hostkey=yes"
