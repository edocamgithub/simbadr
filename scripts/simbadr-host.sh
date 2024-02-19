#!/bin/bash
# Created 3 may 2023 1617 update 05 jun 2023
# Write by Eduardo M. Araujo (c)2023-2024
# Function: Add new IP in selected database group.


 simbadr_export_dhcpd_conf_DIR=$(simbadr-read-conf.sh --group93)
simbadr_export_dhcpd_conf_FILE=$simbadr_export_dhcpd_conf_DIR"dhcpd.conf_list"
 simbadr_update_dblist_DIR=$(simbadr-read-conf.sh --group92)
 
   db_DIR=$(simbadr-read-conf.sh -g)
  lib_DIR=$(simbadr-read-conf.sh -l)
setup_DIR=$(simbadr-read-conf.sh -s)
 
  
  TEMP_LOCAL_SIMBADR="/tmp/simbadr"


# Banco de Dado em XML 
   localDBXML=$(simbadr-read-conf.sh -92)
filenameDBXML="simbadrdb.xml"
#

# Verifica a existenica do DIR=tmp/simbadr/
if test -d $TEMP_LOCAL_SIMBADR
	then
  		echo "/tmp/simbadr not found!" >/dev/null
	else
  		mkdir $TEMP_LOCAL_SIMBADR
	fi
#

#      
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
#

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
				system_osname="Embedded_System"
				system_release="Emdedded"
				
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



# filename:hostname.list 
# IP Address, HostName, DeviceType
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"hostname.list"
echo "$hostname_ip,$hostname_hostname,$hostname_device,$equipment_id" >> $simbadr_update_dblist_DIR"hostname.list"   

# filename:contact.list  
# IP Address, Owner Name, Telephone, Dept., e-mail  
# 172.16.0.2, joaoluis, (55) 55-5555-5555, Public , joao@xyz.com.br
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"contact.list"
echo "$hostname_ip,$contact_user,$contact_phone,$group_number_select,$contact_email" >> $simbadr_update_dblist_DIR"contact.list" 

# filename:network.list
#IP Address, MAC Address, Interface Ethernet, IP Address, MAC Address, Interface Wifi, IP Address, MAC Address, Interface Bluetooth, Setup DHCP (yes|no)
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"network.list"
echo "$hostname_ip,$network_mac_ethernet,"eth0",$network_ip_wireless,$network_mac_wireless,"wlan0",$network_ip_bluetooth,$network_mac_bluetooth,"bluetooth",$network_dhcp" >> $simbadr_update_dblist_DIR"network.list"

# filename:system.list
# IP Address, Operational System FullName, Release, ProductKey, barcode
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"system.list"
echo "$hostname_ip,$system_osname,$system_release,$system_product_key,$system_id_product_key" >> $simbadr_update_dblist_DIR"system.list"

# filename: vendor.list
# IP Address, Manufacturer, Serial Number, Model 
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"vendor.list"
echo "$hostname_ip,$vendor_manufacturer,$vendor_serial_number,$vendor_model" >> $simbadr_update_dblist_DIR"vendor.list"

# filename:inventory.list
# IP Address, Register, Note, Accountable, Invoice, Description
# 172.16.1.35, 0987654, RegANe098, Marco Flavio, Not Fiscal 09898989098, NoNoNoNoNoNoNoNoNoNo
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"inventory.list"
echo "$hostname_ip,$inventory_register,$inventory_note,$inventory_accountable,$inventory_invoice,$inventory_description" >> $simbadr_update_dblist_DIR"inventory.list"

$lib_DIR"rwinfodb.sh" --delete $hostname_ip --filename $db_DIR"$hostname_group_number"
$lib_DIR"rwinfodb.sh" --compile $db_DIR"$hostname_group_number"
#$lib_DIR"sum-device-92.sh"

$lib_DIR"rwinfodb.sh" --add $hostname_ip --filename $db_DIR"$hostname_group_number"
$lib_DIR"rwinfodb.sh" --compile $db_DIR"$hostname_group_number"
$lib_DIR"rwinfodb.sh" --exhibit $db_DIR"$hostname_group_number"
echo "IP devices registred"
$lib_DIR"rwinfodb.sh" --numberdb $db_DIR"$hostname_group_number"
$lib_DIR"sum-device-92.sh"

}




