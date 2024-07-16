#!/bin/bash
# Created 25 feb 2024 1937 mofifyed in 20224 jun 22 1819
# (c)2024 Eduardo M. Araujo 
# Function: Add new Device for database group.

#Set up for init varibles to simbadr system 
 simbadr_export_dhcpd_conf_DIR=$(simbadr-read-conf.sh --group93)

simbadr_export_dhcpd_conf_FILE=$simbadr_export_dhcpd_conf_DIR"dhcpd.conf_list"

     simbadr_update_dblist_DIR=$(simbadr-read-conf.sh --group92)


#Setup Enviromment variables for location exec files 
   db_DIR=$(simbadr-read-conf.sh -g)
  lib_DIR=$(simbadr-read-conf.sh -l)
setup_DIR=$(simbadr-read-conf.sh -s)

#folder ../95/idhost/default.php
initScript_DIR=$(simbadr-read-conf.sh -95)



  
#Setup local XML file   
   localDBXML=$(simbadr-read-conf.sh -92)
filenameDBXML="simbadrdb.xml"
#

#Type -xml for reading xmldatabase ou void for listdatabase
 modusOp=$1
#readDB=$1


#Setup for Font Color in Display
 colorFont="\e[33;1m" #yellow
 colorFontInclude="\e[32;1m" #yellow
 colorFontSkeletor="\e["

#Setup for TempFiles   
	TEMP_LOCAL_SIMBADR="/tmp/simbadr"

#Try on for DIR=tmp/simbadr/
if test -d $TEMP_LOCAL_SIMBADR
	then
  		echo "/tmp/simbadr not found!" >/dev/null
	else
  		mkdir $TEMP_LOCAL_SIMBADR
	fi


# Begin over programs
what_is_your_Device (){
 #Old call choose_Device()
  $lib_DIR"/rinfodevice.sh" --interactive
  hostname_device=$(cat $TEMP_LOCAL_SIMBADR/rinfodevice_interactive)  
}

valid_IPhost () {
valid_ip=$1
 
  output_locator=$($lib_DIR"rwinfodb.sh" --locate $1)
numberGroupOut=$(echo $output_locator | cut -d ":" -f "2" )

echo "1: " $numberGroupOut
echo "2: " $valid_ip
echo "3: " $output_locator

if test -z $output_locator 
	then
	 addNewDevice $1
    #exit
	 	else
	                ip_locator_host_db=$(echo $output_locator | cut -d ":" -f "1"	)
			group_number_locator_host_db=$(echo $output_locator | cut -d ":" -f "2"	)
  	  		  group_name_locator_host_db=$(echo $output_locator | cut -d ":" -f "3"	)
	 
	 case "$modusOp" in
	    --debug-data )
	    	   locateHostList $ip_locator_host_db
			   locator_host_db $ip_locator_host_db;;
		 --xml-only )
		      locator_host_db $ip_locator_host_db;;
		 --list-only )
		      locateHostList $ip_locator_host_db
		      dataType="found"
		      pauseCode $dataType $valid_ip  $hostname_group_number $numberGroupOut $hostname_group_number;;
  		 * )	
	    	   locateHostList $ip_locator_host_db
	    	   dataType="found"
	    	   pauseCode  $dataType $valid_ip $hostname_group_number $numberGroupOut;;
		esac		 
	 
		fi
	
}
#

