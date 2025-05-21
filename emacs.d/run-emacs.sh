#!/bin/sh

# This script is only meant for use in Emacs From Scratch streams.  It starts up
# Emacs with no other configuration than the one in init.el aside from some
# necessary tweaks in stream-tweaks.el that are only meant for use in the live
# stream.

export EMACSLOADPATH="/usr/share/emacs/site-lisp:/usr/share/emacs/29.4/lisp"
#emacs -Q --load stream-tweaks.el --load init.el Emacs.org
#/home/ronghusong/src/github/ext-local/bin/emacs -Q --load init.el --debug-init
/usr/bin/emacs -Q --load ~/.emacs.d/init.el #--debug-init
