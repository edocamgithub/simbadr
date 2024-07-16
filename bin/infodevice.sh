#!/bin/bash
##################################################################
#  File: infodevice.sh     Built 201902061252  
#  
#  Version: 1.2.2          Update 202312062029 
#
#  Function: Get information from host
#
#  Required: snmp libsnmp-base snmp-mibs-downloader, Perl-XML(xpath), perl v5.30.0, icmp, simbadrdb.xml
#           
#  Note: snmpd, IPv4 enable, Network configured
#
#  Copyright(c)2019-2024 Eduardo M. Araujo
#
# created by template_bash3.sh 
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.2.1"
     BUILT="2019Fev06"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2024"
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
   
# XML database from directory and filename 
localDBXML=$(simbadr-read-conf.sh -92)
filenameDBXML="simbadrdb.xml"
   
# Enable debug displayed
debugVerbose=false
#

# CommunityRO
#community="public"
community="public"

# Zero value default
# Exclusive
more_information_enable=0
version_view_enable=0     
info_oid_enable=0         
help_enable=0

# Include
ping_test_enable=0
file_name_enable=0
ip_address_enable=0
xml_output_enable=0 
text_output_enable=0 
quiet_output_enable=0 
snmp_get_info_enable=0
community_get_info_enable=0

 community_get=""
ip_address_get=""
 file_name_get=""			

# Options enable
argumentos=$@
#


# Display help
help_manual() {
echo "$APPNAME version $VERSION $COPYRIGHT
 * Get information by ICMP or SNMP testing  *

Usage: $APPNAME  <protocol [-c community]> <soucer [<filename>]> <output>

  -h, --help                            show this is information;    
  -m, --more-information                show more information;    
Protocol: 
  -p, --ping-test                       testing for 'NO SNMP enable' device or website; 
  -s, --snmp-get-info < v1 | v2 >       get information for default SNMPv1 ;
 
      -c, --community <community>       default community is public; for others community 
                                        choose a name your community;	 
   -q, --quiet                          silent mode or quiet; 
 Soucer:
   -a, --ip-address <ip>                input IP number;
   -f, --filename <filename>            define soucer filename IP list;
  Output:
    -x, --xml                           output format xml file;
    -t, --text                          output format text file;
Example:
       $APPNAME -p -a 192.168.0.1 -x  > output.txt         # Redirect for output.xml file
       $APPNAME -s --community private -f iplist.txt  -t   # Get SNMP information from iplist.txt                   
       $APPNAME --snmp-get-info --community public --test --filename iplist.txt       
       $APPNAME --ping-test --quiet --ip-address 192.168.0.1 --xml                     

$CONTACT"
      exit 0
}
#

function testbinario () {
  which $1 > /dev/null
 		if test $? -ne 0;
  			then
  				echo "     =====>  " $1 " - not found!" 
  			fi
}
#

# Log de variaveis
function log_ () {
PIDexec=$(pgrep -f $APPNAME)
DATEpid=$(date "+%b %d %T")
logs_simbadr=$(echo "$DATEpid, PID ($PIDexec), exec_file --> $APPNAME, ping_test_enable --> $ping_test_enable, snmp_get_info_enable --> $snmp_get_info_enable, snmp_get_info_enable --> $snmp_get_info_enable, community_get_info_enable --> $community_get_info_enable, community_get --> $community_get, ip_address_enable --> $ip_address_enable, ip_address_get --> $ip_address_get, file_name_enable --> $file_name_enable, file_name_get --> $file_name_get, xml_output_enable --> $xml_output_enable, text_output_enable --> $text_output_enable")
}
#

function debug_console () {
if [ $debugVerbose = true ] 
	then
		echo ""	
		echo "=== DEBUG ==="
		echo "ping_test_enable --> "$ping_test_enable
		echo ""	
		echo "     snmp_get_info_enable --> "$snmp_get_info_enable
		echo "community_get_info_enable --> "$community_get_info_enable
		echo "            community_get --> "$community_get
		echo ""
		echo "ip_address_enable --> "$ip_address_enable
		echo "   ip_address_get --> "$ip_address_get
		echo ""
		echo "file_name_enable --> "$file_name_enable
		echo "   file_name_get --> "$file_name_get
		echo ""
		echo " xml_output_enable --> "$xml_output_enable 
		echo "text_output_enable --> "$text_output_enable 
		echo "=== END ==="
		echo ""
fi
}
#

