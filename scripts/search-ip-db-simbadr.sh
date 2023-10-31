#!/bin/bash
# Created 7 nov 2021 0057
# Write by Eduardo M. Araujo 

db_DIR=$(simbadr-read-conf.sh -g)
lib_DIR=$(simbadr-read-conf.sh -l)

$lib_DIR"rwinfodb.sh" --locate $1 
