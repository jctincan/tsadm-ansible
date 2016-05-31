#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}
SENV=${3:?'site env?'}

source $(dirname ${BASH_SOURCE})/env.bash

tstamp=$(date '+%Y%m%d.%H%M%S')
archive_dir=${TSADM_HOMEDIR}/archive
site_dir=${SITES_BASEDIR}/${SITE}
siteenv_dir=${site_dir}/${SENV}
siteenv_file=${archive_dir}/${SITE}${SENV}-${tstamp}.tgz
dbname="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])${SENV}db"
dbfile=${archive_dir}/${dbname}-${tstamp}.sql.gz

ansible ${SERVER} \
    -s -i inventory.py  -m file \
    -a "path=${archive_dir} state=directory mode=750 owner=${TSADM_USER}"

ansible ${SERVER} \
    -s -i inventory.py \
    -m mysql_db -a "name=${dbname} state=dump target=${dbfile}"

ansible ${SERVER} \
    -s -i inventory.py -m shell \
    -a "ionice -c3 tar -czf ${siteenv_file} --exclude='.git' ${siteenv_dir}/"
