#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}
SENV=${3:?'site env?'}

source $(dirname ${BASH_SOURCE})/env.bash

dbname="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])${SENV}db"

ansible ${SERVER} \
    -i inventory.py \
    -m mysql_db -a "name=${dbname} state=absent"

ansible ${SERVER} \
    -s -i inventory.py \
    -m file -a "path=${SITES_BASEDIR}/${SITE}/${SENV} state=absent"
