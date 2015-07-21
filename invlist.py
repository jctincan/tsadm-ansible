#!/usr/bin/env python2

INVLIST_URL = 'http://master.tsadm.local:8000/asb/inv/lst/'

import sys
import os.path

from urllib2 import urlopen

if len(sys.argv) >= 2 and sys.argv[1] == '--list':
    try:
        print(urlopen(INVLIST_URL, timeout=15).read())
    except Exception as e:
        print(INVLIST_URL, str(e))
else:
    print('{}')

sys.exit(0)
