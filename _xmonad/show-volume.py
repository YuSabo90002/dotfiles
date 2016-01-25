#! /usr/bin/python
# -*- encoding: utf-8 -*-

import sys
try:
  import alsaaudio
except:
  print >> sys.stderr, "Error: pyalsaaudio not installed"
  sys.exit(1)

name="Master"
try:
    mixer=alsaaudio.Mixer(name)
except alsaaudio.ALSAAudioError:
    print >> sys.stderr,"Error: No such control: %s" % name
    sys.exit(1)
if mixer.getmute()[0]==0 :
    m=mixer.getvolume()
    print(m[0],"%")
else :
    print(" mute")
sys.stdout.flush
