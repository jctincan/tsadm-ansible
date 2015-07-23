#!/bin/bash
PATH=/usr/bin:/bin
repo_user=${1:?'repo user?'}
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

rsync -ax /opt/tsadmdev/site-init-tmpl.git/ ${repo_path}/
echo "tsadmdev ${repo_user} site" >${repo_path}/description

chown -R ${repo_user}:${www_group} ${repo_path}
umask ${old_umask}

exit 0
