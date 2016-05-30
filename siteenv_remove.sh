#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}
SENV=${3:?'site env?'}

source $(dirname ${BASH_SOURCE})/env.bash

### mysqladmin -f drop lonrestestdb
### rm -rf /home/tsadm/sites/lonres/test

site_name="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])"

ansible ${SERVER} \
    -i inventory.py \
    -m mysql_db -a "name=${site_name}${SENV}db state=absent"

ansible ${SERVER} \
    -s -i inventory.py \
    -m file -a "path=${SITES_BASEDIR}/${site_name}/${SENV} state=absent"
