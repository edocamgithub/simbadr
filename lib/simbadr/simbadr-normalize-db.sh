#!/bin/bash
##################################################################
#  File: simbadr-import-db.sh 	        
#  Version: 0.0.1					 
#
#  Function: Import list cvs for database XML 
#                   ---------------------------
#  Required: inventory.list contact.list hostname.list system.list vendor.list network.list 
#           
#  Note:
#                 ---------------------------
#  Copyright (c)2022 Eduardo M. Araujo..
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="0.0.1"
     BUILT="2022Mar07"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2022 Eduardo M. Araujo."
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG="/var/log/log_$$.log"

   baseDIR_LIB=$(simbadr-read-conf.sh -l)
      baseDIR_=$(echo $baseDIR_LIB | cut -d "/" -f "1-3")
    baseSCRIPT=$baseDIR_"/script"
    baseDIR_READER=$(simbadr-read-conf.sh -92)
    baseDIR_WRITER=$(simbadr-read-conf.sh -91)
baseDIR_GLOBAL=$(simbadr-read-conf.sh -g)
   file_GLOBAL=$(echo $baseDIR_GLOBAL"92")



#ipaddress_=$1

while read ipaddress_
	do
		line_read_inventory=$(grep -w $ipaddress_ $baseDIR_READER"inventory.list")
		  line_read_contact=$(grep -w $ipaddress_ $baseDIR_READER"contact.list")
		 line_read_hostname=$(grep -w $ipaddress_ $baseDIR_READER"hostname.list")
		   line_read_system=$(grep -w $ipaddress_ $baseDIR_READER"system.list")
		   line_read_vendor=$(grep -w $ipaddress_ $baseDIR_READER"vendor.list")
		  line_read_network=$(grep -w $ipaddress_ $baseDIR_READER"network.list")

if [ "$line_read_inventory" == "" ] ; then 
	echo "Inserting into an  inventory.tmp file..."
   echo "$ipaddress_,Registration,Other,Account,Invoice,Description or Note" >> $baseDIR_WRITER"inventory.tmp"
   	else    
		  echo  "..block/91/inventory.list --- OK!" 
	     echo $line_read_inventory  
	fi

if [ "$line_read_contact"  == "" ] ; then
   echo "Inserting into an contact.tmp file..."	
   echo "$ipaddress_,Account,Phone,e-Mail" >> $baseDIR_WRITER"contact.tmp"
       else    
	    	echo "..block/91/contact.list --- OK!"
			echo $line_read_contact
	fi

if [ "$line_read_hostname" == "" ] ; then
	echo "Inserting into an hostname.tmp file..."
	echo "$ipaddress_,Hostname,DeviceType" >> $baseDIR_WRITER"hostname.tmp"
       else    
 			echo "..block/91/hostname.list --- OK!"
			echo $line_read_hostname
fi

if [ "$line_read_system" == "" ] ; then
	echo "Inserting into an system.tmp file..."
	echo "$ipaddress_,OSName,Release,ProductKey,IdProductKey" >> $baseDIR_WRITER"system.tmp"
       else    
			echo "..block/91/system.list --- OK!"
			echo $line_read_system
fi

if [ "$line_read_vendor" == "" ] ; then
	echo "Inserting into an inventory.tmp file..."
	echo "$ipaddress_,Manufacturer,SerialNumber,Model" >> $baseDIR_WRITER"vendor.tmp"
       else    
			echo "..block/91/vendor.list --- OK!"
			echo $line_read_vendor
fi

if [ "$line_read_network" == "" ] ; then
	echo "Inserting into an  inventory.tmp file..."
   echo "$ipaddress_,00:00:00:00:00:00,eth0,127.0.0.1,11:11:11:11:11:11,wlan0,9,8,7,no" >> $baseDIR_WRITER"network.tmp"
       else    
			echo "..block/91/network.list --- OK!"
			echo $line_read_network
fi

done < $1