locateHostList () {
	ipDevice=$1

echo -n "Reading list database..."

   dataType="list"

#dataType="xml"
echo -n "."
#host
	hostname_list=$(grep -wF "$ipDevice" $localDBXML"/hostname.list")
		hostname_hostname=$(echo $hostname_list | cut -d "," -f "2")
   	  hostname_device=$(echo $hostname_list | cut -d "," -f "3")
           equipment_id=$(echo $hostname_list | cut -d "," -f "4")
echo -n "..."
#vendor           
	manufacturer_list=$(grep -wF "$ipDevice" $localDBXML"/vendor.list")
		 vendor_manufacturer=$(echo $manufacturer_ | cut -d "," -f "2")	   
	  	vendor_serial_number=$(echo $manufacturer_ | cut -d "," -f "3") 
	     	     vendor_model=$(echo $manufacturer_ | cut -d "," -f "4")    
echo -n "...."	     	     
#inventory
      register_=$(grep -wF  "$ipDevice" $localDBXML"/inventory.list") 
			   inventory_register=$(echo $register_ | cut -d "," -f "2" )	   
			       inventory_note=$(echo $register_ | cut -d "," -f "3" )	  		      
	   	inventory_accountable=$(echo $register_ | cut -d "," -f "4" )
			    inventory_invoice=$(echo $register_ | cut -d "," -f "5" )  
			inventory_description=$(echo $register_ | cut -d "," -f "6" )
			#inventory_others=$(echo $register_ | cut -d "," -f "3" ) 	     	     
echo -n "....."
#system
      os_=$(grep -wF  "$ipDevice" $localDBXML"/system.list")  
	     	        system_osname=$(echo $os_ | cut -d "," -f "2" )	   
	   	       system_release=$(echo $os_ | cut -d "," -f "3" )
			   system_product_key=$(echo $os_ | cut -d "," -f "4" )
			system_id_product_key=$(echo $os_ | cut -d "," -f "5" )  
echo -n "......"
#contact
		owner_=$(grep -wF  "$ipDevice" $localDBXML"/contact.list") 
		          contact_user=$(echo $owner_ | cut -d "," -f "2" )	   
	  	     	   contact_phone=$(echo $owner_ | cut -d "," -f "3" )
		 	            gnumber=$(echo $owner_ | cut -d "," -f "4" )	   	
	   	group_number_select=$(echo $owner_ | cut -d "," -f "5" )      
	   	      contact_email=$(echo $owner_ | cut -d "," -f "6" )
echo -n "......."                	   	       
#network
		#ethernet
	  	           ipaddress_=$(grep -wF  "$ipDevice" $localDBXML"/network.list") 
	  	          hostname_ip=$(echo $ipaddress_ | cut -d "," -f "1" )
	    network_mac_ethernet=$(echo $ipaddress_ | cut -d "," -f "2" )	   
	  	  network_ip_wireless=$(echo $ipaddress_ | cut -d "," -f "4" )
	    network_mac_wireless=$(echo $ipaddress_ | cut -d "," -f "5" )
		 network_ip_bluetooth=$(echo $ipaddress_ | cut -d "," -f "7" )     
		network_mac_bluetooth=$(echo $ipaddress_ | cut -d "," -f "8" )  
		   enable_dhcp_client=$(echo $ipaddress_ | cut -d "," -f "10" )  
echo -n "........"		   
#vendor	
	       manufacturer_=$(grep -wF  "$ipDevice" $localDBXML"/vendor.list")
    vendor_manufacturer=$(echo $manufacturer_ | cut -d "," -f "2" )
   	     vendor_model=$(echo $manufacturer_ | cut -d "," -f "3" )
   vendor_serial_number=$(echo $manufacturer_ | cut -d "," -f "4" )
echo -n ".........100%"
show_data_db $dataType
}

locator_host_db () {
	ipDevice=$1

 dataType="xml"

  find_ip_for_perl="/group/host[@id="'"'"$ipDevice"'"'"]"
	    
		status_conection=$(echo "$ipDevice:$status_text:$just_time"":")	

echo -n "Reading xml database..."    
echo -n ".."
#1 host
      hostname_=$(xpath -q -e $find_ip_for_perl -e 'hostname' $localDBXML$filenameDBXML) 
	   device_=$(xpath -q -e $find_ip_for_perl -e 'device' $localDBXML$filenameDBXML)
	   identity_=$(xpath -q -e $find_ip_for_perl -e 'identity' $localDBXML$filenameDBXML)

			hostname_hostname=$(echo $hostname_ | cut -d ">" -f "2" | cut -d "<" -f "1") 
	   	hostname_device=$(echo $device_ | cut -d ">" -f "2" | cut -d "<" -f "1")
      	equipment_id=$(echo $identity_ | cut -d ">" -f "2" | cut -d "<" -f "1")    	
echo -n "..."
#5 vendor	
      manufacturer_=$(xpath -q -e $find_ip_for_perl -e 'vendor/manufacturer' $localDBXML$filenameDBXML) 
	   serialnumber_=$(xpath -q -e $find_ip_for_perl -e 'vendor/serialnumber' $localDBXML$filenameDBXML)
	   model_=$(xpath -q -e $find_ip_for_perl -e 'vendor/model' $localDBXML$filenameDBXML)

			vendor_manufacturer=$(echo $manufacturer_ | cut -d ">" -f "2" | cut -d "<" -f "1")	   
	  		vendor_serial_number=$(echo $serialnumber_ | cut -d ">" -f "2" | cut -d "<" -f "1") 
	   	vendor_model=$(echo $model_ | cut -d ">" -f "2" | cut -d "<" -f "1")
echo -n "...."
#6 inventory
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

echo -n "....."
#4 system
      os_=$(xpath -q -e $find_ip_for_perl -e 'system/os' $localDBXML$filenameDBXML) 
	   version_=$(xpath -q -e $find_ip_for_perl -e 'system/version' $localDBXML$filenameDBXML)
		productkey_=$(xpath -q -e $find_ip_for_perl -e 'system/productkey' $localDBXML$filenameDBXML)
		productid_=$(xpath -q -e $find_ip_for_perl -e 'system/productkeyid' $localDBXML$filenameDBXML)

			system_osname=$(echo $os_ | cut -d ">" -f "2" | cut -d "<" -f "1")	   
	   	system_release=$(echo $version_ | cut -d ">" -f "2" | cut -d "<" -f "1")
			system_product_key=$(echo $productkey_ | cut -d ">" -f "2" | cut -d "<" -f "1")  
			system_id_product_key=$(echo $productid_ | cut -d ">" -f "2" | cut -d "<" -f "1")  
echo -n "......"
#2 contact
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
echo -n "........"
#3 network
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
echo -n ".........100%"
show_data_db $dataType 	  		 	
}

