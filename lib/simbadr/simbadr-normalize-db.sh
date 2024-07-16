#!/bin/bash
##################################################################
#  File: simbadr-import-db.sh 	        
#  Version: 0.0.1					 
#
#  Function: Import list cvs for database XML 
#                   ---------------------------
#  Required: inventory.list contact.list hostname.list system.list vendor.list network.list 
#           
#  Note: Template basead in simbadr-device-manager.sh
#                 ---------------------------
#  Copyright (c)2022-2024 Eduardo M. Araujo..
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="0.0.1"
     BUILT="2022Mar07"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2022-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG="/var/log/log_$$.log"

   baseDIR_LIB=$(simbadr-read-conf.sh -l)
      baseDIR_=$(echo $baseDIR_LIB | cut -d "/" -f "1-3")
    baseSCRIPT=$baseDIR_"/script"
    baseDIR_READER=$(simbadr-read-conf.sh -92)
    baseDIR_WRITER=$(simbadr-read-conf.sh -91)
baseDIR_GLOBAL=$(simbadr-read-conf.sh -g)
   file_GLOBAL=$(echo $baseDIR_GLOBAL"92")

#cd $baseDIR_WRITER
#rm inventory.tmp contact.tmp system.tmp vendor.tmp network.tmp hostname.tmp 



#ipaddress_=$1

while read ipaddress_
	do
		line_read_inventory=$(grep -wF $ipaddress_ $baseDIR_READER"inventory.list")
		  line_read_contact=$(grep -wF $ipaddress_ $baseDIR_READER"contact.list")
		 line_read_hostname=$(grep -wF $ipaddress_ $baseDIR_READER"hostname.list")
		   line_read_system=$(grep -wF $ipaddress_ $baseDIR_READER"system.list")
		   line_read_vendor=$(grep -wF $ipaddress_ $baseDIR_READER"vendor.list")
		  line_read_network=$(grep -wF $ipaddress_ $baseDIR_READER"network.list")

if [ "$line_read_inventory" == "" ] ; then 
	echo "Inserting into an inventory.tmp file..."
   #compare
   #file:inventory.list
   #       1 ,      2 ,    3,   4,      5,      6,  7     
   #field key,Register,Other,note,Account,Invoice,Description
  
   
   echo "$ipaddress_,Reg,Other,note,Account,Invoice,Description" >> $baseDIR_WRITER"inventory.tmp"
   	else    
		  echo  "..block/91/inventory.list --- OK!" 
	     echo $line_read_inventory  
	fi

if [ "$line_read_contact"  == "" ] ; then
   echo "Inserting into an contact.tmp file..."	
   # compare
   #file:hostname.list
   #       1 ,    2 ,   3, 4,     5,     6
   #field key,Miguel,7290,28,Switch,sw@caex.eb.mil.br     
     
   echo "$ipaddress_,Account,Phone,00,NameGroup,e-Mail" >> $baseDIR_WRITER"contact.tmp"
       else    
	    	echo "..block/91/contact.list --- OK!"
			echo $line_read_contact
	fi

if [ "$line_read_hostname" == "" ] ; then
	echo "Inserting into an hostname.tmp file..."

   #
   #file:hostname.list
   #       1 ,    2   ,    3    ,  4
   #field key,Hostname,DeviceType,IDhost     
     
   # Compare with simbad-device-manager  	
	echo "$ipaddress_,Hostname_XYZ,Device_Type,idhost" >> $baseDIR_WRITER"hostname.tmp"
       else    
 			echo "..block/91/hostname.list --- OK!"
			echo $line_read_hostname
fi

if [ "$line_read_system" == "" ] ; then
	echo "Inserting into an system.tmp file..."
	
	# Compare
	
	 #file:system.list
    #       1 ,    2 ,      3,         4,      5
    #field key,OSName,Release,ProductKey,IdProductKey
  	#
	#:172.16.251.84,Embedded_System,Emdedded,
	echo "$ipaddress_,OSName,Release,ProductKey,IdProductKey" >> $baseDIR_WRITER"system.tmp"
       else    
			echo "..block/91/system.list --- OK!"
			echo $line_read_system
fi

if [ "$line_read_vendor" == "" ] ; then
	echo "Inserting into an inventory.tmp file..."
    # Compare
    
    #file:vendor.list
    #       1 ,    2   ,    3    ,    4
    #field key,Manufacturer,Model,SerialNumber
	echo "$ipaddress_,Manufacturer,Model,SerialNumber" >> $baseDIR_WRITER"vendor.tmp"
       else    
			echo "..block/91/vendor.list --- OK!"
			echo $line_read_vendor
fi

if [ "$line_read_network" == "" ] ; then
	echo "Inserting into an  network.tmp file..."
	# compare
    #file:network.list
    #       1 ,                 2,    3,           4,                 5,     6,          7,                8,         9, 10 
    #field key, 00:11:22:00:11:22, eth0, 192.168.0.1, 11:00:22:ab:00:ff, wlan0, 1270.0.0.1,22:00:ab:00:00:11, bluetooth, y
        
   echo "$ipaddress_,00:11:a2:aa:bb:ff,eth0,127.0.0.1,00:b2:ff:a1:bf:ff,wlan0,192.168.0.1,00:aa:bb:00:11:22,bluetooth,no" >> $baseDIR_WRITER"network.tmp"
       else    
			echo "..block/91/network.list --- OK!"
			echo $line_read_network
fi

done < $1
