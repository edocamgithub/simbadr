#!/bin/bash
##################################################################
#  File: grpinfor.sh 	       Built: 201910101331
#  Version: 1.0.0
#
#  Function: Information group status for front-end
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2022 Eduardo M. Araujo..
#
#   This file is part the  simbadr scripts tools collections.
#
#  Required: simbadr-read-conf.sh;rinfogrp.sh;infodash.sh; group_enable on simbadr file
#
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2019Out10"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2022 Eduardo M. Araujo."
   CONTACT="Contact for email: <edocam@outlook.com>"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log
   #OUTPUT="grpinfor.xml"
   OUTPUT="statusinfo.xml"

# Habilita a impressao de variaveis
debugVisible=false
#

# Habilita as opcoes
argumentos=$@
#

all_enable=0


# Status e porcentagem
normal=51
warning=10
alert=0

# Diretorio de base

baseDIR_LIB=$(simbadr-read-conf.sh --library)
baseDIR=$(simbadr-read-conf.sh --setup)
#
# Log de variaveis
function log_ () {
PIDexec=$(pgrep $APPNAME)
DATEpid=$(date "+%b %d %T")
logs_simbadr=$(echo "$DATEpid, PID ($PIDexec), exec_file --> $APPNAME, output_file --> $OUTPUT, serial_file --> $just, export_all_groups --> $all")
}
#


# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION $COPYRIGHT
  
  Uso: $APPNAME [opções] <argumentos>  
  
  OPÇÕES:
   -h, --help         apresenta esta informação para ajuda e finaliza;
   -V, --version      mostra a versão atual;
   -a, --all          gera a lista completa;
  
   Exemplos:
         $APPNAME  -a           
         $APPNAME  -h            

  $CONTACT"
      exit 0
}


# Debug print
function debug_log () {

log_
if [ $debugVisible = true ]
	then
		echo $logs_simbadr     	
		echo $logs_simbadr  >> $AUTHLOG 2>> $AUTHLOG
		else
			echo $logs_simbadr  >> $AUTHLOG 2>> $AUTHLOG
fi
}


# Argumentos de linha de comando
choose () {
        
if test -z "$argumentos" 
   	then
        exit
   		fi        
        
        
        options=$argumentos

case "$options" in
     -h | --help )
       help_manual  ;;

     -V | --version )
       echo "versão: $VERSION" 
       exit 0;;

     -a | --all )
       all_enable=1
       no_test_grep=1;;
      
	*);;
esac
}
#


function statusGroup() {

value=$groupStatus

if  test $value -gt $normal 
   then
    value=$(echo $value | cut -d" " -f1)
     echo "<group>"
     echo '     <information groupnumber="'$groupNumber'" groupname="'$groupName'" percentage="'$value'">normal</information>'
     echo '     <grouplink>'../xml/$groupNumber.xml'</grouplink>'	
     echo "</group>"
       elif test $value -gt $warning 
            then
             value=$(echo $value | cut -d" " -f1)
            echo "<group>"
    	      echo '     <information groupnumber="'$groupNumber'" groupname="'$groupName'" percentage="'$value'">warning</information>'
            echo '     <grouplink>'../xml/$groupNumber.xml'</grouplink>'	
    	      echo "</group>"
		else
		 value=$(echo $value | cut -d" " -f1)
		  echo "<group>"
	  	  echo '     <information groupnumber="'$groupNumber'" groupname="'$groupName'" percentage="'$value'">alert</information>'
        echo '     <grouplink>'../xml/$groupNumber.xml'</grouplink>'	
	  	  echo "</group>"
		fi
}

function headXml() {
  echo '<?xml version="1.0" encoding="UTF-8" ?>'
  echo '<?xml-stylesheet type="text/xsl" href="../xsl/info.xsl" ?>'
  echo '<!-- grpinfor.sh output file '$OUTPUT' for Simbadr serial='$just' -->'
  echo "<status>"
}



# Begin
choose $argumentos

# Serial 
just=$(date "+%s")

#all="01 02"
# Read file /etc/simbadr/simbadr with term "group_enable"
all=$( grep group_enable "$baseDIR"simbadr | cut -d"=" -f2)


if test $no_test_grep -eq 0
 	then
		echo $all | grep $1 > /dev/null
			if test $? -eq 1
				then	
					exit 1
					fi
				fi
#



if test $all_enable -eq 1
	then
		headXml
  		for i in $all
  			do
				groupNumber="$i"
				groupName=$("$baseDIR_LIB"rinfogrp.sh -$i)
				groupStatus=$("$baseDIR_LIB"infodash.sh  $groupNumber | grep ":" | grep -v "<" | grep -v time | cut -d"," -f5 ) 
  				statusGroup
  				done
  				echo "</status>"
  	debug_log			
	exit 0
	fi
#

	groupNumber=$1 

#  Xml text output
  headXml
  echo "     <group>"$groupNumber"</group>"
  groupStatus=$("$baseDIR_LIB"infodash.sh  $groupNumber | grep ":" | grep -v "<" | grep -v time | cut -d"," -f5 ) 
  statusGroup
  echo "</status>"
  debug_log

  exit 0
#


# End
