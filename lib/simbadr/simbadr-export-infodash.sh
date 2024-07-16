#!/bin/bash
##################################################################
#  File: infodash.sh 	    Built: 201907110940
#  Version: 1.2.0           Update 202312062029
#
#  Function: Device calculator
#
#  Written by Eduardo M. Araujo.
##################################################################
#  Copyright (c)2019-2024 Eduardo M. Araujo
#
#  This file is part the simbadr scripts tools collections.
#
#  Required: simbadr-read-conf.sh; Access all XML files
#
#  Note: Output % and total devices on infodash.xml
# 
# created by template_bash.sh
##################################################################
   APPNAME=$(basename $0)
   VERSION="1.2.0"
     BUILT="2019Jul11"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   #AUTHLOG="/var/log/log_$$.log"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log

# Habilita a impressao de variaveis
debugVerbose=false
#

# Habilita as opcoes
argumentos=$@
#

# Diretorio de base
baseDIR=$(simbadr-read-conf.sh --global)
baseDIR_barra=$(echo $baseDIR | cut -d"/" -f1-7)
grouplocal=$(simbadr-read-conf.sh --group99)
baseDIR_LIB=$(simbadr-read-conf.sh --library)
etc_DIR=$(simbadr-read-conf.sh -s)
group_enable_list="simbadr"
output_total_device_group="92"
#

totalforsum=$(grep -wF "group_enable" /etc/simbadr/simbadr | cut -d"=" -f"2")

#Default numbers for variables reading xml files at web interface 
 somaondevice=0
somaoffdevice=0
    somatotal=0 
  #porcentagem=0
#  

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION 
$COPYRIGHT $AUTHOR
   * SUM all devices *
  
  Usage: $APPNAME <GRUPOS>
  
  OPTION:
    -h, --help         apresenta esta informação para ajuda e finaliza;
    -V, --version      mostra a versão atual;
  
   Example:
         $APPNAME 01
         $APPNAME 01 02 03 04 05 06 07
  
  $CONTACT"
      exit 0
}
#
# Debug print
function debug_console () {
if [ "$debugVerbose" = true ]
   then
echo "$APPNAME
=== begin ===
list of groups --> $listvar
total --> $totalvar
=== end ==="

fi
}
#
# Argumentos de linha de comando
choose () {
        options=$argumentos

case "$options" in
     -h | --help )
       help_manual  ;;

     -V | --version )
      echo "versão: $VERSION" ;;

	*);;
esac
}
#

exportXML () {
echo "<infodash>
   <totalgroups>"$totalvar"</totalgroups> 
   <selectedgroup>"$selectgroup"</selectedgroup>
   <sumofgroups>"$sumofgroups"</sumofgroups>
   <ondevices>"$somaondevice"</ondevices>
   <offdevices>"$somaoffdevice"</offdevices>
   <totaldevices>"$somatotal"</totaldevices> 
   <totalOnDevices>"$sumON"</totalOnDevices>
   <totalOffDevices>"$sumOFF"</totalOffDevices>
   <percentage>"$porcentagem"</percentage> 
   <lastTime>"$clocktimenow"</lastTime>
   <workday>"$workday"</workday>
</infodash>"
}

echo_variables_ () {
echo ""
#echo $baseDIR
#echo $baseDIR_barra
#echo $grouplocal
#echo $baseDIR_LIB
#echo $etc_DIR
#echo $group_enable_list
#echo $output_total_device_group
}

# Begin
choose $argumentos

#seq_group_list=$(echo $etc_DIR$group_enable_list)
 # t_group_list=$(cat $seq_group_list |  grep -wF group_enable | cut -d"=" -f2) 

listvar=$(echo $@)

#totalvar=$(echo $#) # contabilize total var

totalvar=$(cat "$etc_DIR""$group_enable_list" | grep -wF group_enable | cut -d"=" -f2 | wc -w)

#selectgroup=$(echo $#) 

selectgroup=$(echo $@ | wc -w)

#echo $selectgroup
#selectgroup="66"

path_full=$(echo "$baseDIR""$output_total_device_group") #| sort -u -n | wc -l 

sumofgroups=$(cat "$path_full" | sort  -u -n | wc -l)

debug_console $listvar $totalvar

echo  "#Group Name Device ON OFF Sum"

#echo $listvar
#echo $totalvar
#echo $selectgroup
#echo $path_full
#echo $sumofgroups
#$totalforsum

for t in $totalforsum
do
number=$t
totalON=$(grep -wF "on=" "$baseDIR_barra"/$number/$number.xml | cut -d"=" -f6 | cut -d"\"" -f2)
  totalOFF=$(grep -wF "off=" "$baseDIR_barra"/$number/$number.xml | cut -d"=" -f7 | cut -d"\"" -f2)
  
  sumON=$(echo $((totalON + sumON)))
 sumOFF=$(echo $((totalOFF + sumOFF)))
done
 
for i in $@ 
do
number=$i
#device=$("$baseDIR_LIB"rinfodevice.sh -p)

     device=$(grep typedevice "$baseDIR_barra"/$number/$number.xml | cut -d "=" -f5 | cut -d\" -f2)
      group=$("$baseDIR_LIB"rinfogrp.sh -"$number")
   ondevice=$(grep -wF "on=" "$baseDIR_barra"/$number/$number.xml | cut -d"=" -f6 | cut -d"\"" -f2)
  offdevice=$(grep -wF "off=" "$baseDIR_barra"/$number/$number.xml | cut -d"=" -f7 | cut -d"\"" -f2)
totaldevice=$(grep -wF "total=" "$baseDIR_barra"/$number/$number.xml | cut -d"=" -f8 | cut -d"\"" -f2)


echo $number, $group, $device, $ondevice, $offdevice, $totaldevice

	somaondevice=$(echo $((ondevice + somaondevice)))
	somaoffdevice=$(echo $((offdevice + somaoffdevice)))
	somatotal=$(echo $((totaldevice + somatotal)))

#echo $(($((14 * 100)) / 16)) 
#$(echo $((on_device + off_device)))

done

if test $somaondevice -eq 0 
 then
	porcentagem=0
	elif test $somaondevice -lt 0
		then 
	 		porcentagem=0
		else
			porcentagem=$(echo $(($((somaondevice * 100)) / somatotal)))	
 	fi

#just_time=$(date "+%s")
clocktimenowseconds=$(date "+%s")

#date_now=$(date "+%H:%M:%S")
clocktimenow=$(date "+%H:%M:%S")

workday=$(date "+%a %d %B %Y")
 
#echo "#Number group, On, Off, Total, %, Time, Seconds, Workday, Selected groups"
#echo  "$totalvar, $somaondevice, $somaoffdevice, $somatotal, $porcentagem, $clocktimenow, $clocktimenowseconds, $workday, $selectgroup"
echo "#|-Group-|-Devices-|-- Sub --|--------- Time --------|----------- Groups ------------|"
echo "#Selected, On, Off, Total, %, Hour, Seconds, Workday, TotalGroups, TotalON, TotalOFF "
echo  "$selectgroup, $somaondevice, $somaoffdevice, $somatotal, $porcentagem, $clocktimenow, $clocktimenowseconds, $workday, $totalvar, $sumON, $sumOFF"
exportXML
# End