chooserOS () {
	case "$system_osname_n" in 
			"1" )
				system_osname="Ubuntu"
				read -p " Release: " system_release	;;
			"2" )
				system_osname="Windows"
				read -p " Release: " system_release
				read -p " Product Key: " system_product_key
       		read -p " ID Product Key or another: " system_id_product_key  ;;
			"3" )
				system_osname="FreeBSD"
				read -p " Release: " system_release  ;;
			"4" )
				system_osname="MacOS"
				read -p " Release: " system_release  ;;						
				*)
				system_osname="Embedded_System"
				system_release="Emdedded" 		;;
esac			
}
#


data_updating_number () {

case "$data_updating" in
		"1" )
			showDeviceConf 
			addHostnameList;;
		"2" )
			showContact
			addContactList ;;
		"3" )
			showNetwork
			addNetworkList ;;
		"4" )
			showOS 
			addSystemList ;;
		"5" )
			showVendor 
			addVendorList ;;
		"6" )
			showInventory 
			addInventoryList ;;
		"0" )
			addnew_host ;;
			*)
			exit 
			;;			
esac		
}


whatIsYourOption () {

fromCall=$1

	read -p "Is this correct information above (yes/no)?: " confirmed_update	

if [[ $confirmed_update = yes ]]
		then
		   echo "Next step!"
			else
			
case "$fromCall" in
	Hostname )
		addHostnameList ;;
	Contact )
		addContactList ;;
	Network ) 
		addNetworkList ;;
	System )
		addSystemList ;;
	Vendor )
		addVendorList ;;
	Inventory )
		addInventoryList ;;
esac

fi			
}


addHostnameList () {
echo -e "\e[m#1"
read -p " Hostname: " hostname_hostname__

if test -z $hostname_hostname__ 
	then
	 echo "!:b!"
    exit	
fi

hostname_hostname=$( printf "%.11s" $hostname_hostname__)
	what_is_your_Device
	 
##
   # /dev/random --> $RANDOM
  	hash_hostname_date=$(date +%d%m%y)	
	equipment_id="$hostname_hostname""-""$hash_hostname_date"$RANDOM
##
	
echo  -e "--------------------------------------- \n$colorFontInclude
#addHostnameList
# IP Address -->( $hostname_ip ) # Device Type --> ( $hostname_device ) 
# Hostname --> ( $hostname_hostname )  # Equipment_id --> ( $equipment_id )\e[m
\n---------------------------------------"

whatIsYourOption "Hostname"
}
#

addInventoryList () {
  echo -e "\n\e[m#6---- Document and Inventory "
  read -p "    Register: " inventory_register
  read -p "        Note: " inventory_note
  read -p " Accountable: " inventory_accountable
  read -p "     Invoice: " inventory_invoice
  read -p " Description: " inventory_description

echo  -e "--------------------------------------- \n$colorFontInclude
#addInventoryList 
# Register -->( $inventory_register ) # Note --> ( $inventory_note ) 
# Accountable --> ( $inventory_accountable )  #  Invoice --> ( $inventory_invoice )
# Description --> ( $inventory_description )\e[m
\n---------------------------------------"


whatIsYourOption "Inventory"
}
#