translate_group_name () {
	group_number_select=$($lib_DIR/rinfogrp.sh -"$hostname_group_number")
	case "$hostname_group_number" in
		"1" )
				hostname_group_number=01 ;;
		"2" )
				hostname_group_number=02 ;;
		"3" )
				hostname_group_number=03 ;;
		"4" )
				hostname_group_number=04 ;;
		"5" )
				hostname_group_number=05 ;;
		"6" )
				hostname_group_number=06 ;;
		"7" )
				hostname_group_number=07 ;;
		"8" )
				hostname_group_number=08 ;;
		"9" )
				hostname_group_number=09 ;;
			*)
			
			;;			
esac		
}

show_data_db () {
echo -e "\n\n\n"
echo -e "----------------------------------------------------------------------------------------------------------------------
* >>>>>>>>>>>>>>>>> Veryfied the new data for include or update SIMBADR database    

#1[ Device Config ]
	IP Address: $hostname_ip\t   Hostname: $hostname_hostname\t Device Type: $hostname_device\t   Identity: $equipment_id

#2[ Contact ]
  User/Owner: $contact_user\t 	 Phone Number: $contact_phone\t  E-mail: $contact_email
  Depto.: $group_number_select\t  Group Number: $gnumber	
  
#3[ Network Config ]
   Ethernet IP: $hostname_ip\t            MAC Address: $network_mac_ethernet 
   Wireless IP: $network_ip_wireless\t    MAC Address: $network_mac_wireless
   Bluetooth IP: $network_ip_bluetooth\t  MAC Address: $network_mac_bluetooth 
   DHCP Client: $network_dhcp_complete
  
#4[ Operational System ]    
  Name: $system_osname  Release: $system_release 
  Windows Key: $system_product_key   ID Product Key or another: $system_id_product_key 
  
#5[ Vendor ] 
  Manufacturer:  $vendor_manufacturer 	Model: $vendor_model   Serial Number: $vendor_serial_number

#6[ Inventory ] 
  Register: $inventory_register
  Note: $inventory_note
  Accountable: $inventory_accountable
  Invoice: $inventory_invoice
  Description: $inventory_description
 
-----------------------------------------------------------------------------------------------------------------------"
}


valid_host () {

valid_ip=$1

  output_locator=$($lib_DIR"rwinfodb.sh" --locate $1)

if test -z $output_locator 
	then
	 addnew_host
    exit	
	 	else
		          ip_locator_host_db=$(echo $output_locator | cut -d ":" -f "1"	)
			group_number_locator_host_db=$(echo $output_locator | cut -d ":" -f "2"	)
  	  		group_name_locator_host_db=$(echo $output_locator | cut -d ":" -f "3"	)
	
	locator_host_db $ip_locator_host_db
	
	fi

}


