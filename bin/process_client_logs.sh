#!/bin/bash

dir=$1

cd $dir/var/log

cat * > mergeFile.txt

mf=mergeFile.txt

awk '/Failed password/' $mf > pwFail.txt

awk '{ print gensub(/(\w+)\s+([[:digit:]]+)\s([[:digit:]]{2}).* Failed password .* (\w+) from (\S+).*/,  "\\1 \\2 \\3 \\4 \\5", "g");}' pwFail.txt > failed_login_data.txt

mv failed_login_data.txt $dir

cd $dir
