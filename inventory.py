#!/usr/bin/env python2

from __future__ import print_function

INVLIST_URL = 'http://master.tsadm.local:8000/asb/inv/lst/'
SSL_CERT_FILE = '.asbot.pem'

import sys
import os.path

from urllib2 import urlopen

ssl_context = None
if INVLIST_URL.startswith('https:'):
    try:
        import ssl
        ssl_context = ssl.create_default_context()
        ssl_context.check_hostname = False
        ssl_context.verify_mode = ssl.CERT_NONE
        ssl_context.load_cert_chain(SSL_CERT_FILE)
    except Exception as e:
        print(INVLIST_URL, str(e))

if len(sys.argv) >= 2 and sys.argv[1] == '--list':
    try:
        print(urlopen(INVLIST_URL, timeout=15, context=ssl_context).read())
    except Exception as e:
        print(INVLIST_URL, str(e))
else:
    print('{}')

sys.exit(0)