locator_host_db () {
	ipDevice=$1

  find_ip_for_perl="/group/host[@id="'"'"$ipDevice"'"'"]"
	    
		status_conection=$(echo "$ipDevice:$status_text:$just_time"":")	

echo "Reading database... "    
#host
      hostname_=$(xpath -q -e $find_ip_for_perl -e 'hostname' $localDBXML$filenameDBXML) 
	   device_=$(xpath -q -e $find_ip_for_perl -e 'device' $localDBXML$filenameDBXML)
	   identity_=$(xpath -q -e $find_ip_for_perl -e 'identity' $localDBXML$filenameDBXML)

			hostname_hostname=$(echo $hostname_ | cut -d ">" -f "2" | cut -d "<" -f "1") 
	   	hostname_device=$(echo $device_ | cut -d ">" -f "2" | cut -d "<" -f "1")
      	equipment_id=$(echo $identity_ | cut -d ">" -f "2" | cut -d "<" -f "1") 
#vendor	
      manufacturer_=$(xpath -q -e $find_ip_for_perl -e 'vendor/manufacturer' $localDBXML$filenameDBXML) 
	   serialnumber_=$(xpath -q -e $find_ip_for_perl -e 'vendor/serialnumber' $localDBXML$filenameDBXML)
	   model_=$(xpath -q -e $find_ip_for_perl -e 'vendor/model' $localDBXML$filenameDBXML)

			vendor_manufacturer=$(echo $manufacturer_ | cut -d ">" -f "2" | cut -d "<" -f "1")	   
	  		vendor_serial_number=$(echo $serialnumber_ | cut -d ">" -f "2" | cut -d "<" -f "1") 
	   	vendor_model=$(echo $model_ | cut -d ">" -f "2" | cut -d "<" -f "1")
#inventory
      register_=$(xpath -q -e $find_ip_for_perl -e 'inventory/register' $localDBXML$filenameDBXML) 
	   others_=$(xpath -q -e $find_ip_for_perl -e 'inventory/others' $localDBXML$filenameDBXML)
	   accountable_=$(xpath -q -e $find_ip_for_perl -e 'inventory/accountable' $localDBXML$filenameDBXML)
		invoice_=$(xpath -q -e $find_ip_for_perl -e 'inventory/invoice' $localDBXML$filenameDBXML)
		note_=$(xpath -q -e $find_ip_for_perl -e 'inventory/note' $localDBXML$filenameDBXML)
		description_=$(xpath -q -e $find_ip_for_perl -e 'inventory/description' $localDBXML$filenameDBXML)	

			inventory_register=$(echo $register_ | cut -d ">" -f "2" | cut -d "<" -f "1")	   
	  		inventory_others=$(echo $others_ | cut -d ">" -f "2" | cut -d "<" -f "1") 
	   	inventory_accountable=$(echo $accountable_ | cut -d ">" -f "2" | cut -d "<" -f "1")
			inventory_invoice=$(echo $invoice_ | cut -d ">" -f "2" | cut -d "<" -f "1")  
			inventory_note=$(echo $note_ | cut -d ">" -f "2" | cut -d "<" -f "1")
			inventory_description=$(echo $description_ | cut -d ">" -f "2" | cut -d "<" -f "1") 
#system
      os_=$(xpath -q -e $find_ip_for_perl -e 'system/os' $localDBXML$filenameDBXML) 
#	   bit_=$(xpath -q -e $find_ip_for_perl -e 'system/bit' $localDBXML$filenameDBXML)
	   version_=$(xpath -q -e $find_ip_for_perl -e 'system/version' $localDBXML$filenameDBXML)
#		codename_=$(xpath -q -e $find_ip_for_perl -e 'system/codename' $localDBXML$filenameDBXML)
#	   osfullname_=$(xpath -q -e $find_ip_for_perl -e 'system/osfullname' $localDBXML$filenameDBXML)
		productkey_=$(xpath -q -e $find_ip_for_perl -e 'system/productkey' $localDBXML$filenameDBXML)
		productid_=$(xpath -q -e $find_ip_for_perl -e 'system/productkeyid' $localDBXML$filenameDBXML)

			system_osname=$(echo $os_ | cut -d ">" -f "2" | cut -d "<" -f "1")	   
#	  		echo $bit_ | cut -d ">" -f "2" | cut -d "<" -f "1" 		 
	   	system_release=$(echo $version_ | cut -d ">" -f "2" | cut -d "<" -f "1")
			system_product_key=$(echo $productkey_ | cut -d ">" -f "2" | cut -d "<" -f "1")  
			system_id_product_key=$(echo $productid_ | cut -d ">" -f "2" | cut -d "<" -f "1")  
#contact
		owner_=$(xpath -q -e $find_ip_for_perl -e 'contact/owner' $localDBXML$filenameDBXML) 
	   phone_=$(xpath -q -e $find_ip_for_perl -e 'contact/phone' $localDBXML$filenameDBXML)
	   depto_=$(xpath -q -e $find_ip_for_perl -e 'contact/depto' $localDBXML$filenameDBXML)
		gnumber_=$(xpath -q -e $find_ip_for_perl -e 'contact/gnumber' $localDBXML$filenameDBXML)
		email_=$(xpath -q -e $find_ip_for_perl -e 'contact/email' $localDBXML$filenameDBXML)		
		
			contact_user=$(echo $owner_ | cut -d ">" -f "2" | cut -d "<" -f "1")	   
	  		contact_phone=$(echo $phone_ | cut -d ">" -f "2" | cut -d "<" -f "1") 
	   	group_number_select=$(echo $depto_ | cut -d ">" -f "2" | cut -d "<" -f "1")
			gnumber=$(echo $gnumber_ | cut -d ">" -f "2" | cut -d "<" -f "1")     
			contact_email=$(echo $email_ | cut -d ">" -f "2" | cut -d "<" -f "1")  
#network
      #ethernet
      ipaddress_=$(xpath -q -e $find_ip_for_perl -e 'network/ethernet/ipaddress' $localDBXML$filenameDBXML) 
	   mac_=$(xpath -q -e $find_ip_for_perl -e 'network/ethernet/mac' $localDBXML$filenameDBXML)

	  		hostname_ip=$(echo $ipaddress_ | cut -d ">" -f "2" | cut -d "<" -f "1")	   
	  		network_mac_ethernet=$(echo $mac_ | cut -d ">" -f "2" | cut -d "<" -f "1") 
      #wireless
      wipaddress_=$(xpath -q -e $find_ip_for_perl -e 'network/wireless/ipaddress' $localDBXML$filenameDBXML) 
 	   wmac_=$(xpath -q -e $find_ip_for_perl -e 'network/wireless/mac' $localDBXML$filenameDBXML)

	  		network_ip_wireless=$(echo $wipaddress_ | cut -d ">" -f "2" | cut -d "<" -f "1")	   
	  		network_mac_wireless=$(echo $wmac_ | cut -d ">" -f "2" | cut -d "<" -f "1")  
      #bluetooth
      bipaddress_=$(xpath -q -e $find_ip_for_perl -e 'network/bluetooth/ipaddress' $localDBXML$filenameDBXML) 
	   bmac_=$(xpath -q -e $find_ip_for_perl -e 'network/bluetooth/mac' $localDBXML$filenameDBXML)
	  	
	  		network_ip_bluetooth=$(echo $bipaddress_ | cut -d ">" -f "2" | cut -d "<" -f "1")	   
	  		network_mac_bluetooth=$(echo $bmac_ | cut -d ">" -f "2" | cut -d "<" -f "1") 
      #dhcp 
      dhcp_=$(xpath -q -e $find_ip_for_perl -e 'network/dhcp' $localDBXML$filenameDBXML)
	  		network_dhcp_complete=$(echo $dhcp_ | cut -d ">" -f "2" | cut -d "<" -f "1")	   
             
	show_data_db
}


