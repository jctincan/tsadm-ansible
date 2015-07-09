#!/bin/bash
set -e
playbook=${1:-'main.yml'}
exec ansible-playbook -i invlist.py ${playbook}
