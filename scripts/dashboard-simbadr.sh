#!/bin/bash
# Created 9 nov 2021 0855
# Write by Eduardo M. Araujo 

db_DIR=$(simbadr-read-conf.sh -g)
lib_DIR=$(simbadr-read-conf.sh -l)
etc_DIR=$(simbadr-read-conf.sh -s)
group_enable_list="simbadr"

  ip_INPUT=$1
  db_FROM=$2 
  db_TO=$3

seq_group_list=$(echo $etc_DIR$group_enable_list)
cat $seq_group_list |  grep -w group_enable | cut -d"=" -f2 

"$lib_DIR"infodash.sh

exit 0

