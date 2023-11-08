#!/bin/bash
##################################################################
#  File: simbadr-import-db.sh 	        
#  Version: 1.1.0					 
#  Function: Import list csv for database XML 
#                   ---------------------------
#  Required: hostname.list, contact.list, inventory.list 
#            network.list, system.list, vendor.list      
#
#  Note: RUN lib/simbadr/simbadr-import-db.sh /opt/simbadr/var/log/simbadr/blocks/00/92
#                 ---------------------------
#  Written by Eduardo M. Araujo. - versão 0.0.1
#  Copyright (c)2022-2023 
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="0.0.2"
     BUILT="2022Mar07"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2022 Eduardo M. Araujo."
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG="/var/log/log_$$.log"
   TEMP_LOCAL_SIMBADR="/tmp/simbadr"

# Verifica a existenica do DIR=tmp/simbadr/
if test -d $TEMP_LOCAL_SIMBADR
	then
  		echo "/tmp/simbadr not found!" >/dev/null
	else
  		mkdir $TEMP_LOCAL_SIMBADR
	fi


#Import Files
sourceDATA="91.TXT"
baseDIR_DB=$(simbadr-read-conf.sh -92)


#
baseDIR_LIB=$(simbadr-read-conf.sh -l)
	baseDIR_=$(echo $baseDIR_LIB | cut -d "/" -f "1-3")
 baseSCRIPT=$baseDIR_"/scripts"

baseDIR_OSList=$(simbadr-read-conf.sh -s)
    filenameOS=$baseDIR_OSList"oslist.db"

baseDIR_LIB_=$(simbadr-read-conf.sh -l | cut -d "/" -f "1-5")
   backupDIR=$(simbadr-read-conf.sh -b)

echo_TEST_VARIABLES (){
	echo >/dev/null
}

echo_TEST_VARIABLES_ () {
#
clear
# lines for variables call HOST
echo "+++++++++++++++++++++++++" 
echo "#selected line with grep command, used IP for reference on finder!  "
echo "db *"
echo "1 "$device_found
echo "2 "$groupNumber_gnumber_Contact
echo "3 "$depto_Contact_
echo "-----finish ECHO variables Obj HOST"

echo "db hostname.list"
echo " 1 "$line_read_hostname
echo " 2 "$hostname_
echo " 3 "$devicetype_
echo " 4 "$equipment_id_
echo "-----finish ECHO variables Obj HOSTNAME"

echo "db vendor.list"
#echo $ipaddress_
echo "  1 "$line_read_vendor
echo "  2 "$manufacturer_
echo "  3 "$sn_
echo "  4 "$model_
echo "-----finish ECHO variables Obj VENDOR"

echo "contact.list"
#echo $ipaddress_
echo $line_read_contact

echo "   1 "$contact_owner_
echo "   2 "$contact_phone_
echo "   3 "$contact_depto_
echo "   4 "$contact_email_
echo "   5 "$contact_group_number_
echo "-----finish ECHO variables Obj CONTACT"

echo $line_read_inventory
#echo $ipaddress_
echo "    1 "$reg_inventory_
echo "    2 "$others_inventory_
echo "    3 "$accountable_
echo "    4 "$invoice_
echo "    5 "$note_
echo "-----finish ECHO variables Obj INVENTORY"


echo "db system.list"
#echo $ipaddress_
echo $line_read_system
echo "     0 "$version_System
echo "----"
echo $filenameOS
echo "     1 "$line_read_Oslist 
echo "     2 "$os_System
echo "     3 "$codename_System
echo "     4 "$osfullname_System
echo "     5 "$set_img_for_system
echo "     6 OFF "$setupimg_off_Setup
echo "     7 ON " $setupimg_on_Setup
echo "     8 "$osname_
echo "     9 "$ostype_
echo "     10 "$typebit_
echo "     11 "$osversion_
echo "     12 "$codename_
echo "     13 "$osfullname_
echo "     14 "$productkey_
echo "     15 "$productkey_ID
echo "-----finish ECHO variables Obj SYSTEM"

echo "db network.list"
#echo $ipaddress_
echo $line_read_network
echo "      1 "$network_ipaddress_Ethernet
echo "      2 "$network_mac_Ethernet
echo "      3 "$network_ipaddress_wifi_Wireless
echo "      4 "$network_mac_wifi_Wireless
echo "      5 "$network_ipaddress_Bluetooth
echo "      6 "$network_mac_Bluetooth
echo "      7 "$network_dhcp_enable_Status
echo "-----finish ECHO variables Obj NETWORK"

}