addVendorList () {
 echo -e "\n\e[m#5---- Vendor"
 read -p "  Manufacturer: " vendor_manufacturer
 read -p " Serial Number: " vendor_serial_number
 read -p "         Model: " vendor_model

echo  -e "--------------------------------------- \n$colorFontInclude
#addInventoryList
# Manufacturer --> ( $vendor_manufacturer )  
# Serial Number --> ( $vendor_serial_number ) 
# Model --> ( $vendor_model )\e[m
\n---------------------------------------"

whatIsYourOption "Vendor"
}
#

addContactList () {
 echo -e "\n\e[m#2---- Contact"
 read -p "   Owner/User: " contact_user
 read -p " Phone Number: " contact_phone

echo -e "\n\t\t\t\t\t [   Choose the number group:   ] \n"
$lib_DIR/simbadr-show-devices.sh -i
# list_groups=$(xpath -q -e '/groups/name' "$setup_DIR/"groups.xml | cut -d "=" -f "2" | cut -d "<" -f "1")	
echo -e $list_groups "\n"

	

 read -p " Group Number: " hostname_group_number
	group_number_select=$($lib_DIR/rinfogrp.sh -"$hostname_group_number")

 echo -e "       Depto.:" $group_number_select
 read -p "       e-Mail: " contact_email

echo  -e "---------------------------------------\n$colorFontInclude
#addContactList
# Owner/User --> ( $contact_user )
# Phone Number --> ( $contact_phone )
# The best your e-mail --> ( $contact_email )
# Group Number --> ( $hostname_group_number ) 
# Group Name/Depto. --> ( $group_number_select ) \e[m
\n---------------------------------------"

whatIsYourOption "Contact"
}
#

addNetworkList (){
 echo -e "\n\e[m#3---- Network conf"
 echo -e "Ethernet IP Address: $hostname_ip" 
	network_mac_ethernet=$(arp -a "$hostname_ip" | cut -d " " -f "4")
 
	if echo "$network_mac_ethernet" | egrep '\:' >/dev/null
		then
			echo -e "         MAC Address: $network_mac_ethernet"	
   		else
	   	read -p "         MAC Address: " network_mac_ethernet   		
		fi

  read -p " Wireless IP Address: "  network_ip_wireless
  read -p "         MAC Address: " network_mac_wireless
  read -p "Bluetooth IP Address: " network_ip_bluetooth
  read -p "        MAC Address : " network_mac_bluetooth
  read -p " DHCP Client Enabled (y/n)?: " network_dhcp
  
echo -e "---------------------------------------\n$colorFontInclude
# Ethernet IP and MAC Address -->( $hostname_ip )\t( $network_mac_ethernet ) 
# Wireless IP and MAC Address -->( $network_ip_wireless )\t( $network_mac_wireless )
# Bluetooth IP and MAC Address --> ( $network_ip_bluetooth )\t( $network_mac_bluetooth )
# DHCP Client Enabled --> ( $network_dhcp )\n \e[m
---------------------------------------"
whatIsYourOption "Network"
}
#


addSystemList () {

echo -e "\n\e[m#4\t\t\t\t[   Select the Operational System    ] \n
\t (1)Linux (2)Windows (3)FreeBSD (4)MACOS (5)Without System or Embedded System \n
---- System conf\n"


  read -p " Operational System: " system_osname_n
  chooserOS


echo -e "---------------------------------------\n$colorFontInclude
 # Operational System and Release -->( $system_osname ) ( $system_release )"

	if [  $system_osname_n = 2 ] 
		then
			echo -e "# Product Key --> ( $system_product_key )  ID Product Key or another --> ( $system_id_product_key )  "
		fi 
echo -e "\n\e[m---------------------------------------"

whatIsYourOption "System"
}
#