# Teste o IP digitado
function networkVerify () {
	testnetworkNow=$1
	
	octetoC=$(echo $testnetworkNow | cut -d"." -f4) 	
	octetoB=$(echo $testnetworkNow | cut -d"." -f3)
	octetoA=$(echo $testnetworkNow | cut -d"." -f2)
	
	classeA=$(echo $testnetworkNow | cut -d"." -f1-2)
	classeB=$(echo $testnetworkNow | cut -d"." -f1-3)
	classeC=$(echo $testnetworkNow | cut -d"." -f1-4)

	if test "$octetoC" = '0' 
		then
  		 echo "Rede ==> $classeC"
		else
			echo $classeC
			fi
}
#
	
info_oid () {
echo "
SNMP 

Root-Node.iso.org.dod.internet.mgmt.mib-2
         .1  .3  .6  .1       .2   .1    .

         sysDescr.0 = .1.3.6.1.2.1.1.1.0    = iso.org.dod.internet.mgmt.mib-2.system.sysDescr.0 
       sysContact.0 = .1.3.6.1.2.1.1.4.0    = iso.org.dod.internet.mgmt.mib-2.system.sysContact.0
          sysName.0 = .1.3.6.1.2.1.1.5.0    = iso.org.dod.internet.mgmt.mib-2.system.sysName.0
      sysLocation.0 = .1.3.6.1.2.1.1.6.0    = iso.org.dod.internet.mgmt.mib-2.system.sysLocation.0
   hrSystemUptime.0 = .1.3.6.1.2.1.25.1.1.0 = iso.org.dod.internet.mgmt.mib-2.25.hrSystemUptime.0
     hrSystemDate.0 = .1.3.6.1.2.1.25.1.2.0 = iso.org.dod.internet.mgmt.mib-2.25.hrSystemDate.0
 hrSystemNumUsers.0 = .1.3.6.1.2.1.25.1.5.0 = iso.org.dod.internet.mgmt.mib-2.25.hrSystemNumUsers.0
hrSystemProcesses.0 = .1.3.6.1.2.1.25.1.6.0 = iso.org.dod.internet.mgmt.mib-2.25.hrSystemProcesses.0
"
}
#

#
createFileXml () {
	echo '<?xml version="1.0" encoding="UTF-8" ?>'
}


