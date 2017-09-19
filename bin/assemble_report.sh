#!/usr/bin/bash

dir=$1

#concatenate all html files
for i in $dir; do
	cat $i/* > summary.txt
done

#wrap file in its header and footer
./bin/wrap_contents.sh summary.txt ./html_components/summary_plots failed_login_summary.html

#remove intermediary file
rm summary.txt

#move output file to correct directory
mv failed_login_summary.html $dir