addSystemList () {
echo -e "\n\t\t\t\t\t [   Select the Operational System:   ] \n"
echo -e "\t (1)Linux (2)Windows (3)FreeBSD (4)MACOS (5)Without System or Embedded System \n"
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

}

addNetworkList (){
echo "---- Network conf"
echo -e " Ethernet IP Address: $hostname_ip" 
	network_mac_ethernet=$(arp -a "$hostname_ip" | cut -d " " -f "4")
 

if echo "$network_mac_ethernet" | egrep '\:' >/dev/null
	then
			echo "        MAC Address: $network_mac_ethernet"	
   	else
			read -p "        MAC Address: " network_mac_ethernet   		
	fi


read -p " Wireless IP Address: "  network_ip_wireless
read -p "         MAC Address: " network_mac_wireless
read -p "Bluetooth IP Address: " network_ip_bluetooth
read -p "        MAC Address : " network_mac_bluetooth
read -p " DHCP Client Enabled (y/n)?: " network_dhcp
echo "---------------------------------------"
echo " # Ethernet IP and MAC Address -->( $hostname_ip ) ( $network_mac_ethernet )  Wireless IP and MAC Address -->( $network_ip_wireless ) ( $network_mac_wireless )"
echo " # Bluetooth IP and MAC Address --> ( $network_ip_bluetooth ) ( $network_mac_bluetooth )  DHCP Client Enabled --> ( $network_dhcp ) "
echo "---------------------------------------"

}

addInventoryList () {
echo "---- Document and Inventory "
read -p " Register: " inventory_register
read -p " Note: " inventory_note
read -p " Accountable: " inventory_accountable
read -p " Invoice: " inventory_invoice
read -p " Description: " inventory_description

}

addVendorList () {
echo "---- Vendor"
read -p " Manufacturer: " vendor_manufacturer
read -p " Serial Number: " vendor_serial_number
read -p " Model: " vendor_model

}

