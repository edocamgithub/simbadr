#!/bin/bash
# Created 2 dez 2021 1155
# Write by Eduardo M. Araujo (c)2021-2024
# Function: Totalize all groups at /etc/simbadr/simbadr "groups_enable" for Global file 92 group

db_DIR=$(simbadr-read-conf.sh -g)
lib_DIR=$(simbadr-read-conf.sh -l)
etc_DIR=$(simbadr-read-conf.sh -s)
group_enable_list="simbadr"
output_file="92"
debug=$1

group_list=$(cat "$etc_DIR""$group_enable_list" | grep -wF group_enable | cut -d"=" -f2)
path=$(echo "$db_DIR")

rm -f "$path""$output_file"

if [[ $debug = "--debug" ]]
	then
     echo "Variables of sum-device-92"    
     echo "           DB dir: "$db_DIR
     echo "          LIB dir: "$lib_DIR
     echo "          ETC dir: "$etc_DIR
     echo "Enable Group List: "$group_enable_list
     echo "      Output file: "$output_file
     echo "            Input: "$debug
 	  echo "        GroupList: "$group_list
	  echo "             Path: "$path
	fi

for seq_group_list in $group_list
do
cat "$path""$seq_group_list" | sort -u -n >> "$path""$output_file"
done