#!/bin/bash

SERVER=${1:?'server?'}
SITE=${2:?'site?'}
SENV=${3:?'site env?'}

ansible ${SERVER} \
        -i inventory.py -s -M roles/slave-server/library \
        -m site_env_perms \
        -a "env_basedir=/home/tsadm/sites/${SITE}/${SENV} owner=tsadm group=nobody public_owner=${SITE} public_group=nobody public_dir_mode=2770 public_file_mode=0660 public_path_regex=r\".*/sites/.*/files($|/.*)\""
