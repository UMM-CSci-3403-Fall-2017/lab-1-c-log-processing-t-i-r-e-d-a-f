#!/usr/bin/bash

#store directory
dir=$1

#concatenate all failed_login_data.txt files
for i in $dir; do
	cat $i/*/f* > merge_file.txt
done

#turn our merged failed login files into a list of usernames and frequency count
awk '{print $4}' merge_file.txt | sort | uniq -c > user_names.txt

awk '{print "data.addRow([\x27"$2"\x27, "$1"]);"}' user_names.txt > user_counts.txt

#wrap contents in the appropriate header and footer and place results in desired output file
./bin/wrap_contents.sh user_counts.txt ./html_components/username_dist username_dist.html

#remove intermediary files
rm user_counts.txt
rm user_names.txt
rm merge_file.txt

#move output file to the correct directory
mv username_dist.html $dir