export_xml () {
 option=$1

#headXml=$2
#if test headXml = "createFileXml"
#file_type_out=$2

if [ $option = "snmp" ]
	then
		echo "<device>"
		echo "   <time_now>$just_time</time_now>"		
		echo "   <ipadress>$ipDevice</ipadress>"		
		echo "   <hostname>$hostname_info</hostname>"
		echo '   <uptime>$time_up_info</uptime>'
		echo "   <osname>$os_name_info</osname>"
		echo "   <contact>$contact_name_info</contact>" 
		echo "   <network>"
		echo "      <tx_total>$tx_total_info</tx_total>"
		echo "      <tx_errors>$tx_errors_info</tx_errors>"
		echo "      <tx_errors>$tx_discarded_info</tx_errors>"
		echo "      <rx_total>$rx_total_info</rx_total>"
		echo "      <rx_errors>$rx_errors_info</rx_errors>"
		echo "      <rx_errors>$rx_discarded_info</rx_errors>"
		echo "   </network>"		 
		echo "</device>"
fi

if [ $option = "ping" ]
	then

      #dbxml_full_="../var/log/simbadr/blocks/01/010.xml";	   
	   find_ip_for_perl="/group/host[@id="'"'"$ipDevice"'"'"]"
	   
	   #print "$find_ip_for_perl"
   
      #select_script_perl=$(./simbadr-tr.pl  "$find_ip_for_perl"  | cut -d ":" -f "2-5")
		status_conection=$(echo "$ipDevice:$status_text:$just_time"":")	
  
	   hostname_=$(xpath -q -e $find_ip_for_perl -e 'hostname' $localDBXML$filenameDBXML) 
 	   
if [ $status_text = "ON" ]
	then	 
	   setupimg_status_=$(xpath -q -e $find_ip_for_perl -e 'setupimg/@img_status_on' $localDBXML$filenameDBXML)
		else
		setupimg_status_=$(xpath -q -e $find_ip_for_perl -e 'setupimg/@img_status_off' $localDBXML$filenameDBXML)
  fi      
  
         setup_img_os=$(xpath -q -e $find_ip_for_perl -e 'setupimg/@img_os' $localDBXML$filenameDBXML)
         setup_img_device=$(xpath -q -e $find_ip_for_perl -e 'setupimg/@img_device' $localDBXML$filenameDBXML)
           
	   depto=$(xpath -q -e $find_ip_for_perl -e 'contact/depto' $localDBXML$filenameDBXML)
        setup_img_status=$(echo $setupimg_status_ | cut -d "=" -f "2")

#problem of hostname and contact not found

if [ -z "$depto" ]
	then
			depto="<depto>null</depto>"
		fi
#        
	   echo "<host>"
	   
if test -z $hostname_info
	then
			echo "<hostname>host-$just_time</hostname>"
		else
			echo	"$hostname_"		
		fi

		echo "    <network>	    
             <ipadress>$ipDevice</ipadress>
     </network>
     <contact>	   
            $depto
     </contact>
     <connection_state>$status_text</connection_state>
     <time>$just_time</time>" 
if test -z $setup_img_device
	then
	
		if test $status_text = "OFF"
			then 
	      	echo '     <setupimg img_os="device.png" img_device="../images/devices/device.png" img_status="../images/devices/warning.png" />'
 		 		elif test $status_text = "ON"			
					then				
						echo '     <setupimg img_os="device.png" img_device="../images/devices/statusOFF.png" img_status="../images/devices/cam0.png" />'	
					fi
									
				else
				
						echo "     <setupimg"  $setup_img_os $setup_img_device img_status="$setup_img_status" "/>"
		fi 

 echo "</host>"     
fi

}
#

export_txt () {

option=$1

#file_type_out=$2

if [ $option = "snmp" ]
	then
		echo "$hostname_info:$time_up_info:$os_name_info:$tx_total_info:$tx_errors_info:$tx_discarded_info:$rx_total_info:$rx_errors_info:$rx_discarded_info"
fi
		
if [ $option = "ping" ]
	then
		echo "$ipDevice:$status_text:$just_time"
fi	
}
#


ping_test () {

#Formato da funcao
#       ping_test <formato> <origem> 
#       e.g. ping_test <txt> <file $iplist>
#
# Ex1.: ping_test xml file iplist.txt 
# Ex2.: ping_tes txt ip 192.168.0.100


exportFormat=$1
	 ipSource=$2
	 ipDevice=$3  
filename_ip_list=$3
	 
if test $ipSource = "ip"
		then	 
			statusDevice=$(ping -c1 $ipDevice >/dev/null  && echo "ON")
 			#echo $statusDevice

			if  test -z $statusDevice
   				then
 			 			status_img="$deviceHostImageOff"
						status_text="OFF"
 			  			ip_number="$ipDevice"
			  			just_time=$(date "+%s")
			 	else
						status_img="$deviceHostImageOn"
						status_text="ON"
 			  			ip_number="$ipDevice"
		     			just_time=$(date "+%s")
					fi

			if test $exportFormat = "xml"			
					then		 
						export_xml ping
						exit 0
				else
		
					if test $exportFormat = "txt"
							then
								export_txt ping
								exit 0
						fi		
					fi

	elif test $ipSource = "file"
				then
					if test -z $filename_ip_list
 	 						then
    							filename_ip_list="iptesting"
    					else
    							filename_ip_list=$3
    						fi
 
			# echo $ipSource $filename_ip_list 
 
			while read ipDevice
					do
  						statusDevice=$(ping -c1 $ipDevice >/dev/null  && echo "ON")
 						#echo $statusDevice
		
						if  test -z $statusDevice
   							then
 			 						status_img="$deviceHostImageOff"
									status_text="OFF"
 			  						ip_number="$ipDevice"
			  						just_time=$(date "+%s")
			 				else
									status_img="$deviceHostImageOn"
									status_text="ON"
 			  						ip_number="$ipDevice"
		     						just_time=$(date "+%s")
								fi

			if test $exportFormat = "xml"			
					then		 
						export_xml ping
						
				else
		
					if test $exportFormat = "txt"
							then
								export_txt ping
								
						fi		
					fi
   
done <  $filename_ip_list	
fi								
}
#

