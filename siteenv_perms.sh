#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}
SENV=${3:?'site env?'}

source $(dirname ${BASH_SOURCE})/env.bash

pub_owner="${SITE}$(echo ${RUN_MODE} | tr [:lower:] [:upper:])"

ansible ${SERVER} \
    -s -i inventory.py -s \
    -M roles/slave-server/library \
    -m site_env_perms \
    -a "env_basedir=${SITES_BASEDIR}/${SITE}/${SENV} owner=${TSADM_USER} group=${WWW_GROUP} public_owner=${pub_owner} public_group=${WWW_GROUP} public_dir_mode=2770 public_file_mode=0660 public_path_regex=r\".*/sites/.*/files($|/.*)\""
