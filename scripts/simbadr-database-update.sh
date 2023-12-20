#!/bin/bash
##################################################################
#  File: simbadr-database-update.sh    
#  Version: 0.0.1 
#  Created 24 out 2022 1105am					 
#
#  Function:  
#                   ---------------------------
#  Required:
#           
#  Note:
#	
#                 ---------------------------
#
#  Written by Eduardo M. Araujo. - versão 0.0.1
#  Copyright (c)2022 Eduardo M. Araujo..
#
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="0.0.1"
     BUILT="2022Mar07"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2022-2023 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG="/var/log/log_$$.log"
   
   baseDIR_LIB=$(simbadr-read-conf.sh -l)
	baseDIR_DB=$(simbadr-read-conf.sh -g)
	file_LIST=$baseDIR"92"

#./lib/simbadr/simbadr-normalize-db.sh var/log/simbadr/blocks/00/92

#./lib/simbadr/simbadr-merge-db.sh var/log/simbadr/blocks/00/92 hostname
#./lib/simbadr/simbadr-merge-db.sh var/log/simbadr/blocks/00/92 network
#./lib/simbadr/simbadr-merge-db.sh var/log/simbadr/blocks/00/92 system
#./lib/simbadr/simbadr-merge-db.sh var/log/simbadr/blocks/00/92 inventory
#./lib/simbadr/simbadr-merge-db.sh var/log/simbadr/blocks/00/92 vendor
#./lib/simbadr/simbadr-merge-db.sh var/log/simbadr/blocks/00/92 contact

"$baseDIR_LIB"simbadr-merge-db.sh "$file_LIST" hostname
"$baseDIR_LIB"simbadr-merge-db.sh "$file_LIST" network
"$baseDIR_LIB"simbadr-merge-db.sh "$file_LIST" system
"$baseDIR_LIB"simbadr-merge-db.sh "$file_LIST" inventory
"$baseDIR_LIB"simbadr-merge-db.sh "$file_LIST" vendor
"$baseDIR_LIB"simbadr-merge-db.sh "$file_LIST" contact


read -p 'Continue ? (yes or no)?' choice

if [ $choice = "yes" ]
	then
		"$baseDIR_LIB"simbadr-import-db.sh "$file_LIST"	 
# ./lib/simbadr/simbadr-import-db.sh var/log/simbadr/blocks/00/92
   else
    echo "Finish script! "
      	exit
   fi	
