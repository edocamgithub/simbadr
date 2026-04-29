#!/bin/bash
# Created 7 nov 2021 0057
# Write by Eduardo M. Araujo (c)2021-2026


  COPYRIGHT=" (c) Eduardo M.Araujo"
       VERS="- version 0.3.0"
    APPNAME="SIMBADR UI "
DESCRIPTION="\nBasic Monitoring System for Network Device\n"
 AUTHLOG_=$(simbadr-read-conf.sh -y)
   AUTHLOG=$AUTHLOG_"00/log_$$.log"

# Verify this is directory DIR=tmp/simbadr/

   TEMP_LOCAL_SIMBADR="/tmp/simbadr"

if test -d $TEMP_LOCAL_SIMBADR
        then
                echo "/tmp/simbadr not found!" >/dev/null
        else
                mkdir $TEMP_LOCAL_SIMBADR
        fi



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
 sleep 1
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
# Group Name --> Type for test --> () () () --> Y/N   
simbadrScreen="01OP00"  


DIALOG_TYPE_TEST=$(dialog --backtitle "$APPNAME$VERS$COPYRIGHT"  --ok-label " Finder " --no-cancel --stdout --begin 2 1 --menu "$menuConnection" 0 0 0 $k 2> /tmp/simbadr/widget.txt \
                    --and-widget --begin 5 35 --title SIMBADR --radiolist "Type for test" 0 0 0  ping "ICMP test" ON  snmp "SNMPv1 or SNMPv2 " OFF nmap "Ports test" OFF 1>> /tmp/simbadr/widget.txt \
                    --and-widget --yesno "This will take some time. Do you want to continue?" 0 0 2>> /tmp/simbadr/widget.txt)

if [ $? = 1 ]
then 
mainSimbadr
else
selectClick=$(tail -n1 /tmp/simbadr/widget.txt)
echo $selectClick
exit
fi

}
###




setupSimbadr ()
{
 DIALOG_SETUP=$(dialog --backtitle "$APPNAME$VERS$COPYRIGHT" --title "[ CONFIG ]" --stdout  --menu "$menuSetup" 0 0 0 $setupVar )
}
###

getReportNow ()
{

v1=$("$lib_DIR"/simbadr-export-infodash.sh $DIALOG_REPORT  | head -n 5 | grep -v "#"  | head -n1 )
v2=$("$lib_DIR"/simbadr-export-infodash.sh $DIALOG_REPORT  | head -n 5 | grep -v "#" | tail -f -n1 )

 col1=$(echo $v1 | cut -d"," -f1)
 col2=$(echo $v1 | cut -d"," -f2)
 col3=$(echo $v1 | cut -d"," -f3)
 col4=$(echo $v1 | cut -d"," -f4)
 col5=$(echo $v1 | cut -d"," -f5)
 col6=$(echo $v1 | cut -d"," -f6)
 
col0=$(echo $v1 | cut -d"," -f7)

col8=$(echo $v2 | cut -d"," -f8)
col9=$(echo $v2 | cut -d"," -f6)



col10=$(echo $v2 | cut -d"," -f5)
col11=$(echo $v2 | cut -d"," -f11)
col12=$(echo $v2 | cut -d"," -f12)
col13=$(echo $v2 | cut -d"," -f13)

col7=$(date -d "@$col0")


echo "
      Report$col8

_______________________________________________________________________
   Last update $col7                
      
     Timestamp $col0                 

                                 Devices registed total  $col6

                              Conected devices(On-Line)  $col5

                              Unknown devices(Off-Line)  $col4
       
                                      Percent(On-Line)%  $col10

  Group Number  $col1                          

    Group Name $col2

      Basename $col3

    " >  /tmp/simbadr/report$DIALOG_REPORT.rpt

dialog --title "[ REPORT $DIALOG_REPORT ]" --textbox "/tmp/simbadr/report$DIALOG_REPORT.rpt"  0 0
}

reportSimbadr ()
{
 DIALOG_REPORT=$(dialog --backtitle "$APPNAME$VERS$COPYRIGHT" --stdout --begin 2 1 --menu "$menuReport" 0 0 0 $k )
if test $? = "1"
then 
mainSimbadr
else
getReportNow
fi
 
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
                   Back-end  "Install Server version" \
                   Client "Install graphic interface" \
                   Repair "Repair files and directories" \
                   Update "Verify updates" \
                   Quit "Exit or return" ) in \
			Pre-install)
			 echo "1" >> /tmp/opt.txt		;;
			Install)
			  echo "2"	 >> /tmp/opt.txt	;;
                        Client)
                          echo "0"        >>/tmp/opt.txt	;;
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
                      Config "Configuring devices" Quit "Exit" )
}

endSimbadr ()
{
exit
}

#MAIN
#infoInit
#mainSimbadr
testConnection
#setupSimbadr
#reportSimbadr
#formSimbadr
#installSimbadr
#preInstall



# getReportNow



while :
do

case "$DIALOG_MAIN" in
	Monitoring)
	testConnection	
  simbadrScreen="00OP01";;
	Config)
	installSimbadr	
  simbadrScreen="00OP02";;
  Report)
  reportSimbadr	
  simbadrScreen="00OP03";;
	Quit)
	endSimbadr 	
  simbadrScreen="00OP04";;
  255)
  echo "press ESC" >> /tmp/button.txt;;  
	*)
		;;
esac
done
























#                    --and-widget --begin 1 75 --title "ICMP test" --infobox   "Running communication" 0 0 ) 


#DIALOG_TYPE_TEST=$(dialog --backtitle "$APPNAME$VERS$COPYRIGHT" --stdout --begin 2 1 --menu "Group numbers" 0 0 0 $k  --and-widget --begin 5 35 --title SIMBADR --radiolist "Type for test" 0 0 0  ping "ICMP test" ON  snmp "SNMPv1 or SNMPv2 " OFF nmap "Ports test" OFF --and-widget --begin 1 75 --title "Ping test " --tailboxbg "/tmp/simbadr/test_if" 35 0 --and-widget --title "ICMP test" --infobox --no-cancel  "Running communication" 6 40 ) 


#dialog --keep-tite --stdout --title "ICMP test" --gauge "Running communication" 6 40 


exit 0

case $? in
  0) f=$("$lib_DIR"/rwinfodb.sh -n "$db_DIR"/"DIALOG_RESULT")
(echo 10; sleep 5; echo 30; sleep 5) | dialog --title "ICMP test" --gauge "Running communication" 6 40
      "$bin_DIR"start-simbadr.sh "$DIALOG_RESULT" 
      ;;
  1) echo "Cancelado"
      ;;
  255) echo "ESC pressionado";;
esac