select_HOST () {
#filename: ../00/*
  	            device_found=$($baseSCRIPT/locate-ip-db-simbadr.sh $hostIPAddress)
groupNumber_gnumber_Contact=$(echo $device_found | cut -d ":" -f "2")
             depto_Contact_=$(echo $device_found | cut -d ":" -f "3")

echo_TEST_VARIABLES
}

select_HOSTNAME () {
#filename: ../92/hostname.list
#default
# hostname_="PC_Eduardo"
#devicetype_="Notebook"
#
	line_read_hostname=$(grep -w $ipaddress_ $baseDIR_DB"hostname.list")
	 hostName_Hostname=$(echo $line_read_hostname | cut -d "," -f "2")
  deviceType_Hostname=$(echo $line_read_hostname | cut -d "," -f "3")
equipment_id_Hostname=$(echo $line_read_hostname | cut -d "," -f "4")
   
	 hostname_=$hostName_Hostname
  devicetype_=$deviceType_Hostname
equipment_id_=$equipment_id_Hostname

echo_TEST_VARIABLES
}

select_VENDOR () {
#filename: ../92/vendor.list 
#default
#manufacturer_="IBM Inc."
#          sn_="0987654321"
#       model_="Personal Computer"
#
	line_read_vendor=$(grep -w $ipaddress_ $baseDIR_DB"vendor.list")
manufacturer_Vendor=$(echo $line_read_vendor | cut -d "," -f "2")
serialnumber_Vendor=$(echo $line_read_vendor | cut -d "," -f "3")
	    model_Vendor=$(echo $line_read_vendor | cut -d "," -f "4")

manufacturer_=$manufacturer_Vendor
          sn_=$serialnumber_Vendor
       model_=$model_Vendor

echo_TEST_VARIABLES
}



select_CONTACT () {
#filename: ../92/contact.list
#defaul 
contact_owner_="Eduardo"
contact_phone_="(55)21 1234-0987"
contact_depto_="sales department"
contact_email_="owner@xyz.com" 
contact_group_number_="12"
#

line_read_contact=$(grep -w $ipaddress_ $baseDIR_DB"contact.list")
 	 owner_Contact=$(echo $line_read_contact | cut -d "," -f "2")
	 phone_Contact=$(echo $line_read_contact | cut -d "," -f "3")
	 email_Contact=$(echo $line_read_contact | cut -d "," -f "4")
	 depto_Contact=$depto_Contact_

       contact_owner_=$owner_Contact
       contact_phone_=$phone_Contact
       contact_depto_=$depto_Contact 
       contact_email_=$email_Contact
contact_group_number_=$groupNumber_gnumber_Contact

echo_TEST_VARIABLES
}


