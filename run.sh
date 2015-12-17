#!/bin/bash
set -e
umask 0027
time ansible -T 15 -i inventory.py $@