#Show display for information of devices
showDeviceConf () {
echo -e "\e[m #1[- DEVICE -]
\e[m    IP Address:\e[1m$colorFont $hostname_ip\t\e[m Hostname:\e[1m$colorFont $hostname_hostname\n\e[m   Device Type:\e[1m$colorFont $hostname_device\t\e[m Identity:\e[1m$colorFont $equipment_id\n"
}

showContact () {
echo -e "\e[m #2[- CONTACT -]
\e[m      User/Owner:\e[1m$colorFont $contact_user\t\e[m Depto.:\e[1m$colorFont $group_number_select\e[m PABX:\e[1m$colorFont $contact_phone 	
\e[m          E-mail:\e[1m$colorFont $contact_email\t\e[m Group Number:\e[1m$colorFont $hostname_group_number \n"
}
   	
showNetwork () {
echo -e "\e[m #3[- NETWORK SETUP -]
\e[m    Ethernet IP:\e[1m$colorFont $hostname_ip\t\e[m MAC Address:$colorFont $network_mac_ethernet 
\e[m    Wireless IP:\e[1m$colorFont $network_ip_wireless\t\e[m MAC Address:$colorFont $network_mac_wireless
\e[m   Bluetooth IP:\e[1m$colorFont $network_ip_bluetooth\t\e[m MAC Address:$colorFont $network_mac_bluetooth 
\e[m    DHCP Client:\e[1m$colorFont $network_dhcp_complete\n"
}

showOS (){
echo -e "\e[m #4[- OPERATIONAL SYSTEM -]    
\e[m          Name:\e[1m$colorFont $system_osname\t\e[m Release:$colorFont $system_release 
\e[m   Windows Key:\e[1m$colorFont $system_product_key   
\e[m    ID Product:\e[1m$colorFont $system_id_product_key\n"
}

showVendor (){
echo -e "\e[m #5[- VENDOR -] 
\e[m    Manufacturer: \e[1m$colorFont $vendor_manufacturer\t\e[m Model:\e[1m$colorFont $vendor_model\t\e[m Serial Number:\e[1m$colorFont $vendor_serial_number\n"
}

showInventory () {  
echo -e "\e[m #6[- INVENTORY -] 
\e[m      Register:\e[1m$colorFont $inventory_register
\e[m          Note:\e[1m$colorFont $inventory_note
\e[m   Accountable:\e[1m$colorFont $inventory_accountable
\e[m       Invoice:\e[1m$colorFont $inventory_invoice
\e[m   Description:\e[1m$colorFont $inventory_description\n"
}

show_data_db () {

	dataStatus=$1

case "$dataStatus" in
		"new" )
echo -e "\e[m \n\n\n  ---------------------------------------------------------------------------------------
\t\t[ New data inserted for Device ]\n"    ;;

		"xml" )
echo -e "\e[m \n\n\n-----------------------------------------------------------------------------------------
\t\t[ Information from XML Database SIMBADR ]\n"    ;;

		"list" )
echo -e "\e[m \n\n\n-----------------------------------------------------------------------------------------
\t\t[ Information from CVL Database SIMBADR ]\n"    ;;
		   	*)
			exit 
			;;			
esac		

showDeviceConf
  showContact
    showNetwork
      showOS
        showVendor  
          showInventory
echo -e "\e[m ---------------------------------------------------------------------------------------"
}
#


#Start data add for DB

Setup_db_simbadr_list () {

hostname_ip=$1
hostname_group_number=$2

# e.g.: Insert the IP number in database group
#

$lib_DIR"rwinfodb.sh" --add $hostname_ip --filename $db_DIR"$hostname_group_number"
#echo "--add IP --db"
#echo "*********"
$lib_DIR"rwinfodb.sh" --compile $db_DIR"$hostname_group_number"
#echo "--rwinfodb --compile"
#echo "*********"

$lib_DIR"rwinfodb.sh" --exhibit $db_DIR"$hostname_group_number"
echo "IP devices registred"

#echo "--exhibit rwinfodb"
#echo "*********"

$lib_DIR"rwinfodb.sh" --numberdb $db_DIR"$hostname_group_number"

#echo "--total de registros rwinfodb.sh --number"
#echo "*********"

$lib_DIR"sum-device-92.sh"

#echo "--sum-device-92"
#echo "*********"
}

UpdateAddHostnameList () {
# echo "Updating configuration of Device or Host ... #"

# filename:hostname.list 
# IP Address, HostName, DeviceType
echo "$hostname_ip,$hostname_hostname,$hostname_device,$equipment_id" >> $simbadr_update_dblist_DIR"hostname.list"   

mkdir $initScript_DIR$hostname_hostname
}

UpdateAddContactList () {
#  echo "Updating Contact..."
# filename:contact.list  
# IP Address, Owner Name, Telephone, Dept., e-mail  
# 172.16.0.2, joaoluis, (55) 55-5555-5555, Public , joao@xyz.com.br
echo "$hostname_ip,$contact_user,$contact_phone,$hostname_group_number,$group_number_select,$contact_email" >> $simbadr_update_dblist_DIR"contact.list" 

}

UpdateAddNetworkList () {
#  echo "Updating Setup Network..."
# filename:network.list
#IP Address, MAC Address, Interface Ethernet, IP Address, MAC Address, Interface Wifi, IP Address, MAC Address, Interface Bluetooth, Setup DHCP (yes|no)
echo "$hostname_ip,$network_mac_ethernet,"eth0",$network_ip_wireless,$network_mac_wireless,"wlan0",$network_ip_bluetooth,$network_mac_bluetooth,"bluetooth",$network_dhcp" >> $simbadr_update_dblist_DIR"network.list"
  
}

UpdateAddSystemList () {
#  echo "Updating System of device..."
# filename:system.list
# IP Address, Operational System FullName, Release, ProductKey, barcode
echo "$hostname_ip,$system_osname,$system_release,$system_product_key,$system_id_product_key" >> $simbadr_update_dblist_DIR"system.list"
  
}

UpdateAddVendorList () {
#  echo "Updating Vender..."

# filename: vendor.list
# IP Address, Manufacturer, Serial Number, Model 
echo "$hostname_ip,$vendor_manufacturer,$vendor_serial_number,$vendor_model" >> $simbadr_update_dblist_DIR"vendor.list"

}

UpdateAddInventoryList () {
#  echo "Updating Inventory..."
  
# filename:inventory.list
# IP Address, Register, Note, Accountable, Invoice, Description
# 172.16.1.35, 0987654, RegANe098, Marco Flavio, Not Fiscal 09898989098, NoNoNoNoNoNoNoNoNoNo
echo "$hostname_ip,$inventory_register,$inventory_note,$inventory_accountable,$inventory_invoice,$inventory_description" >> $simbadr_update_dblist_DIR"inventory.list"
  
}

addNewDevice () {
#Interface for Question about of Device

ip_locator_host_db=$1 

dataType="new"
   addHostnameList #1
      addContactList #2
         addNetworkList #3
          addSystemList #4
              addVendorList #5
                  addInventoryList #6

  show_data_db $dataType

  pauseCode $dataType $ip_locator_host_db $numberGroupOut
}
#

addnew_host () {

ipManipulation=$1
groupManipulation=$2


#Interface for DB update or new data

#echo "Interface DB"

Setup_db_simbadr_list $ipManipulation $groupManipulation

   UpdateAddHostnameList
	  UpdateAddContactList 
     	 UpdateAddNetworkList 
	      UpdateAddSystemList 
	        UpdateAddVendorList 
	          UpdateAddInventoryList 
}


#Begin Script for Device ADD or EDIT	
startDeviceAdd () {

echo -e "---- SIMBADR Database version 0.1.0 --- \n"
	#addHostnameList
	read -p " Insert IP Address: " hostname_ip

	if test -z $hostname_ip 
		then
	 		echo "B>D!"
    		exit	
		fi
		
	valid_IPhost $hostname_ip
}		

pauseCode () {
 
 	dataType=$1
hostname_ip=$2
groupNumberID=$3


#echo "@@@@@@@@@@@@@@@@@"
#echo  "dataType    HostIP          Number Group"
#echo 	$dataType , $hostname_ip , $groupNumberID
#echo $hostname_group_number
#echo  "@@@@###############"


   if [[ $dataType = "new" ]]
    	then
        read -p "Do you want insert this information in DB (yes/no)?: " confirmed_insert
       fi
   
   if [[ $dataType = "found" ]]   
       then 		     		
   		read -p "Do you want updating information above (yes/no)?: " confirmed_update 		   	            
			fi
				
             if   [[ $dataType = "found" ]] && [[ $confirmed_update = "yes" ]]
		          then

echo "#######################################################

                      * WARNNING *

--> The data will removed of DB SIMBADR  <--

Press [ENTER] to continue or Ctrl-c to CANCEL. 

########################################################"
read 


$lib_DIR"locate-ip-db-simbadr.sh" "$hostname_ip" 

groupNumberID=$($lib_DIR"locate-ip-db-simbadr.sh" "$hostname_ip")

groupNumberID_found=$(echo $groupNumberID | cut -d ":"  -f "2")


$lib_DIR"del-ip-db-simbadr.sh" "$hostname_ip" "$groupNumberID_found"

exit 0  
		                         
		            else

	          if  [[ $dataType = "new" ]]  && [[ $confirmed_insert = "yes" ]]
		          then

#echo "dataType=new and Confirmed_insert=yes"
#echo $hostname_ip
#		          echo "**************************************************************"
     
#echo $hostname_ip , $hostname_group_number             
                            			          
			          addnew_host $hostname_ip $hostname_group_number
	
			          exit 0
          		       else
				      echo "Not do!"
				           exit 0
			         fi
		           
		       
		          fi

		
exit
}


########################################

            startDeviceAdd

########################################
