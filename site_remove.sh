#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}

source $(dirname ${BASH_SOURCE})/env.bash

site_slug="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])"
sitedir=${SITES_BASEDIR}/${SITE}

ansible ${SERVER} \
    -s -i inventory.py -m file \
    -a "path=${sitedi} state=absent"

ansible ${SERVER} \
    -s -i inventory.py -m user \
    -a "name=${site_slug} state=absent remove=yes"

ansible ${SERVER} \
    -s -i inventory.py -m mysql_user \
    -a "name=${site_slug} state=absent"
