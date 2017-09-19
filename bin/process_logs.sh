#!/usr/bin/bash

#gather arguments
files=$@

#make scratch directory
scratch=`mktemp -d`

#extract all arguments into scratch directory
for var in $files; do
	#get name of computer from filename using lookahead and lookbehind
	filename=${var#*/}
	name=${filename%_*}

	#make directory and place log files in them
	mkdir scratch/$name
	tar -zxf $var -C scratch/$name
done
