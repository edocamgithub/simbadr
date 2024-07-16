#!/bin/bash
# Created 7 nov 2021 0057
# Write by Eduardo M. Araujo (c)2021-2024

db_DIR=$(simbadr-read-conf.sh -g)
lib_DIR=$(simbadr-read-conf.sh -l)
output_file="/tmp/simbadr/simbadr-duplicity-ip"

repeat_IP=$($lib_DIR"rwinfodb.sh" --locate $1 | wc -l) 
if test $repeat_IP -gt 1
	then
	$lib_DIR"rwinfodb.sh" --locate $1 >> "$output_file"
	echo $output_file
	else
		$lib_DIR"rwinfodb.sh" --locate $1	
	fi