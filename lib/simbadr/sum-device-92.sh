#!/bin/bash
# Created 2 dez 2021 1155
# Write by Eduardo M. Araujo 
# Function: Totalize all groups at /etc/simbadr/simbadr "groups_enable" for Global file 92 group

db_DIR=$(simbadr-read-conf.sh -g)
lib_DIR=$(simbadr-read-conf.sh -l)
etc_DIR=$(simbadr-read-conf.sh -s)
group_enable_list="simbadr"
output_file="92"
TEMP_LOCAL_SIMBADR="/tmp/simbadr"

# Verifica a existenica do DIR=tmp/simbadr/
if test -d $TEMP_LOCAL_SIMBADR
	then
  		echo "/tmp/simbadr not found!" >/dev/null
	else
  		mkdir $TEMP_LOCAL_SIMBADR
	fi

group_list=$(cat "$etc_DIR""$group_enable_list" | grep -w group_enable | cut -d"=" -f2)
path=$(echo "$db_DIR")

rm -f "$path""$output_file"

for seq_group_list in $group_list
do
cat "$path""$seq_group_list" | sort -u -n >> "$path""$output_file"
done

sort -n -t. -k1 "$path""$output_file" > "$TEMP_LOCAL_SIMBADR/""simbadr.sort" &&  mv "$TEMP_LOCAL_SIMBADR/""simbadr.sort" "$path""$output_file"