addHostnameList () {

echo

	read -p " Hostname: " hostname_hostname
echo -e "\n\t\t\t\t\t [   Choose the number device:   ] \n"
echo -e "\t (1)AccessPoint (2)Desktop (3)Workstation (4)Phone (5)Web (6)Server (7)Printer (8)Switch (9)Cam (0)Notebook  \n"
 
	read -p " Device Type: " hostname_device_n
		choose_Device 
echo
echo -e "\n\t\t\t\t\t [   Choose the number group:   ] \n"
 list_groups=$(xpath -q -e '/groups/name' "$setup_DIR/"groups.xml | cut -d "=" -f "2" | cut -d "<" -f "1")	
echo $list_groups
echo
	read -p " Group number: " hostname_group_number
      translate_group_name	
##
  	hash_hostname_date=$(date +%d%m%y)	
	equipment_id="$hostname_hostname""-""$hash_hostname_date"
	
echo "---------------------------------------"
echo  "# IP Address -->( $hostname_ip ) # Hostname --> ( $hostname_hostname ) # Device Type --> ( $hostname_device ) # Group Number --> ( $hostname_group_number ) # Group Name --> ( $group_number_select ) # Equipment_id --> ( $equipment_id )"
echo "---------------------------------------"

}

addContactList () {
echo "---- Contact"
read -p " Owner/User: " contact_user
read -p " Phone Number: " contact_phone
#read -p " Depto.: " contact_depto
echo " Depto.: " $group_number_select
read -p " e-Mail: " contact_email
}

#	
addnew_host () {	
	
# filename: hostname.list 
# TEMPLATE
# IP Address, HostName, DeviceType
# e.g.
# 192.168.0.1, Desktop_Adryelle, Desktop
# 192.168.0.10, Note1-1, Notebook
# 172.16.0.1, ABC, Printer

	addHostnameList

# filename: network.list
# TEMPLATE
#IP Address, MAC Address, Interface Ethernet, IP Address, MAC Address, Interface Wifi, IP Address, MAC Address, Interface Bluetooth, Setup DHCP (yes|no)
# e.g:
# 192.16.0.1,00:90:f5:94:5f:69,eth0,192.168.1.1,48:5d:60:0c:fa:d8,wlan0,0,9,8,yes

	addNetworkList

# filename: system.list
# TEMPLATE
# IP Address, Operational System FullName, Release, ProductKey, barcode
# 172.16.1.17,Microsoft Windows 10 Pro,10.0.19042, GGFKKR-LLKKIU-HMMGFT-UMMYTF, 09o9i8u7uy6t5

	addSystemList
	   
# filename: inventory.list
# TEMPLATE
# IP Address, Register, Note, Accountable, Invoice, Description
# 172.16.1.35, 0987654, RegANe098, Marco Flavio, Not Fiscal 09898989098, NoNoNoNoNoNoNoNoNoNo

	addInventoryList 

# filename: vendor.list
# TEMPLATE
# IP Address, Manufacturer, Serial Number, Model 
# 172.16.255.34, Xerox Inc., 1234567890, A001C.

	addVendorList
	
# filename: contact.list  
# TEMPLATE
# IP Address, Owner Name, Telephone, Dept., e-mail  
# 172.16.0.2, joaoluis, (55) 55-5555-5555, Public , joao@xyz.com.br

	addContactList

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


echo "----"
echo  
read -p "Is this correct information (yes/no)?: " confirmed_information
read -p "You really have sure (yes/no)?: " confirmed_information_sure 

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

show_data_db
}
#_

allUpdatingData () {
$lib_DIR"rwinfodb.sh" --delete $hostname_ip --filename $db_DIR"$hostname_group_number"
$lib_DIR"rwinfodb.sh" --compile $db_DIR"$hostname_group_number"
#$lib_DIR"sum-device-92.sh"

$lib_DIR"rwinfodb.sh" --add $hostname_ip --filename $db_DIR"$hostname_group_number"
$lib_DIR"rwinfodb.sh" --compile $db_DIR"$hostname_group_number"
$lib_DIR"rwinfodb.sh" --exhibit $db_DIR"$hostname_group_number"
echo "IP devices registred"
$lib_DIR"rwinfodb.sh" --numberdb $db_DIR"$hostname_group_number"
$lib_DIR"sum-device-92.sh"
}

showDeviceConfig_1 (){
echo -e "
#1[ Device Config ]
	IP Address: $hostname_ip\t   Hostname: $hostname_hostname\t Device Type: $hostname_device\t   Identity: $equipment_id
"
 addHostnameList
 # filename:hostname.list 
# IP Address, HostName, DeviceType
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"hostname.list"
echo "$hostname_ip,$hostname_hostname,$hostname_device,$equipment_id" >> $simbadr_update_dblist_DIR"hostname.list"   
allUpdatingData
}