info_device () {

#Formato da funcao
#       info_device <formato [txt | xml]> <origem [file filename | ip IPv4]> 
#
# Ex1.: info_device_test xml file iplist.txt 
# Ex2.: info_device txt ip 192.168.0.100

	 exportFormat=$1
		  ipSource=$2
	 	  ipDevice=$3  
filename_ip_list=$3
	 
if test $ipSource = "ip"
		then	 
			# Hostname
					hostname_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.1.5.0)
				
					#echo "snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.1.5.0"

					hostname_info=$(echo $hostname_get | awk '{print $4}')

					#echo $hostname_info

			# Uptime
					time_up_get=$(snmpget -c $community -v1 $ipDevice  iso.3.6.1.2.1.1.3.0)
					time_up_info=$(echo $time_up_get | cut -d")" -f2 | cut -d" " -f2)
			
				echo $time_up_get

			# OS name
					os_name_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.1.1.0)
					os_name_info=$(echo $os_name_get | awk '{print $4}' )		
					
		#echo $os_name_info
		
			# Contact email/name
					contact_name_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.1.4.0)
					contact_name_info=$(echo $contact_name_get | awk '{print $4}' )
#exit 0		
					
			# Eth0 TX information
					tx_total_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.10.1)
   				tx_errors_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.12.1)
					tx_discarded_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.13.1)

    				tx_total_info=$(echo $tx_total_get | cut -d" " -f4)
   				tx_errors_info=$(echo $tx_errors_get | cut -d":" -f2 | cut -d" " -f2)
					tx_discarded_info=$(echo $tx_discarded_get | cut -d":" -f2 | cut -d" " -f2)


			# Eth0 RX information
    				rx_total_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.10.2)
   				rx_errors_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.12.2)
					rx_discarded_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.13.2)

    				rx_total_info=$(echo $rx_total_get | cut -d" " -f4)
   				rx_errors_info=$(echo $rx_errors_get | cut -d":" -f2 | cut -d" " -f2)
					rx_discarded_info=$(echo $rx_discarded_get | cut -d":" -f2 | cut -d" " -f2)
	
			
			if test $exportFormat = "xml"			
					then		 
					just_time=$(date "+%s")
						export_xml snmp
						exit 0
				else
		
					if test $exportFormat = "txt"
							then
							just_time=$(date "+%s")
								export_txt snmp
								exit 0
						fi		
					fi

	elif test $ipSource = "file"
				then
				
					if test -z $filename_ip_list
 	 					then
    						filename_ip_list="iptesting"
    						else
    							filename_ip_list=$3
    					fi
 
			# echo $ipSource $filename_ip_list 
 
					while read $ipDevice
							do
  								# Hostname
										hostname_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.1.5.0 2>/dev/null )
											
										hostname_info=$(echo $hostname_get | cut -d"\"" -f2)
							


								# Uptime
										time_up_get=$(snmpget -c $community -v1 $ipDevice  iso.3.6.1.2.1.1.3.0 2>/dev/null)
										time_up_info=$(echo $time_up_get | cut -d")" -f2 | cut -d" " -f2)

								# OS name
										os_name_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.1.1.0 2>/dev/null)
										os_name_info=$(echo $os_name_get | cut -d"\"" -f2 )
					
								# Eth0 TX information
										tx_total_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.10.1 2>/dev/null)
   									tx_errors_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.12.1 2>/dev/null)
										tx_discarded_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.13.1 2>/dev/null)

    									tx_total_info=$(echo $tx_total_get | cut -d" " -f4)
   									tx_errors_info=$(echo $tx_errors_get | cut -d":" -f2 | cut -d" " -f2)
										tx_discarded_info=$(echo $tx_discarded_get | cut -d":" -f2 | cut -d" " -f2)


								# Eth0 RX information
    									rx_total_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.10.2 2>/dev/null)
   									rx_errors_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.12.2 2>/dev/null)
										rx_discarded_get=$(snmpget -c $community -v1 $ipDevice iso.3.6.1.2.1.2.2.1.13.2 2>/dev/null)

    									rx_total_info=$(echo $rx_total_get | cut -d" " -f4)
   									rx_errors_info=$(echo $rx_errors_get | cut -d":" -f2 | cut -d" " -f2)
										rx_discarded_info=$(echo $rx_discarded_get | cut -d":" -f2 | cut -d" " -f2)
			  						

			if test $exportFormat = "xml"			
					then	
					just_time=$(date "+%s")	 
						export_xml snmp
						
				else
		
					if test $exportFormat = "txt"
							then
							just_time=$(date "+%s")
								export_txt snmp
								
						fi		
					fi
   
