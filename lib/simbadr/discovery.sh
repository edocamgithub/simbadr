#!/bin/bash
##################################################################
#  File: discovery.sh 	       Built: 201909240925
#  Version: 1.0.2              Update 202312062029
#
#  Function: list host with status ON    
#
##################################################################
#  Copyright (c)2019-2024 Eduardo M. Araujo..
#
#  This file is part the  simbadr scripts tools collections.
#
#  Required: infodevice.sh; simbadr-read-conf.sh 
#
#  Note: Output file, warning.xml, /tmp/simbadr*, global/00/00  
#  
#                   ---------------------------
#
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2019Set24"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log
   TEMP_LOCAL_SIMBADR="/tmp/simbadr/"

# Habilita a impressao de variaveis
debugVisible=false
#

# Habilita as opcoes
argumentos=$@
#

# Diretorio de base
baseDIR=$(simbadr-read-conf.sh --global)
baseDIR_barra=$(echo $baseDIR | cut -d"/" -f1-7)
baseDIR_LIB=$(simbadr-read-conf.sh --library)
baseExec=$(simbadr-read-conf.sh --exec)

globalDir=$(simbadr-read-conf.sh --global)
globalFile="00"
#

# Log de variaveis

function log_ () {
PIDexec=$(pgrep -f $APPNAME)
DATEpid=$(date "+%b %d %T")
logs_simbadr=$(echo "PID ($PIDexec), exec_file --> $APPNAME, file_in_discovery_tmp --> $file_in_discovery_tmp, file_in_discovery_tmp_grep --> $file_in_discovery_tmp_grep, globalDir --> $globalDir, globalFile --> $globalFile")  
}
#

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION 
$COPYRIGHT $AUTHOR
    * Find Host list IP named  *

Usage: $APPNAME  <network>  

OPTION:
  -h, --help        show this is information;
  -V, --version     show version number;
  
Example:
   $APPNAME                # 
   $APPNAME 192.168.0.     # for sequence 192.168.0.1..254                             
                             
$CONTACT"
      exit 0
}
#
# Debug print

function debug_log ()
{
if [ $debugVisible = true ]
	then
		echo $logs_simbadr     	
		echo $logs_simbadr  >> $AUTHLOG 2>> $AUTHLOG
		else
			echo $logs_simbadr  >> $AUTHLOG 2>> $AUTHLOG
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

     -s | --ip-address )
      echo "origem do ip" ;;

	*);;
esac
}
#
# Argumentos de linha de comando
choose_ () {
while test -n "$1"
do
   case "$1" in
     -p | --ping-test )
            ping_test_enable=1
            ;;

     -c | --community )
            community_get_info_enable=1
            shift
            community_get=$1
            ;;

      -h | --help )
             help_enable=1
             ;;

                 *)
            if test -n "$1"
               then
                   echo $APPNAME  :  "$1"  é um argumento inválido.;
                   echo Experimente "$APPNAME" --help para maiores informações.; 
               fi;;
   esac
       shift
done
}
#

#
function startLog () {
	datelog=$(date "+%h %d-%m-%Y %H:%M:%S")
	pidlog=$(pgrep $APPNAME | tail -n1 )

echo "<warning>
    <line1>'>'</line1>
    <line2>Starting task...</line2>
    <line3>Running script!</line3>
    <line4>Creating a IP list...</line4>  
    <line5>Discovering devices...</line5> 
</warning>" > "$grouplocal"warning.xml

   
	echo $datelog PID[$pidlog] $APPNAME"> Starting task..." >> $AUTHLOG
	echo $datelog PID[$pidlog] $APPNAME"> Running script!" >> $AUTHLOG
	echo $datelog PID[$pidlog] $APPNAME"> Creating a IP list..." >> $AUTHLOG
	echo $datelog PID[$pidlog] $APPNAME"> Discovering devices..." >> $AUTHLOG
	
}

function finishLog () {
	datelog=$(date "+%h %d-%m-%Y %H:%M:%S")

	echo $datelog PID[$pidlog] $APPNAME"> Updated group $number $group!" >> $AUTHLOG	
	echo $datelog PID[$pidlog] $APPNAME"> Task end." >> $AUTHLOG
	echo $datelog PID[$pidlog] $APPNAME"> temprfile removed!" >> $AUTHLOG
	echo $datelog PID[$pidlog] $APPNAME"> Waiting next update!" >> $AUTHLOG

echo "<warning>
    <line1>Reading database...</line1>
    <line2>Archive last information...</line2>
    <line3>Updated group '$number' '$group'! </line3>
    <line4>Task end.</line4>
    <line5>Waiting next update!</line5>
</warning>" > "$grouplocal"warning.xml		
}

function waitupdateLog () {
echo "<warning>
    <line1></line1>
    <line2></line2>
    <line3>Waiting next update! </line3>
    <line4></line4>
    <line5></line5>
</warning>" > "$grouplocal"warning.xml
}
#

# Begin
choose $argumentos
	
	# Define arquivo temporario 
# tempffile not supported
file_in_discovery_tmp=$(mktemp "$TEMP_LOCAL_SIMBADR"discovery.XXX)
file_in_discovery_tmp_grep=$(mktemp "$TEMP_LOCAL_SIMBADR"discovery.XXX)
#

#

log_

if test -z $1 
	then    
   	read -t60 -p 'Enter with  CIDR network (e.g. 192.168.0. ) -->  ' rede
        if test -z $rede
       	 then
       	 	rm -f "$file_in_discovery_tmp_grep"
				rm -f "$file_in_discovery_tmp"
         	 exit 0                         
                fi 
        else
	rede=$1

	
fi


# writing ip file 
for i in {1..254}
	do
		echo "$rede$i" >>  $file_in_discovery_tmp       
	done
#  



debug_log

# testing connection ip in network
"$baseExec"infodevice.sh -p -f "$file_in_discovery_tmp" -t > $file_in_discovery_tmp_grep 
grep "ON" $file_in_discovery_tmp_grep | cut -d":" -f1  >> $globalDir$globalFile 

waitupdateLog

#cat $file_in_discovery_tmp > $globalDir$globalFile

cat $file_in_discovery_tmp_grep >> $baseDIR"90" 

 
rm -f "$file_in_discovery_tmp_grep"
rm -f "$file_in_discovery_tmp"

# End
