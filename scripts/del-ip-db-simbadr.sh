#!/bin/bash
# Created 7 nov 2021 0057
# Write by Eduardo M. Araujo (c)2021-2024
# Function: Delete the IP number in database group.

   APPNAME=$(basename $0)
   VERSION="0.1.1"
     BUILT="2021nov07"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (C)2019-2023 Eduardo M. Araujo."
   CONTACT="Contact for email: <edocam@outlook.com>"
   
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log


# Habilita a impressao de variaveis
debugVisible=false



db_DIR=$(simbadr-read-conf.sh -g)

lib_DIR=$(simbadr-read-conf.sh -l)


simbadr_remove_ip_only_DIR=$(simbadr-read-conf.sh --group93)
simbadr_remove_ip_only_FILE=$simbadr_remove_ip_only_DIR"removedip.list"
simbadr_remove_ip_for_list_DIR=$(simbadr-read-conf.sh --group92)


function debug_log ()
{
log_
if [ $debugVisible = true ]
	then
		echo $logs_simbadr     	
		echo $logs_simbadr  >> $AUTHLOG 2>> $AUTHLOG
		else
			echo $logs_simbadr  >> $AUTHLOG 2>> $AUTHLOG
fi
}


# Log de variaveis
function log_ () {
PIDexec=$(pgrep $APPNAME)
DATEpid=$(date "+%b %d %T")
logs_simbadr=$(echo "$DATEpid, PID ( $PIDexec ), exec_file --> $APPNAME, user --> $USER, deleted ---> $IPn, from_group ---> $Gn ")
}
#
# e.g.
# del-ip-db-simbadr.sh 192.168.0.1 01



$lib_DIR"rwinfodb.sh" --delete $1 --filename $db_DIR"$2"
$lib_DIR"rwinfodb.sh" --compile $db_DIR"$2"
$lib_DIR"rwinfodb.sh" --exhibit $db_DIR"$2"
echo "IP devices registred"
$lib_DIR"rwinfodb.sh" --numberdb $db_DIR"$2"
$lib_DIR"sum-device-92.sh"
echo "$1,$2" >> $simbadr_remove_ip_only_FILE

grep -w $1 $simbadr_remove_ip_for_list_DIR*.list

echo "$1 removed from contact.list..."
sed -i '/'$1'/d' $simbadr_remove_ip_for_list_DIR"contact.list"
echo "$1 removed from hostname.list..."
sed -i '/'$1'/d' $simbadr_remove_ip_for_list_DIR"hostname.list"
echo "$1 removed from inventory.list..."
sed -i '/'$1'/d' $simbadr_remove_ip_for_list_DIR"inventory.list"
echo "$1 removed from system.list..."
sed -i '/'$1'/d' $simbadr_remove_ip_for_list_DIR"system.list"
echo "$1 removed from vendor.list..."
sed -i '/'$1'/d' $simbadr_remove_ip_for_list_DIR"vendor.list"
echo "$1 removed from network.list..."
sed -i '/'$1'/d' $simbadr_remove_ip_for_list_DIR"network.list"

IPn=$1
Gn=$2

debug_log

exit 

