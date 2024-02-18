#!/bin/bash
# Created 1 mar 2023 1119
# Write by Eduardo M. Araujo (c)2023-2024
# Function: Add new IP in selected database group.  
  
  
   echo "$ipaddress_,Registration,Other,Account,Invoice,Description or Note" 
 	  	# $baseDIR_WRITER"inventory.tmp"
   echo "$ipaddress_,Account,Phone,e-Mail" 
   	# $baseDIR_WRITER"contact.tmp"
	echo "$ipaddress_,Hostname,DeviceType" 
		# $baseDIR_WRITER"hostname.tmp"
	echo "$ipaddress_,OSName,Release,ProductKey,IdProductKey" 
		#  $baseDIR_WRITER"system.tmp"
	echo "$ipaddress_,Manufacturer,SerialNumber,Model" 
		# $baseDIR_WRITER"vendor.tmp"
   echo "$ipaddress_,00:00:00:00:00:00,eth0,127.0.0.1,11:11:11:11:11:11,wlan0,9,8,7,no" 
   	# $baseDIR_WRITER"network.tmp"