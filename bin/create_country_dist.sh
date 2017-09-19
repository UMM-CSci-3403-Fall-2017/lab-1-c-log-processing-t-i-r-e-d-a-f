#!/usr/bin/bash

#store directory and country codes
dir=$1

#concatenate all failed_login_data.txt files
for i in $dir; do
	cat $i/*/f* > merge_file.txt
done

#turn our merged failed login files into a list of usernames and frequency count
awk '{print $5}' merge_file.txt | sort > user_namesIP.txt

sort ./etc/country_IP_map.txt > IP_map.txt

#add country codes
join -1 1 -2 1 user_namesIP.txt IP_map.txt > joined_IP.txt

awk '{print $2}' joined_IP.txt | sort | uniq -c > counted_IP.txt 

#wrap contents in header and footer and place results in desired output file
./bin/wrap_contents.sh code_counts.txt ./html_components/country_dist country_dist.html

#move output file to the correct directory
mv country_dist.html $dir

#remove intermediary files
rm user_namesIP.txt
rm joined_IP.txt
rm merge_file.txt
rm IP_map.txt
rm code_counts.txt
rm counted_IP.txt
