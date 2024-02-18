#!/bin/bash
# Created 3 may 2023 1617 update 05 jun 2023
# Write by Eduardo M. Araujo (c)2023-2024
# Function: Add new IP in selected database group.

simbadr_Lib=$(simbadr-read-conf.sh -l)
simbadr_export_dhcpd_conf_DIR=$(simbadr-read-conf.sh --group93)
simbadr_export_dhcpd_conf_FILE=$simbadr_export_dhcpd_conf_DIR"dhcpd.conf_list"
simbadr_update_dblist_DIR=$(simbadr-read-conf.sh --group92)
db_DIR=$(simbadr-read-conf.sh -g)
lib_DIR=$(simbadr-read-conf.sh -l)



      
choose_Device () {
	case "$hostname_device_n" in 
			"1" )
				hostname_device="AccessPoint"	;;
			
			"2" )
				hostname_device="Desktop" 		;;
			
			"3" )
				hostname_device="Workstation"	;;
			
			"4" )
				hostname_device="Phone"			;;
			
			"5" )
				hostname_device="Web"			;;
			
			"6" )
				hostname_device="Server"		;;
			
			"7" )
				hostname_device="Printer"		;;
			
			"8" )
				hostname_device="Switch"		;;
			
			"9" )
				hostname_device="Cam"			;;
				
			"0" )
				hostname_device="Notebook"		;;						
			
			*)
				hostname_device="Host"			;;
esac			
}

choose_OS () {
	case "$system_osname_n" in 
			"1" )
				system_osname="Ubuntu"
				read -p " Release: " system_release
			;;
			
			"2" )
				system_osname="Windows"
				read -p " Release: " system_release
				read -p " Product Key: " system_product_key
       		read -p " ID Product Key or another: " system_id_product_key
			;;
			
			"3" )
				system_osname="FreeBSD"
				read -p " Release: " system_release
			;;
					
			"4" )
				system_osname="MacOS"
				read -p " Release: " system_release
			;;						
			
			*)
				system_osname="no_operating_system"
			;;
esac			

}


export_dhcpd_conf () {
	echo "# ----------------------------------------------------------------------------------------------"
	echo "# Model: $vendor_model          SerialNumber: $vendor_serial_number   OS:$system_product_key"
	echo -e "# host $hostname_hostname\t   {hardware ethernet "$network_mac_ethernet"; fixed-address    "$hostname_ip";}"
	echo -e "# host $hostname_hostname"w"\t   {hardware ethernet "$network_mac_wireless"; fixed-address    "$network_ip_wireless";}"
	echo "# ----------------------------------------------------------------------------------------------"

}


update_db_simbadr_list () {

# e.g.: Insert the IP number in database group
# --> command IP GroupNumber
# add-ip-db-simbadr.sh 192.168.0.1 02

$lib_DIR"rwinfodb.sh" --add $hostname_ip --filename $db_DIR"$hostname_group_number"
$lib_DIR"rwinfodb.sh" --compile $db_DIR"$hostname_group_number"
$lib_DIR"rwinfodb.sh" --exhibit $db_DIR"$hostname_group_number"
echo "IP devices registred"
$lib_DIR"rwinfodb.sh" --numberdb $db_DIR"$hostname_group_number"
$lib_DIR"sum-device-92.sh"

# filename:hostname.list 
# IP Address, HostName, DeviceType
echo "$hostname_ip,$hostname_hostname,$hostname_device,$equipment_id" >> $simbadr_update_dblist_DIR"hostname.list"   

# filename:contact.list  
# IP Address, Owner Name, Telephone, Dept., e-mail  
# 172.16.0.2, joaoluis, (55) 55-5555-5555, Public , joao@xyz.com.br
echo "$hostname_ip,$contact_user,$contact_phone,$group_number_select,$contact_email" >> $simbadr_update_dblist_DIR"contact.list" 

# filename:network.list
#IP Address, MAC Address, Interface Ethernet, IP Address, MAC Address, Interface Wifi, IP Address, MAC Address, Interface Bluetooth, Setup DHCP (yes|no)
echo "$hostname_ip,$network_mac_ethernet,"eth0",$network_ip_wireless,$network_mac_wireless,"wlan0",$network_ip_bluetooth,$network_mac_bluetooth,"bluetooth",$network_dhcp" >> $simbadr_update_dblist_DIR"network.list"

# filename:system.list
# IP Address, Operational System FullName, Release, ProductKey, barcode
echo "$hostname_ip,$system_osname,$system_release,$system_product_key,$system_id_product_key" >> $simbadr_update_dblist_DIR"system.list"

# filename: vendor.list
# IP Address, Manufacturer, Serial Number, Model 
echo "$hostname_ip,$vendor_manufacturer,$vendor_serial_number,$vendor_model" >> $simbadr_update_dblist_DIR"vendor.list"

# filename:inventory.list
# IP Address, Register, Note, Accountable, Invoice, Description
# 172.16.1.35, 0987654, RegANe098, Marco Flavio, Not Fiscal 09898989098, NoNoNoNoNoNoNoNoNoNo
echo "$hostname_ip,$inventory_register,$inventory_note,$inventory_accountable,$inventory_invoice,$inventory_description" >> $simbadr_update_dblist_DIR"inventory.list"

}

