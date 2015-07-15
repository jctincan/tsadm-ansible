#!/bin/bash
set -x
privdir=`realpath $(dirname $0)/private`
exec ansible-playbook -s -T 15 -i invlist.py -e "privdir=${privdir}" $@
