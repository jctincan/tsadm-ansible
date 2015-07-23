#!/bin/bash
set -ex
umask 0027
privdir=`realpath ~/ansible.private`
mkdir -vp ${privdir}
test -d ${privdir} && test -w ${privdir} || {
    echo "${privdir}: dir not found or not writable" >&2
    exit 1
}
time ansible-playbook -v -T 15 -i inventory.py -e "privdir=${privdir}" $@ main.yml
