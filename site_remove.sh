#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}

source $(dirname ${BASH_SOURCE})/env.bash

site_slug="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])"
sitedir=${SITES_BASEDIR}/${SITE}
drush_f=${TSADM_HOMEDIR}/.drush/${SITE}.aliases.drushrc.php
repos_basedir=/srv/git/${TSADM_USER}
tstamp=$(date '+%Y%m%d.%H%M%S')
repo_archive=${repos_basedir}/archive/${SITE}.git-${tstamp}.tgz
repodir=${SITES_REPO_BASEDIR}/${SITE}/${SITE}.git

for rmf in ${sitedir} ${drush_f}; do
    ansible ${SERVER} -s -i inventory.py -m file -a "path=${rmf} state=absent"
done

# -- slave

ansible ${SERVER} \
    -s -i inventory.py -m user \
    -a "name=${site_slug} state=absent remove=yes"

ansible ${SERVER} \
    -s -i inventory.py -m mysql_user \
    -a "name=${site_slug} state=absent"

# -- master

ansible ${MASTER_FQDN} \
    -s -i inventory.py -m file \
    -a "path=${repos_basedir}/archive state=directory"

ansible ${MASTER_FQDN} \
    -s -i inventory.py -m shell \
    -a "ionice -c3 tar -czf ${repo_archive} ${repodir}/"

ansible ${MASTER_FQDN} \
    -s -i inventory.py -m file \
    -a "path=${repodir} state=absent"

ansible ${MASTER_FQDN} \
    -s -i inventory.py -m user \
    -a "name=${site_slug} state=absent remove=yes"
