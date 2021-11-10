#!/usr/bin/sh

rm -rf ./public index.html

emacs -Q --script build_site.el

cp ./public/index.html index.html