done <  $filename_ip_list	
fi								
}
#

info_device_workstation () {

  ip_address_or_hostname=$2

while read iphost
	do
#iphost="172.16.0.20"
# snmp v1

# nome do host
hostname_get=$(snmpget -c $community -v1 $iphost iso.3.6.1.2.1.1.5.0)
hostname_info=$(echo $hostname_get | cut -d"\"" -f2)

# tempo online
time_up_get=$(snmpget -c $community -v1 $iphost  iso.3.6.1.2.1.1.3.0)
time_up_info=$(echo $time_up_get | cut -d")" -f2 | cut -d" " -f2)

# Sistema operacional uname
os_name_get=$(snmpget -c $community -v1 $iphost iso.3.6.1.2.1.1.1.0)
os_name_info=$(echo $os_name_get | cut -d"\"" -f2 )
#os_name_info=$(echo $os_name_get)

# information eth0 TX
tx_total_get=$(snmpget -c $community -v1 $iphost iso.3.6.1.2.1.2.2.1.10.1)
   tx_errors_get=$(snmpget -c $community -v1 $iphost iso.3.6.1.2.1.2.2.1.12.1)
tx_discarded_get=$(snmpget -c $community -v1 $iphost iso.3.6.1.2.1.2.2.1.13.1)

    tx_total_info=$(echo $tx_total_get | cut -d" " -f4)
   tx_errors_info=$(echo $tx_errors_get | cut -d":" -f2 | cut -d" " -f2)
tx_discarded_info=$(echo $tx_discarded_get | cut -d":" -f2 | cut -d" " -f2)


# information eth0 RX
    rx_total_get=$(snmpget -c $community -v1 $iphost iso.3.6.1.2.1.2.2.1.10.2)
   rx_errors_get=$(snmpget -c $community -v1 $iphost iso.3.6.1.2.1.2.2.1.12.2)
rx_discarded_get=$(snmpget -c $community -v1 $iphost iso.3.6.1.2.1.2.2.1.13.2)

    rx_total_info=$(echo $rx_total_get | cut -d" " -f4)
   rx_errors_info=$(echo $rx_errors_get | cut -d":" -f2 | cut -d" " -f2)
rx_discarded_info=$(echo $rx_discarded_get | cut -d":" -f2 | cut -d" " -f2)

   #export_xml snmp
   #export_txt 

#if test -z $1
	#then
#		export_xml snmp	
#fi   

if test $1 = "txt"
	then	
		export_txt snmp
	else
		export_xml snmp
fi
  
  
done <  $ip_address_or_hostname
 }
#

groups_oid_select () {
OID_filename=0
#Root-Node.iso.org.dod.internet.mgmt.mib-2
#         .1  .3  .6  .1       .2   .1    .

#         sysDescr.0 = .1.3.6.1.2.1.1.1.0 = iso.org.dod.internet.mgmt.mib-2.system.sysDescr.0 
#       sysContact.0 = .1.3.6.1.2.1.1.4.0 = iso.org.dod.internet.mgmt.mib-2.system.sysContact.0
#          sysName.0 = .1.3.6.1.2.1.1.5.0 = iso.org.dod.internet.mgmt.mib-2.system.sysName.0
#      sysLocation.0 = .1.3.6.1.2.1.1.6.0 = iso.org.dod.internet.mgmt.mib-2.system.sysLocation.0
#   hrSystemUptime.0 = .1.3.6.1.2.1.25.1.1.0 = iso.org.dod.internet.mgmt.mib-2.25.hrSystemUptime.0
#     hrSystemDate.0 = .1.3.6.1.2.1.25.1.2.0 = iso.org.dod.internet.mgmt.mib-2.25.hrSystemDate.0
# hrSystemNumUsers.0 = .1.3.6.1.2.1.25.1.5.0 = iso.org.dod.internet.mgmt.mib-2.25.hrSystemNumUsers.0
#hrSystemProcesses.0 = .1.3.6.1.2.1.25.1.6.0 = iso.org.dod.internet.mgmt.mib-2.25.hrSystemProcesses.0

}
#

