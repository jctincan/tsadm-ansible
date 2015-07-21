#!/bin/bash
set -x
privdir=`realpath $(dirname $0)/private`
time ansible-playbook -v -s -T 15 -i invlist.py -e "privdir=${privdir}" $@
