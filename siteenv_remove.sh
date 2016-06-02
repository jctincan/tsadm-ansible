#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}
SENV=${3:?'site env?'}

source $(dirname ${BASH_SOURCE})/env.bash

site_slug="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])"
dbname="${site_slug}${SENV}db"
dbsettings=${TSADM_HOMEDIR}/drupal-settings/${SITE}.${SENV}-db.php
envdir=${SITES_BASEDIR}/${SITE}/${SENV}
privdir=${TSADM_HOMEDIR}/private/${SITE}.${SENV}
vhost_f=${ETCDIR}/apache.d/*-${site_slug}${SENV}.conf

ansible ${SERVER} \
    -i inventory.py \
    -m mysql_db -a "name=${dbname} state=absent"

for rmpath in ${dbsettings} ${privdir} ${vhost_f} ${envdir}; do
   ansible ${SERVER} -s -i inventory.py -m file -a "path=${rmpath} state=absent"
done
