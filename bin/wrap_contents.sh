#!/usr/bin/bash

contents=$1
bits=$2
target=$3

header=$bits\_header.html
footer=$bits\_footer.html

cat $header $contents $footer > $target
