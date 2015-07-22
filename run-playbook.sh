#!/bin/bash
set -x
privdir=`realpath $(dirname $0)/private`
test -d ${privdir} && test -w ${privdir} || {
    echo "${privdir}: dir not found or not writable" >&2
    exit 1
}
time ansible-playbook -v -T 15 -i invlist.py -e "privdir=${privdir}" $@
