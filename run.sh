#!/bin/bash
set -ex
umask 0027
time ansible -v -T 15 -i inventory.py $@