# Argumentos de linha de comando
choose () {
        #options=$argumentos

#options=$1

while test -n "$1"

do

	case "$1" in
     -p | --ping-test )
				
				ping_test_enable=1
				;;

     -s | --snmp-get-info )

	      	snmp_get_info_enable=1
	      	;;

     -c | --community )

	      	community_get_info_enable=1
				shift 
				community_get=$1      	
	      	;;

     -V | --version )
	
				version_view_enable=1
				;; 
       
     -a | --ip-address )
		
				ip_address_enable=1
				shift
				ip_address_get=$1
				;;     
           
     -f | --file-name )
			
				file_name_enable=1
				shift
				file_name_get=$1				
				;;     

     -x | --xml )
	
				xml_output_enable=1
				;; 

     -t | --text )
	
				text_output_enable=1
				;; 
		
	  -q | --quiet )
	
				quiet_output_enable=1
				;; 		
  
  	  -m| --more-information )
	
				more_information_enable=1
				;;         

     -h | --help )
       
       		help_enable=1 
       		;;

	*)
		if test -n "$1"
			then
				echo ''$APPNAME' : "'$1'" é um argumento inválido.';
				echo 'Experimente "'$APPNAME' --help" para maiores informações.';
				
		fi;;

	esac
shift
done

}
#


# Begin
# Possíveis testes  
# "snmpget" "snmptranslate" "snmpbulkwalk" "snmpbulkget" "snmpgetnext"

	testbinario "snmpwalk" 
	testbinario "snmpget"

choose $argumentos

# Apresenta as variáveis habilitadas ou atribuídas
	
	debug_console

# Teste de exclusividade e concorrencia de opções

# more_information_enable --> peso 5
#     version_view_enable --> peso 0         
#             help_enable --> peso 10

if test $help_enable -eq 1 
	then   
		help_manual
		exit 0
   else
   	if test $more_information_enable -eq 1
   		then
   			info_oid
   			exit 0
   		else
				if test $version_view_enable -eq 1     
					then
						 echo "versão: $VERSION"
						 exit 0
					 fi
			fi
	fi	
###

# ----> 
# |PROTOCOL|    COMMUNITY   |    IP ADDRESS    | FILENAME SOURCE | OUTPUT  | QUIET |
# ---------------------------------------------------------------------------------- 
# |-p | -s | -c | community |-a  | 192.168.0.1 |-f  | iplist.txt | -x | -t | -q    |
# | 0 | 1  | 1  | -n  1     | 0  | -z   0      | 1  | -n  1      | 0  | 1  |  0    | 
# | 0 | 1  | 1  | -n  1     | 0  | -z   0      | 1  | -n  1      | 1  | 0  |  0    | 
# | 0 | 1  | 1  | -n  1     | 1  | -n   1      | 0  | -z  0      | 0  | 1  |  0    | 
# | 0 | 1  | 1  | -n  1     | 1  | -n   1      | 0  | -z  0      | 1  | 0  |  0    | 
# | 1 | 0  | 0  | -z  0     | 0  | -z   0      | 1  | -n  1      | 0  | 1  |  0    | 
# | 1 | 0  | 0  | -z  0     | 0  | -z   0      | 1  | -n  1      | 1  | 0  |  0    | 
# | 1 | 0  | 0  | -z  0     | 1  | -n   1      | 0  | -z  0      | 0  | 1  |  0    | 
# | 1 | 0  | 0  | -z  0     | 1  | -n   1      | 0  | -z  0      | 1  | 0  |  0    | 


# |-p | -s | -c | community |-a  | 192.168.0.1 |-f  | iplist.txt | -x | -t | -q    |
# | 0 | 1  | 1  | -n  1     | 0  | -z   0      | 1  | -n  1      | 0  | 1  |  0    | 
if test $ping_test_enable -eq 0 && test $snmp_get_info_enable -eq 1 && test $community_get_info_enable -eq 1 && 

