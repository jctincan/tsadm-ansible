#!/bin/bash
PATH=/usr/bin:/bin
repo_name=${1:?'repo name?'}
repo_path=${2:?'repo path?'}

test -s ${repo_path}/description &&
{
    echo "${repo_path}/description already exists... aborting" >&2
    exit 1
}

set -e

rsync -ax /srv/git/tsadm/tsadm-git/init-tmpl.git/ ${repo_path}/
echo "${repo_name} site" >${repo_path}/description

ln -s /opt/tsadm/libexec/git/post-receive ${repo_path}/hooks/
chown -R ${repo_name}:${repo_name} ${repo_path}

exit 0