translate_group_name () {
	group_number_select=$($simbadr_Lib/rinfogrp.sh -"$hostname_group_number")
}

# filename: hostname.list 
# TEMPLATE
# IP Address, HostName, DeviceType
# e.g.
# 192.168.0.1, Desktop_Adryelle, Desktop
# 192.168.0.10, Note1-1, Notebook
# 172.16.0.1, ABC, Printer

echo -e "---- SIMBADR Database version 0.1.0 --- \n"
	read -p " Insert IP Address: " hostname_ip
	read -p " Hostname: " hostname_hostname
echo -e "\n\t\t\t\t\t [   Choose number device:   ] \n"
echo -e "\t (1)AccessPoint (2)Desktop (3)Workstation (4)Phone (5)Web (6)Server (7)Printer (8)Switch (9)Cam (0)Notebook  \n"
	read -p " Device Type: " hostname_device_n
		choose_Device 
	read -p " Group number: " hostname_group_number
      translate_group_name	
##
  	hash_hostname_date=$(date +%d%m%y)	
	equipment_id="$hostname_hostname""-""$hash_hostname_date"
	
echo "---------------------------------------"
echo  "# IP Address -->( $hostname_ip ) # Hostname --> ( $hostname_hostname ) # Device Type --> ( $hostname_device ) # Group Number --> ( $hostname_group_number ) # Group Name --> ( $group_number_select ) # Equipment_id --> ( $equipment_id )"
echo "---------------------------------------"

# filename: network.list
# TEMPLATE
#IP Address, MAC Address, Interface Ethernet, IP Address, MAC Address, Interface Wifi, IP Address, MAC Address, Interface Bluetooth, Setup DHCP (yes|no)
# e.g:
# 192.16.0.1,00:90:f5:94:5f:69,eth0,192.168.1.1,48:5d:60:0c:fa:d8,wlan0,0,9,8,yes

echo "---- Network conf"
echo -e " Ethernet IP Address: $hostname_ip" 
	network_mac_ethernet=$(arp -a "$hostname_ip" | cut -d " " -f "4")




      

if echo "$network_mac_ethernet" | egrep '\:' >/dev/null
	then
			echo "        MAC Address: $network_mac_ethernet"	
   	else
			read -p "        MAC Address: " network_mac_ethernet   		
	fi


read  -p " Wireless IP Address: "  network_ip_wireless
read  -p "         MAC Address: " network_mac_wireless
read -p " Bluetooth IP Address: " network_ip_bluetooth
read -p "         MAC Address : " network_mac_bluetooth
read -p " DHCP Client Enabled (y/n)?: " network_dhcp
echo "---------------------------------------"
echo " # Ethernet IP and MAC Address -->( $hostname_ip ) ( $network_mac_ethernet )  Wireless IP and MAC Address -->( $network_ip_wireless ) ( $network_mac_wireless )"
echo " # Bluetooth IP and MAC Address --> ( $network_ip_bluetooth ) ( $network_mac_bluetooth )  DHCP Client Enabled --> ( $network_dhcp ) "
echo "---------------------------------------"

# filename: system.list
# TEMPLATE
# IP Address, Operational System FullName, Release, ProductKey, barcode
# 172.16.1.17,Microsoft Windows 10 Pro,10.0.19042, GGFKKR-LLKKIU-HMMGFT-UMMYTF, 09o9i8u7uy6t5

echo -e "\n\t\t\t\t\t [   Select Operational system:   ] \n"
echo -e "\t (1)Linux (2)Windows (3)FreeBSD (4)MACOS (5)without System \n"
echo "---- System conf"
read -p " Operational System: " system_osname_n
 choose_OS

 
