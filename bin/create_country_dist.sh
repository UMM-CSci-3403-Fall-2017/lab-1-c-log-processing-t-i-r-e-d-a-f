#!/usr/bin/bash

#store directory and country codes
dir=$1

#concatenate all failed_login_data.txt files
for i in $dir; do
	cat $i/*/f* > merge_file.txt
done

#turn our merged failed login files into a list of usernames and frequency count
awk '{print $5}' merge_file.txt | sort | uniq -c > user_namesIP.txt

sort ./etc/country_IP_map.txt > IP_map.txt

#add country codes
join -1 2 -2 1 user_namesIP.txt IP_map.txt > joined_IP.txt

#######################################IN PROGRESS-generates too many rows#######hi##########################################################

#generate data rows
awk '{print "data.addRow([\x27"$3"\x27, "$2"]);"}' joined_IP.txt > code_counts.txt

#wrap contents in header and footer and place results in desired output file
./bin/wrap_contents.sh code_counts.txt ./html_components/country_dist country_dist.html

#remove intermediary files
rm user_namesIP.txt
rm joined_IP.txt
rm merge_file.txt
rm IP_map.txt
rm code_counts.txt
