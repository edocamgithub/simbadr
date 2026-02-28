#!/bin/bash
# Created 7 nov 2021 0057
# Write by Eduardo M. Araujo (c)2021-2024


  COPYRIGHT=" (c) Eduardo M.Araujo"
       VERS="- version 0.3.0"
    APPNAME="SIMBADR UI "
DESCRIPTION="\nBasic Monitoring System for Network Device\n"

   db_DIR=$(simbadr-read-conf.sh -g)
  lib_DIR=$(simbadr-read-conf.sh -l)
   bin_DIR=$(simbadr-read-conf.sh -x)
         k=$("$lib_DIR"rinfogrp.sh -l | sed ':a;N;$!ba;s/\n/ /g') 


menuConnection="Group numbers"

menuSetup="Setup SIMBADR"
 setupVar="Edit Group Edit Device "  

menuReport="Report for Groups"

menuInstall="Install SIMBADR program"
menuMain=" "


###
infoInit ()
{
 dialog --no-shadow --title "$APPNAME$VERS"  --infobox "$DESCRIPTION" 0 0
 sleep 2
}


function testBin () {
  which $1 > /dev/null
                if test $? -ne 0;
                        then
                                echo "     =====>  " $1 " - not found!" 
                        fi
}


###
testConnection ()
{
 DIALOG_TYPE_TEST=$(dialog --backtitle "$APPNAME$VERS$COPYRIGHT" --stdout --begin 2 1 --menu "$menuConnection" 0 0 0 $k \
                    --and-widget --begin 5 35 --title SIMBADR --radiolist "Type for test" 0 0 0  ping "ICMP test" ON  snmp "SNMPv1 or SNMPv2 " OFF nmap "Ports test" OFF \
                    --and-widget --yesno "This will take some time. Do you want to continue?" 0 0 )
}
###
setupSimbadr ()
{
 DIALOG_SETUP=$(dialog --backtitle "$APPNAME$VERS$COPYRIGHT" --title "[ CONFIG ]" --stdout  --menu "$menuSetup" 0 0 0 $setupVar )
}
###
reportSimbadr ()
{
 DIALOG_REPORT=$(dialog --backtitle "$APPNAME$VERS$COPYRIGHT" --stdout --begin 2 1 --menu "$menuReport" 0 0 0 $k )
#echo $DIALOG_REPORT

#echo $lib_DIR
#"$lib_DIR"/simbadr-export-infodash.sh $DIALOG_REPORT > /tmp/simbadr/report$DIALOG_REPORT.rpt


v1=$("$lib_DIR"/simbadr-export-infodash.sh $DIALOG_REPORT  | head -n 5 | grep -v "#" )
 col1=$(echo $v1 | cut -d"," -f1)
 col2=$(echo $v1 | cut -d"," -f2)
 col3=$(echo $v1 | cut -d"," -f3)
 col4=$(echo $v1 | cut -d"," -f4)
 col5=$(echo $v1 | cut -d"," -f5)
 col6=$(echo $v1 | cut -d"," -f6 | cut -d" " -f2)
col10=$(echo $v1 | cut -d"," -f10)
col11=$(echo $v1 | cut -d"," -f11)
col12=$(echo $v1 | cut -d"," -f12)
col13=$(echo $v1 | cut -d"," -f13)
col14=$(date -d @$col13)

echo "
     Workday $col13       Devices registed total  $col6
        Time $col11                 Conected devices(online) $col4
   Timestamp $col12               Unknown devices(offline) $col5
 Last update $col14
Group Number  $col1                               Percent %  $col10
  Group Name $col2
    Basename $col3
    " >  /tmp/simbadr/report$DIALOG_REPORT.rpt

dialog --title "[ REPORT $DIALOG_REPORT ]" --textbox "/tmp/simbadr/report$DIALOG_REPORT.rpt"  0 0

}
####
formSimbadr ()
{
 DIALOG_FORM=$(dialog --backtitle "$APPNAME$VERS$COPYRIGHT" --stdout --begin 2 1 --menu "$menuForm" 0 0 0 $k )
}
###
installSimbadr ()
{
 DIALOG_INSTALL=$(case $(dialog --backtitle "$APPNAME$VERS$COPYRIGHT" --no-cancel --title "[ Installer ]" --stdout  --menu "$menuInstall" 0 0 0 \
		   Pre-install "Find dependecies" \
                   Install "Install new version" \
                   Repair "Repair files and directories" \
                   Update "Verify news updates" \
                   Quit "Exit this is program" ) in \
			Pre-install)
			 echo "1" >> /tmp/opt.txt		;;
			Install)
			  echo "2"	 >> /tmp/opt.txt	;;

			Repair)
			 echo "3"	 >> /tmp/opt.txt	;;
			Update)	
			 echo "4"	 >> /tmp/opt.txt	;;
			Quit)
			        exit 1; break	;;
			*)	
				exit	;;
		esac)	
exit
}
###
preInstall ()
{
DIALOG_PREINSTALL=$(dialog --backtitle "$APPNAME$VERS$COPYRIGHT" --gauge "Verify..." )
t_pi="[ Find Dependencies ]"
s_time=1
(echo 10; sleep $s_time) | dialog --title "$t_pi" --gauge "\nInterface Dialog" 8 40
testBin "dialog"
(echo 20; sleep $s_time) | dialog --title "$t_pi" --gauge "\nServer Apache2" 8 40
testBin "apache2"
(echo 30; sleep $s_time) | dialog --title "$t_pi" --gauge "\nServer PHP" 8 40
testBin "php"
(echo 40; sleep $s_time) | dialog --title "$t_pi" --gauge "\nPerl" 8 40
testBin "perl"
(echo 50; sleep $s_time) | dialog --title "$t_pi" --gauge "\nXpath" 8 40
testBin "xpath"
(echo 60; sleep $s_time) | dialog --title "$t_pi" --gauge "\nUtility Arp" 8 40
testBin "arp"
(echo 70; sleep $s_time) | dialog --title "$t_pi" --gauge "\nUtility Nmap" 8 40
testBin "nmap"
(echo 80; sleep $s_time) | dialog --title "$t_pi" --gauge "\nSnmp" 8 40
testBin "snmp"
(echo 90; sleep $s_time) | dialog --title "$t_pi" --gauge "\nUser simbadr created" 8 40

(echo 99; sleep $s_time) | dialog --title "$t_pi" --gauge "\nProgram Qrcode" 8 40
testBin "qrcode"

}

mainSimbadr ()
{
 DIALOG_MAIN=$(dialog --backtitle "$APPNAME$VERS$COPYRIGHT" --no-cancel --stdout  --menu "$menuMain" 0 0 0 \
                      Monitoring "Monitoring of devices" \
		      Report "Report of devies" \
                      Config "Configuring devices" Quit "Exit this is program" )
}

endSimbadr ()
{
exit
}

#MAIN
#infoInit
#mainSimbadr
#testConnection
#setupSimbadr
reportSimbadr
#formSimbadr
#installSimbadr
#preInstall



while :
do

case "$DIALOG_MAIN" in
	Monitoring)
	testConnection	;;
	Config)
	installSimbadr	;;
        Report)
        reportSimbadr	;;
	Quit)
	endSimbadr 	;;
	*)
		;;
esac
done









