#!/usr/bin/bash

rm -rf public
emacs -Q --script build_site_local.el
http-server -p 5000 ./public
