#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}
SENV=${3:?'site env?'}

source $(dirname ${BASH_SOURCE})/env.bash

### mysqldump lonrestestdb
### tgz /home/tsadm/sites/lonres/test

tstamp=$(date '+%Y%m%d.%H%M%S')
site_name="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])"
site_dir=${SITES_BASEDIR}/${site_name}
siteenv_dir=${site_dir}/${SENV}
siteenv_file=${site_dir}/${site_name}${SENV}-${tstamp}.tgz
dbname="${site_name}${SENV}db"
dbfile=${site_dir}/${dbname}-${tstamp}.sql.gz

ansible ${SERVER} \
    -i inventory.py \
    -m mysql_db -a "name=${dbname} state=dump target=${dbfile}"

ansible ${SERVER} \
    -s -i inventory.py \
    -m shell "ionice -c3 tar -czf ${siteenv_file} ${siteenv_dir}/"
