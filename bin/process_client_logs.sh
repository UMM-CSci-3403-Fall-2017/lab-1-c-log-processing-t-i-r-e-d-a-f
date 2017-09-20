#!/usr/bin/bash

dir=$1

#move to the directory containing the log files
cd $dir/var/log

#concatenate logs into one file so they are easier to filter through
cat * > mergeFile.txt

#reduce logs to only the entries with failed passwords
awk '/Failed password/' mergeFile.txt > pwFail.txt

#use regex to transform the entries into the desired format
awk '{ print gensub(/(\w+)\s+([[:digit:]]+)\s([[:digit:]]{2}).* Failed password .* (\S+) from (\S+).*/,  "\\1 \\2 \\3 \\4 \\5", "g");}' pwFail.txt > failed_login_data.txt

#clean up intermediary files
rm mergeFile.txt
rm pwFail.txt

#place output file in the correct directory
mv failed_login_data.txt ../../
