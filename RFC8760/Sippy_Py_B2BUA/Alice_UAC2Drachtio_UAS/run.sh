#!/bin/sh

cd ~/voiptests.drachtio
while true; do python3.7 alice.py  -4 -t 1 -l '*' -P 50601 -T 120 -n drachtio.org:5060; sleep 3; done
