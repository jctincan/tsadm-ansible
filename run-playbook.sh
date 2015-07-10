#!/bin/bash
exec ansible-playbook -s -i invlist.py $@
