#!/usr/bin/bash

dir=$1

cd $dir/var/log

cat * > mergeFile.txt

mf=mergeFile.txt

################IN PROGRESS (awk regex filter)########################

#awk '/(\w+)\s(\d+)\s(\d{2}).* Failed password .* (\w+) from (\S+)/{print}' $mf > failed_login_data.txt
