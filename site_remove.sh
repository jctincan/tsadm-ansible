#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}
SENV=${3:?'site env?'}

source $(dirname ${BASH_SOURCE})/env.bash

dbsettings=${TSADM_HOMEDIR}/drupal-settings/${SITE}.${SENV}-db.php
privdir=${TSADM_HOMEDIR}/private/${SITE}.${SENV}
site_slug="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])"
vhost_f=${ETCDIR}/apache.d/*-${site_slug}${SENV}.conf
sitedir=${SITES_BASEDIR}/${SITE}

for rmpath in ${dbsettings} ${privdir} ${vhost_f} ${sitedir}; do
    ansible ${SERVER} -s -i inventory.py -m file
                      -a "path=${rmpath} state=absent"
done

ansible ${SERVER} \
    -s -i inventory.py -m user \
    -a "name=${site_slug} state=absent remove=yes"

ansible ${SERVER} \
    -s -i inventory.py -m mysql_user \
    -a "name=${site_slug} state=absent"
