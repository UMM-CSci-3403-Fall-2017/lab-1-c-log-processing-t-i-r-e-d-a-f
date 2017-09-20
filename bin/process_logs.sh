#!/usr/bin/bash

#gather arguments
files=$@
dir=$(pwd)

#make scratch directory
scratch=`mktemp -d`

#extract all arguments into scratch directory
for var in $files; do
	#get name of computer from filename using lookahead and lookbehind
	filename=${var#*/}
	name=${filename%_*}

	#make directory and place log files in them
	mkdir $scratch/$name
	tar -zxf $var -C $scratch/$name

	#process client logs
	./bin/process_client_logs.sh $scratch/$name
done

#create username hours and country distributions
./bin/create_username_dist.sh $scratch
./bin/create_hours_dist.sh $scratch
./bin/create_country_dist.sh $scratch

#combine result files
./bin/assemble_report.sh $scratch

#move summary file
mv $scratch/failed_login_summary.html $dir
