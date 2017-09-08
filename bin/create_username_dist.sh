#!/usr/bin/bash

#####in-progress, not functional yet########

#store directory
dir=$1

#initialize body file that will contain the data.addRow lines
contents=contents.txt

#create data section from the summarized failed_login_data.txt files
##TODO

#wrap contents in the appropriate header and footer and place results in desired output file
./bin/wrap_contents.sh $contents html_components/username_dist username_dist.html

#move output file to the correct directory
mv username_dist.html $dir
