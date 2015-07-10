#!/bin/bash
set -e
playbook=${1:-'main.yml'}
exec ansible-playbook -s -i invlist.py ${playbook}