select_INVENTORY () {
#filename: ../92/inventory.list
#default
#   reg_inventory_="0000987654321"
#others_inventory_="NE0000001"
#     accountable_="Carla Araujo"      
#         invoice_="purchase invoice 09877654433"
#            note_="Use this is software!"
#
  line_read_inventory=$(grep -w $ipaddress_ $baseDIR_DB"inventory.list")
   register_Inventory=$(echo $line_read_inventory | cut -d "," -f "2")
     others_Inventory=$(echo $line_read_inventory | cut -d "," -f "3")
accountable_Inventory=$(echo $line_read_inventory | cut -d "," -f "4")
    invoice_Inventory=$(echo $line_read_inventory | cut -d "," -f "5")
       note_Inventory=$(echo $line_read_inventory | cut -d "," -f "6")
description_Inventory=$(echo $line_read_inventory | cut -d "," -f "7")

   reg_inventory_=$register_Inventory
others_inventory_=$others_Inventory
     accountable_=$accountable_Inventory      
         invoice_=$invoice_Inventory
            note_=$note_Inventory
     description_=$description_Inventory

echo_TEST_VARIABLES
}   


  
select_SYSTEM () {
#filename: ../92/system.list
#default
#    osname_="Ubuntu"
#    ostype_="Linux"
#   typebit_="64bit"
# osversion_="20.04"
#  codename_="focal"
#osfullname_="Ubuntu 20.04 LTS"
#productkey_="GPL License"   
#

line_read_system=$(grep -w $ipaddress_ $baseDIR_DB"system.list")

   version_System=$(echo $line_read_system | cut -d "," -f "3")
productkey_System=$(echo $line_read_system | cut -d "," -f "4")
    productkey_ID=$(echo $line_read_system | cut -d "," -f "5")

 line_read_Oslist=$(grep -w $version_System $filenameOS)
        os_System=$(echo $line_read_Oslist | cut -d ":" -f "4")
  codename_System=$(echo $line_read_Oslist | cut -d ":" -f "3")
osfullname_System=$(echo $line_read_Oslist | cut -d ":" -f "5")
   typebit_System=$(echo $line_read_Oslist | cut -d ":" -f "6")
          os_name=$(echo $line_read_Oslist | cut -d ":" -f "1")

   #set_img_for_system=$os_System

#if [ "$os_System" = '' ] 
#	then
		set_img_for_system=$deviceType_Hostname
#	fi
  		      
case "$set_img_for_system" in
       
       AccessPoint | AP )
             setupimg_off_Setup=$($baseDIR_LIB_/getimage.sh --deviceAp 0 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
              setupimg_on_Setup=$($baseDIR_LIB_/getimage.sh --deviceAp 2 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
               setup_img_DEVICE=$($baseDIR_LIB_/getimage.sh --deviceAp 1 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')      
             ;;
             
       Desktop | desktop )
             setupimg_off_Setup=$($baseDIR_LIB_/getimage.sh --deviceHost 1 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
              setupimg_on_Setup=$($baseDIR_LIB_/getimage.sh --deviceHost 2 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
               setup_img_DEVICE=$($baseDIR_LIB_/getimage.sh --deviceHost 2 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')                
             ;;  	

       Workstation | Station | All-in-on )  
             setupimg_off_Setup=$($baseDIR_LIB_/getimage.sh --hostWorkstation 1 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
              setupimg_on_Setup=$($baseDIR_LIB_/getimage.sh --hostWorkstation 4 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
				   setup_img_DEVICE=$($baseDIR_LIB_/getimage.sh --hostWorkstation 2| cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')  
                 ;;
  
       VoIP | Phone ) 
             setupimg_off_Setup=$($baseDIR_LIB_/getimage.sh --hostPhoneIP 1 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
              setupimg_on_Setup=$($baseDIR_LIB_/getimage.sh --hostPhoneIP 2 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
               setup_img_DEVICE=$($baseDIR_LIB_/getimage.sh --hostPhoneIP 0 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')                             
             ;;
  
        Web | WWW )               
             setupimg_off_Setup=$($baseDIR_LIB_/getimage.sh --hostWeb 2 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
              setupimg_on_Setup=$($baseDIR_LIB_/getimage.sh --hostWeb 1 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')                        
               setup_img_DEVICE=$($baseDIR_LIB_/getimage.sh --hostWeb 0 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')            
             ;;              
                     
        Server | server | SERVER )
            setupimg_off_Setup=$($baseDIR_LIB_/getimage.sh --hostServer 1 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
             setupimg_on_Setup=$($baseDIR_LIB_/getimage.sh --hostServer 2 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
  				  setup_img_DEVICE=$($baseDIR_LIB_/getimage.sh --hostServer  3 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')  
            ;;
                 
        Printer | printer )            
            setupimg_off_Setup=$($baseDIR_LIB_/getimage.sh --devicePrinter 0 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
             setupimg_on_Setup=$($baseDIR_LIB_/getimage.sh --devicePrinter 5 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
              setup_img_DEVICE=$($baseDIR_LIB_/getimage.sh --devicePrinter  3 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')  
            ;;

        Switch | Hub | Router | router | hub | switch ) 
            setupimg_off_Setup=$($baseDIR_LIB_/getimage.sh --deviceSwitch 0 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
             setupimg_on_Setup=$($baseDIR_LIB_/getimage.sh --deviceSwitch 1 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
              setup_img_DEVICE=$($baseDIR_LIB_/getimage.sh --deviceSwitch 3 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')          
            ;;
            
        Cam ) 
            setupimg_off_Setup=$($baseDIR_LIB_/getimage.sh --deviceCam 0 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
             setupimg_on_Setup=$($baseDIR_LIB_/getimage.sh --deviceCam 2 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
              setup_img_DEVICE=$($baseDIR_LIB_/getimage.sh --deviceCam 1 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')  
            ;;

         Notebook | Laptop )            
             setupimg_on_Setup=$($baseDIR_LIB_/getimage.sh --hostLaptop  7 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
 				setupimg_off_Setup=$($baseDIR_LIB_/getimage.sh --hostLaptop 1 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
              setup_img_DEVICE=$($baseDIR_LIB_/getimage.sh --hostLaptop 0 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')       
            ;;

     	     *)
	         setupimg_off_Setup=$($baseDIR_LIB_/getimage.sh --deviceHost 0 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')
             setupimg_on_Setup=$($baseDIR_LIB_/getimage.sh --deviceHost 0 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')  
             setup_img_DEVICE=$($baseDIR_LIB_/getimage.sh --deviceHost 0 | cut -d ":" -f"1" | cut -d "/" -f "7-10" | sed 's/simbadr/../')     		
  		
  		      ;;  		      
  		      
esac

    osname_=$osfullname_System
    ostype_=$os_System
   typebit_=$typebit_System
 osversion_=$version_System
  codename_=$codename_System
osfullname_=$osfullname_System
productkey_=$productkey_System   

echo_TEST_VARIABLES
}
 
select_NETWORK () { 
#filename: ../92/network.list
#default
#network_ipaddress_="192.168.254.254"
#      network_mac_="00:00:00:aa:bb:cc"
        
#network_ipaddress_wifi_="192.168.254.253"
#      network_mac_wifi_="aa:bb:cc:00:00:00"
     
#network_ipaddress_bluetooth_="192.168.254.252"
#      network_mac_bluetooth_="aa:bb:cc:dd:ee:ff"
          
#network_dhcp_enable_="yes"
#
              line_read_network=$(grep -w $ipaddress_ $baseDIR_DB"network.list")
     network_ipaddress_Ethernet=$(echo $line_read_network | cut -d "," -f "1")
           network_mac_Ethernet=$(echo $line_read_network | cut -d "," -f "2")
network_ipaddress_wifi_Wireless=$(echo $line_read_network | cut -d "," -f "4")
      network_mac_wifi_Wireless=$(echo $line_read_network | cut -d "," -f "5")
    network_ipaddress_Bluetooth=$(echo $line_read_network | cut -d "," -f "7")
          network_mac_Bluetooth=$(echo $line_read_network | cut -d "," -f "8")
     network_dhcp_enable_Status=$(echo $line_read_network | cut -d "," -f "9")


          network_ipaddress_=$network_ipaddress_Ethernet
                network_mac_=$network_mac_Ethernet
        
     network_ipaddress_wifi_=$network_ipaddress_wifi_Wireless
           network_mac_wifi_=$network_mac_wifi_Wireless
     
network_ipaddress_bluetooth_=$network_ipaddress_Bluetooth
      network_mac_bluetooth_=$network_mac_Bluetooth
          
        network_dhcp_enable_=$network_dhcp_enable_Status

echo_TEST_VARIABLES
}

select_SETUPIMG () {
#filename: ../92/system.list
#default
# setupimg_on_="../images/devices/device.png"
#setupimg_off_="../images/devices/device.png"
#
 setupimg_on_=$setupimg_on_Setup
setupimg_off_=$setupimg_off_Setup

    setup_img_os=$setup_img_OS
setup_img_device=$setup_img_DEVICE
setup_img_status=$setup_img_STATUS

}


export_XML_header () {
echo "<group>" > "$TEMP_LOCAL_SIMBADR/"simbadrdb.header
}

export_XML_footer () {
echo "</group>" > "$TEMP_LOCAL_SIMBADR/"simbadrdb.footer
}

export_XML_DataBase () { 

echo " <host id="'"'$ipaddress_'"'">" >> "$TEMP_LOCAL_SIMBADR/"simbadrdb.tmp
echo "   <hostname>$hostname_</hostname>
   <device>$devicetype_</device>
   <identity>$equipment_id_</identity>        
   <vendor>
      <manufacturer>$manufacturer_</manufacturer>
      <serialnumber>$sn_</serialnumber>
      <model>$model_</model>
   </vendor>     
   <inventory>
      <register>$reg_inventory_</register>
      <others>$others_inventory_</others>
      <accountable>$accountable_</accountable>      
      <invoice>$invoice_</invoice>
      <note>$note_</note>
      <description>$description_</description>
   </inventory>
   <system>
      <os>$osname_</os>
      <bit>$typebit_</bit>
      <version>$osversion_</version>
      <codename>$codename_</codename>
      <osfullname>$osfullname_</osfullname>
      <productkey>$productkey_</productkey>
      <productkeyid>$productkey_ID</productkeyid>
   </system>         
   <contact>
      <owner>$contact_owner_</owner>
      <phone>$contact_phone_</phone>
      <depto>$contact_depto_</depto>
      <gnumber>$contact_group_number_</gnumber> 
      <email>$contact_email_</email>
   </contact>
   <network>
      <ethernet>
         <ipaddress>$network_ipaddress_</ipaddress>
         <mac>$network_mac_</mac>
      </ethernet>
      <wireless>
         <ipaddress>$network_ipaddress_wifi_</ipaddress>
         <mac>$network_mac_wifi_</mac>
      </wireless>
      <bluetooth>
         <ipaddress>$network_ipaddress_bluetooth</ipaddress>
         <mac>$network_mac_bluetooth</mac>
      </bluetooth>          
      <dhcp>$network_dhcp_enable_</dhcp>
   </network>" >> "$TEMP_LOCAL_SIMBADR/"simbadrdb.tmp
    echo "   <setupimg img_os="'"'$setup_img_os'"' "img_device="'"'$setup_img_device'"' "img_status_on="'"'$setupimg_on_'"'  "img_status_off="'"'$setupimg_off_'"'       "/>" >> "$TEMP_LOCAL_SIMBADR/"simbadrdb.tmp
  echo " </host>" >> "$TEMP_LOCAL_SIMBADR/"simbadrdb.tmp
 
}


while IFS="," read -r hostIPAddress 
do
#
#172.16.255.22,caex255-2,Server
#172.16.0.73,caex73,Desktop
#172.16.250.3,caex,Printer
#172.16.249.1,caex,VoIP
#172.16.251.79,caex,Switch
#172.16.1.203,caex1-203,Notebook
#172.16.0.11,caex11,Workstation
#172.16.255.31,caex255-031,All-in-on

ipaddress_=$hostIPAddress

#ipaddress_="172.16.251.79"
select_HOST
	select_HOSTNAME
select_VENDOR
	select_CONTACT
select_INVENTORY

	select_SYSTEM
select_NETWORK
	select_SETUPIMG

export_XML_DataBase 

done < $1


export_XML_header 
	echo "...$TEMP_LOCAL_SIMBADR/""simbadrdb.header"
export_XML_footer 
	echo "...$TEMP_LOCAL_SIMBADR/""simbadrdb.footer"


cat "$TEMP_LOCAL_SIMBADR/"simbadrdb.tmp >> "$TEMP_LOCAL_SIMBADR/"simbadrdb.header && cat "$TEMP_LOCAL_SIMBADR/"simbadrdb.footer >> "$TEMP_LOCAL_SIMBADR/"simbadrdb.header 

mv "$TEMP_LOCAL_SIMBADR/"simbadrdb.header "$TEMP_LOCAL_SIMBADR/"simbadrdb.xml 

echo "...merge simbadrdb.header + simbadrdb.tmp + simbadrdb.footer "
echo "rename simbadrdb.header for simbadrdb.xml"
# verificar
rm "$TEMP_LOCAL_SIMBADR/"simbadrdb.tmp

echo "$TEMP_LOCAL_SIMBADR/""simbadrdb.tmp and simbadrdb.footer removed ! "
# verificar
rm "$TEMP_LOCAL_SIMBADR/"simbadrdb.footer

reg_host_total=$(grep "id=" "$TEMP_LOCAL_SIMBADR/"simbadrdb.xml | wc -l)
echo "Imported $reg_host_total registers." 

 


read -p 'would you like to update the database now (yes or no)? ' choice

if [ $choice = "yes" ]
	then
	 backup_simbadrdbXML=$(date "+%s")
	 mv $baseDIR_DB"simbadrdb.xml" $backupDIR"simbadrdb."$backup_simbadrdbXML
	 cp "$TEMP_LOCAL_SIMBADR/"simbadrdb.xml $baseDIR_DB"/"
   else
    echo "The database simbadrdb.xml to be at $TEMP_LOCAL_SIMBADR/ yet! "
   	exit
   fi	