test -n $community_get && test $ip_address_enable -eq 0 && test -z $ip_address_get && test $file_name_enable -eq 1 && 

test -n $file_name_get && test $xml_output_enable -eq 0 && test $text_output_enable -eq 1 && test $quiet_output_enable -eq 0

		then 
			#echo "OK"
			options=$argumentos
			#echo $options
			
			info_device xml file $file_name_get
						
			exit 0
fi	

# |-p | -s | -c | community |-a  | 192.168.0.1 |-f  | iplist.txt | -x | -t | -q    |
# | 0 | 1  | 1  | -n  1     | 0  | -z   0      | 1  | -n  1      | 1  | 0  |  0    | 
if test $ping_test_enable -eq 0 && test $snmp_get_info_enable -eq 1 && test $community_get_info_enable -eq 1 && 

test -n $community_get && test $ip_address_enable -eq 0 && test -z $ip_address_get && test $file_name_enable -eq 1 && 

test -n $file_name_get && test $xml_output_enable -eq 1 && test $text_output_enable -eq 0 && test $quiet_output_enable -eq 0

		then 
			#echo "OK"
			options=$argumentos
			#echo $options
			info_device xml file $file_name_get
			#ping_test xml ip $ip_address_get
			
			exit 0
fi	


# |-p | -s | -c | community |-a  | 192.168.0.1 |-f  | iplist.txt | -x | -t | -q    |
# | 0 | 1  | 1  | -n  1     | 1  | -n   1      | 0  | -z  0      | 0  | 1  |  0    | 
if test $ping_test_enable -eq 0 && test $snmp_get_info_enable -eq 1 && test $community_get_info_enable -eq 1 && 

test -n $community_get && test $ip_address_enable -eq 1 && test -n $ip_address_get && test $file_name_enable -eq 0 && 

test -z $file_name_get && test $xml_output_enable -eq 0 && test $text_output_enable -eq 1 && test $quiet_output_enable -eq 0

		then 
			#echo "OK"
			options=$argumentos
			#echo $options
			info_device txt ip $ip_address_get
			#ping_test xml ip $ip_address_get
			
			exit 0
fi	
# |-p | -s | -c | community |-a  | 192.168.0.1 |-f  | iplist.txt | -x | -t | -q    |
# | 0 | 1  | 1  | -n  1     | 1  | -n   1      | 0  | -z  0      | 1  | 0  |  0    | 
if test $ping_test_enable -eq 0 && test $snmp_get_info_enable -eq 1 && test $community_get_info_enable -eq 1 && 

test -n $community_get && test $ip_address_enable -eq 1 && test -n $ip_address_get && test $file_name_enable -eq 0 && 

test -z $file_name_get && test $xml_output_enable -eq 1 && test $text_output_enable -eq 0 && test $quiet_output_enable -eq 0

		then 
			#echo "OK"
			options=$argumentos
			#echo $options
			info_device xml ip $ip_address_get
			#ping_test xml ip $ip_address_get
			
			exit 0
fi
# |-p | -s | -c | community |-a  | 192.168.0.1 |-f  | iplist.txt | -x | -t | -q    |	
# | 1 | 0  | 0  | -z  0     | 0  | -z   0      | 1  | -n  1      | 0  | 1  |  0    |
if test $ping_test_enable -eq 1 && test $snmp_get_info_enable -eq 0 && test $community_get_info_enable -eq 0 && 

test -z $community_get && test $ip_address_enable -eq 0 && test -z $ip_address_get && test $file_name_enable -eq 1 && 

test -n $file_name_get && test $xml_output_enable -eq 0 && test $text_output_enable -eq 1 && test $quiet_output_enable -eq 0

		then 
			#echo "OK"
			options=$argumentos
			#echo $options
			
			ping_test txt file $file_name_get

			exit 0
fi	


# |-p | -s | -c | community |-a  | 192.168.0.1 |-f  | iplist.txt | -x | -t | -q    | 
# | 1 | 0  | 0  | -z  0     | 0  | -z   0      | 1  | -n  1      | 1  | 0  |  0    | 
if test $ping_test_enable -eq 1 && test $snmp_get_info_enable -eq 0 && test $community_get_info_enable -eq 0 && 

test -z $community_get && test $ip_address_enable -eq 0 && test -z $ip_address_get && test $file_name_enable -eq 1 && 

