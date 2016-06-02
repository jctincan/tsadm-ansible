#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}

source $(dirname ${BASH_SOURCE})/env.bash

site_slug="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])"
sitedir=${SITES_BASEDIR}/${SITE}
drush_f=${TSADM_HOMEDIR}/.drush/${SITE}.aliases.drushrc.php

for rmf in ${sitedir} ${drush_f}; do
    ansible ${SERVER} -s -i inventory.py -m file -a "path=${rmf} state=absent"
done

ansible ${SERVER} \
    -s -i inventory.py -m user \
    -a "name=${site_slug} state=absent remove=yes"

ansible ${SERVER} \
    -s -i inventory.py -m mysql_user \
    -a "name=${site_slug} state=absent"