echo "---------------------------------------"
echo " # Operational System and Release -->( $system_osname ) ( $system_release )"
if [  $system_osname_n = 2 ] 
	then
	echo " # Product Key --> ( $system_product_key )  ID Product Key or another --> ( $system_id_product_key ) "
fi 
echo "---------------------------------------"


# filename: inventory.list
# TEMPLATE
# IP Address, Register, Note, Accountable, Invoice, Description
# 172.16.1.35, 0987654, RegANe098, Marco Flavio, Not Fiscal 09898989098, NoNoNoNoNoNoNoNoNoNo

echo "---- Document and Inventory "
read -p " Register: " inventory_register
read -p " Note: " inventory_note
read -p " Accountable: " inventory_accountable
read -p " Invoice: " inventory_invoice
read -p " Description: " inventory_description


# filename: vendor.list
# TEMPLATE
# IP Address, Manufacturer, Serial Number, Model 
# 172.16.255.34, Xerox Inc., 1234567890, A001C.

echo "---- Vendor"
read -p " Manufacturer: " vendor_manufacturer
read -p " Serial Number: " vendor_serial_number
read -p " Model: " vendor_model

# filename: contact.list  
# TEMPLATE
# IP Address, Owner Name, Telephone, Dept., e-mail  
# 172.16.0.2, joaoluis, (55) 55-5555-5555, Public , joao@xyz.com.br

echo "---- Contact"
read -p " Owner/User: " contact_user
read -p " Phone Number: " contact_phone
#read -p " Depto.: " contact_depto
echo " Depto.: " $group_number_select
read -p " e-Mail: " contact_email


# filename: /etc/simbadr/oslist.db
# TEMPLATE
# DistributorID: Version: Codname: Generic Name: Full Name: Plataform: Distributor Name
# Ubuntu:18.04 LTS:Bionic Beaver:GNU/Linux:Ubuntu 18.04 LTS:x86:Canonical
# Windows:10:Titanium:Windows Plataform:Microsoft Windows 10 Pro:x86_64:Microsoft 
# FreeBSD:10.2:BSD:BSD/Unix:FreeBSD Server:x64:FreeBSD


if  [[ $network_dhcp = Y* ]]  ||  [[ $network_dhcp = y* ]]    
then
   network_dhcp_complete="Enable"
   network_dhcp="yes"
	else
	network_dhcp_complete="Disable"
	network_dhcp="no"
fi

echo -e "\n\n\n"
echo -e "---------------------------------------------------------------------------------------------------------
* Veryfied the new data for SIMBADR database  

# Device Config 
  IP Address: $hostname_ip\t   Hostname:  $hostname_hostname\t Device Type: $hostname_device\t   Identity: $equipment_id

# Contact
  User/Owner: $contact_user 	Phone Numeber: $contact_phone Depto.: $group_number_select	 E-mail: $contact_email
  
# Network Config
   Ethernet IP: $hostname_ip\t           MAC Address: $network_mac_ethernet 
   Wireless IP: $network_ip_wireless\t   MAC Address: $network_mac_wireless
  Bluetooth IP: $network_ip_bluetooth\t  MAC Address: $network_mac_bluetooth 
   DHCP Client: $network_dhcp_complete
  
# Operational System    
  Name: $system_osname  Release: $system_release 
  Windows Key: $system_product_key   ID Product Key or another: $system_id_product_key 
  
# Vendor 
  Manufacturer:  $vendor_manufacturer 	Model: $vendor_model   Serial Number: $vendor_serial_number

# Inventory  
  Register: $inventory_register
  Note: $inventory_note
  Accountable: $inventory_accountable
  Invoice: $inventory_invoice
  Description: $inventory_description
 
---------------------------------------------------------------------------------------------------------"

read -p "Is this correct information? (yes/no):" confirmed_information
read -p "You really have sure? (yes/no):" confirmed_information_sure 

if  [[ $confirmed_information = yes ]]  &&  [[ $confirmed_information_sure = yes ]]    
then
    	update_db_simbadr_list

	if  [[ $network_dhcp = Y* ]]  ||  [[ $network_dhcp = y* ]]    
		then
			export_dhcpd_conf >> $simbadr_export_dhcpd_conf_FILE
			echo "exported $simbadr_export_dhcpd_conf_FILE"
	fi

		else
	exit
fi