test -n $file_name_get && test $xml_output_enable -eq 1 && test $text_output_enable -eq 0 && test $quiet_output_enable -eq 0

		then 
			#echo "OK"
			options=$argumentos
			#echo $options
			
			ping_test xml file $file_name_get

			exit 0
fi	
# |-p | -s | -c | community |-a  | 192.168.0.1 |-f  | iplist.txt | -x | -t | -q    |
# | 1 | 0  | 0  | -z  0     | 1  | -n   1      | 0  | -z  0      | 0  | 1  |  0    | 
if test $ping_test_enable -eq 1 && test $snmp_get_info_enable -eq 0 && test $community_get_info_enable -eq 0 && 

test -z $community_get && test $ip_address_enable -eq 1 && test -n $ip_address_get && test $file_name_enable -eq 0 && 

test -z $file_name_get && test $xml_output_enable -eq 0 && test $text_output_enable -eq 1 && test $quiet_output_enable -eq 0

		then 
			#echo "OK"
			options=$argumentos
			#echo $options
		
			ping_test txt ip $ip_address_get

			exit 0
fi	
# |-p | -s | -c | community |-a  | 192.168.0.1 |-f  | iplist.txt | -x | -t | -q    |
# | 1 | 0  | 0  | -z  0     | 1  | -n   1      | 0  | -z  0      | 1  | 0  |  0    | 
if test $ping_test_enable -eq 1 && test $snmp_get_info_enable -eq 0 && test $community_get_info_enable -eq 0 && 

test -z $community_get && test $ip_address_enable -eq 1 && test -n $ip_address_get && test $file_name_enable -eq 0 && 

test -z $file_name_get && test $xml_output_enable -eq 1 && test $text_output_enable -eq 0 && test $quiet_output_enable -eq 0

		then 
			#echo "OK"
			options=$argumentos
			#echo $options
			
			ping_test xml ip $ip_address_get

			exit 0
fi	


# Teste opção --> PING ou SNMP
###
if test 	$ping_test_enable -eq 1 && test $snmp_get_info_enable -eq 1 
	then
		echo "*Utilize apenas um Protocolo para comunicação.";
		echo 'Experimente "'$APPNAME' --help" para maiores informações.';
		exit 0
	fi	

# Teste opção em conflito --> IP ADDRESS ou FILENAME
###	
if test 	$ip_address_enable -eq 1 && test $file_name_enable -eq 1
	then
		echo "opções: '-a -f' são incompatíveis. Defina apenas uma única fonte.";
		echo 'Experimente "'$APPNAME' --help" para maiores informações.';
		exit 0
	fi		

# Teste opção em conflito --> XML ou TEXT
###		
if test $xml_output_enable -eq 1 && test $text_output_enable -eq 1
	then 
		echo "*Utilize para formatação -x ou -t.";
		echo 'Experimente "'$APPNAME' --help" para maiores informações.';
		exit 0
	fi
	

if test $ping_test_enable -eq 1 || test 	$snmp_get_info_enable -eq 1
	then	
		if test $xml_output_enable -eq 0 && test $text_output_enable -eq 0  
			then	
				echo "*Necessário escolher a formatação de saída.";
				echo 'Experimente "'$APPNAME' --help" para maiores informações.';
				exit 0
			fi								
	fi	
	

if test $snmp_get_info_enable -eq 1 && test $ping_test_enable -eq 0
	then   
		if test $community_get_info_enable -eq 1
 			then
				if test -z $community_get
					then
						echo "falta <comunidade>."
						exit 0
					fi
				else
				echo "necessário: -c <comunidade>."
				exit 0
			fi
fi	


###

if test 	$ping_test_enable -eq 1 && test $snmp_get_info_enable -eq 0
	then
		if test $ip_address_enable -eq 0
			then
				echo "falta a opção -a ou -f."
				exit 0
			fi
	
	else
	
	
		if test 	$ip_address_enable -eq 1
			then
				if test -z $ip_address_get
					then
						echo "falta <ip-address>."
						exit 0
						fi
			fi	

		if test 	$file_name_enable -eq 1
			then
				if test -z $file_name_get
					then
						echo "falta <file-name>."
						exit 0
						fi
					fi
	fi	

###
# networkVerify $ip_address_get
# End