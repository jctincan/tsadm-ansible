#!/bin/bash
set -e
umask 0027
privdir=`realpath ~/ansible.private`
mkdir -p ${privdir}
test -d ${privdir} && test -w ${privdir} || {
    echo "${privdir}: dir not found or not writable" >&2
    exit 1
}
time ansible-playbook -T 15 -i inventory.py \
    -e "privdir=${privdir}" $@ main.yml | grep -Ev '^ok:|^skipping:'
