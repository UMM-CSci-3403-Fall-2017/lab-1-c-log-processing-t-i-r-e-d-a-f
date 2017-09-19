#!/usr/bin/bash

#gather arguments
files=$@

#make scratch directory
scratch=`mktemp -d`

#########IN PROGRESS, STILL NEEDS FOLDER NAMES##############

#extract all arguments into directory
for var in $files; do
	tar -zxf $var > $scratch
done