showContact_2 (){
echo -e "
#2[ Contact ]
  User/Owner: $contact_user\t 	 Phone Number: $contact_phone\t  E-mail: $contact_email
  Depto.: $group_number_select\t  Group Number: $gnumber	
" 
addContactList
# filename:contact.list  
# IP Address, Owner Name, Telephone, Dept., e-mail  
# 172.16.0.2, joaoluis, (55) 55-5555-5555, Public , joao@xyz.com.br
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"contact.list"
echo "$hostname_ip,$contact_user,$contact_phone,$group_number_select,$contact_email" >> $simbadr_update_dblist_DIR"contact.list" 
allUpdatingData
}

showNetworkConfig_3 (){
echo -e  "
#3[ Network Config ]
   Ethernet IP: $hostname_ip\t            MAC Address: $network_mac_ethernet 
   Wireless IP: $network_ip_wireless\t    MAC Address: $network_mac_wireless
   Bluetooth IP: $network_ip_bluetooth\t  MAC Address: $network_mac_bluetooth 
   DHCP Client: $network_dhcp_complete
" 
addNetworkList
# filename:network.list
#IP Address, MAC Address, Interface Ethernet, IP Address, MAC Address, Interface Wifi, IP Address, MAC Address, Interface Bluetooth, Setup DHCP (yes|no)
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"network.list"
echo "$hostname_ip,$network_mac_ethernet,"eth0",$network_ip_wireless,$network_mac_wireless,"wlan0",$network_ip_bluetooth,$network_mac_bluetooth,"bluetooth",$network_dhcp" >> $simbadr_update_dblist_DIR"network.list"
allUpdatingData
}

showOperationalSystem_4 (){
echo -e "
#4[ Operational System ]    
  Name: $system_osname  Release: $system_release 
  Windows Key: $system_product_key   ID Product Key or another: $system_id_product_key 
" 
addSystemList
# filename:system.list
# IP Address, Operational System FullName, Release, ProductKey, barcode
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"system.list"
echo "$hostname_ip,$system_osname,$system_release,$system_product_key,$system_id_product_key" >> $simbadr_update_dblist_DIR"system.list"
allUpdatingData
}

showVendor_5 (){
echo -e "
#5[ Vendor ] 
  Manufacturer:  $vendor_manufacturer 	Model: $vendor_model   Serial Number: $vendor_serial_number
" 
addVendorList
# filename: vendor.list
# IP Address, Manufacturer, Serial Number, Model 
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"vendor.list"
echo "$hostname_ip,$vendor_manufacturer,$vendor_serial_number,$vendor_model" >> $simbadr_update_dblist_DIR"vendor.list"
allUpdatingData

}

showInventory_6 (){
echo -e "
#6[ Inventory ] 
  Register: $inventory_register
  Note: $inventory_note
  Accountable: $inventory_accountable
  Invoice: $inventory_invoice
  Description: $inventory_description
" 
addInventoryList 

# filename:inventory.list
# IP Address, Register, Note, Accountable, Invoice, Description
# 172.16.1.35, 0987654, RegANe098, Marco Flavio, Not Fiscal 09898989098, NoNoNoNoNoNoNoNoNoNo
sed -i '/'$hostname_ip'/d' $simbadr_update_dblist_DIR"inventory.list"
echo "$hostname_ip,$inventory_register,$inventory_note,$inventory_accountable,$inventory_invoice,$inventory_description" >> $simbadr_update_dblist_DIR"inventory.list"

allUpdatingData
}

data_updating_number () {

case "$data_updating" in
		"1" )
			showDeviceConfig_1 ;;
		"2" )
			showContact_2 ;;
		"3" )
			showNetworkConfig_3 ;;
		"4" )
			showOperationalSystem_4 ;;
		"5" )
			showVendor_5 ;;
		"6" )
			showInventory_6 ;;
		"0" )
			addnew_host ;;
			*)
			exit 
			;;			
esac		


}




#Begin
   echo -e "---- SIMBADR Database version 0.1.0 --- \n"
	read -p " Insert IP Address: " hostname_ip
	valid_host $hostname_ip
   read -p "Do you want updating information above (yes/no)?: " confirmed_update	
	if [[ $confirmed_update = yes ]]
		then
			#addnew_host
			
			read -p "What is number for data updating (1/2/3/4/5/6 or 0 for all)?: " data_updating
			
         data_updating_number  $data_updating			
         
		
			else
				exit 0
			fi	
#End