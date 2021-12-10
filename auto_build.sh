#!/usr/bin/sh

rm -rf public
emacs -Q --script build_site.el
