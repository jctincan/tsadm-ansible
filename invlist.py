#!/usr/bin/env python2

INVLIST_URL = 'http://dev.tsadm.local:8000/asb/inv/lst/'

import sys
import os.path

from urllib2 import urlopen

run_mode = ''
if sys.argv[0].endswith('test.py'):
    run_mode = 'test'
elif sys.argv[0].endswith('dev.py'):
    run_mode = 'dev'
print(run_mode)

if len(sys.argv) >= 2 and sys.argv[1] == '--list':
    print(urlopen(INVLIST_URL, timeout=15).read())
else:
    print('{}')

sys.exit(0)