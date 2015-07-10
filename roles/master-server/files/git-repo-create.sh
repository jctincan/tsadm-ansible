#!/bin/bash
PATH=/usr/bin:/bin
repo_name=${1:?'repo name?'}
repo_path=${2:?'repo path?'}
www_group=${3:?'webserver os group?'}

test -s ${repo_path}/description &&
{
    echo "${repo_path}/description already exists... aborting" >&2
    exit 1
}

set -e
old_umask=`umask`
umask 0027

rsync -ax /srv/git/tsadm/users/tsadmgit/init-tmpl.git/ ${repo_path}/
echo "${repo_name} site" >${repo_path}/description

chown -R ${repo_name}:${www_group} ${repo_path}
umask ${old_umask}

exit 0
