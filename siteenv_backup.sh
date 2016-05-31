#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}
SENV=${3:?'site env?'}

source $(dirname ${BASH_SOURCE})/env.bash

### mysqldump lonrestestdb
### tgz /home/tsadm/sites/lonres/test

tstamp=$(date '+%Y%m%d.%H%M%S')
site_dir=${SITES_BASEDIR}/${SITE}
siteenv_dir=${site_dir}/${SENV}
siteenv_file=${site_dir}/${SITE}${SENV}-${tstamp}.tgz
dbname="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])${SENV}db"
dbfile=${site_dir}/${dbname}-${tstamp}.sql.gz

ansible ${SERVER} \
    -s -i inventory.py \
    -m mysql_db -a "name=${dbname} state=dump target=${dbfile}"

ansible ${SERVER} \
    -s -i inventory.py \
    -m shell -a "ionice -c3 tar -czf ${siteenv_file} --exclude='.git' ${siteenv_dir}/"
