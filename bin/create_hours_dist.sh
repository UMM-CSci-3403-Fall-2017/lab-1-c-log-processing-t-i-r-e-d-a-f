#!/usr/bin/bash

#store directory
dir=$1

#concatenate all faile_login_data.txt files
for i in $dir; do
	cat $i/*/f* > merge_file.txt
done

#turn our merged failed logn files into a list of hours and frequency count
awk '{print $3}' merge_file.txt | sort | uniq -c > hours.txt

awk '{print "data.addRow([\x27"$2"\x27, "$1"]);"}' hours.txt > hour_counts.txt

#wrap contents in the appropriate header and footer and place results in desired output file

./bin/wrap_contents.sh hour_counts.txt ./html_components/hours_dist hours_dist.html

#remove intermediary files
 rm hours.txt
 rm hour_counts.txt
 rm merge_file.txt

#move output file to the correct directory
mv hours_dist.html $dir 
