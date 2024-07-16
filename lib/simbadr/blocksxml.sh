#!/bin/bash
##################################################################
#  File: blocksxml.sh    Built: 201904101436
#  Version: 1.0.2        Update 202312062029
#
#  Function: Export IPlist for XML file (status)
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2024 Eduardo M. Araujo..
#
#  This file is part the  Simbadr scripts tools collections.
#
#  Required: simbadr-read-conf.sh;infodevice.sh;headxml.sh
#
#  Note: All files with IP list in blocks/00 
#
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.2"
     BUILT="2020Out4"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (C)2019-2024"
   CONTACT="Contact for email: <edocam@outlook.com>"
   baseLOG=$(simbadr-read-conf.sh --backup)
    baseDIR_LIB=$(simbadr-read-conf.sh --library)
   AUTHLOG="$baseLOG"simbadr.log

      TEMP_LOCAL_SIMBADR="/tmp/simbadr"

# Verifica a existenica do DIR=tmp/simbadr/
if test -d $TEMP_LOCAL_SIMBADR
	then
  		echo "/tmp/simbadr not found!" >/dev/null
	else
  		mkdir $TEMP_LOCAL_SIMBADR
	fi


	file_list_name=$1
	    group_name=$2
	     type_name=$3
		     folder=$1

# group_name=$("$baseDIR_LIB"rinfogrp.sh -"$folder")
 
# Habilita a impressao de variaveis
debugVisible=false
#

# Habilita as opcoes
argumentos=$@
#

# Diretorio de base
baseDIR=$(simbadr-read-conf.sh -g)
baseDIR_barra=$(echo $baseDIR | cut -d"/" -f1-7)
baseDIR_LIB=$(simbadr-read-conf.sh --library)
baseExec=$(simbadr-read-conf.sh --exec)
#

# Log de variaveis
function log_ () {
PIDexec=$(pgrep -f $APPNAME)
DATEpid=$(date "+%b %d %T")
logs_simbadr=$(echo "$DATEpid, PID ($PIDexec), exec_file --> $APPNAME, file_list_name --> $file_list_name, file_sort_list --> $file_list_name, group_name --> $group_name, type_name --> $type_name, folder --> $folder, base_DIR --> $baseDIR, base_DIR_barra --> $baseDIR_barra")
}
#

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION 
$COPYRIGHT $AUTHOR
  * Export XMLfiles *

Usage: $APPNAME <groupnumber> <groupname> <devicetype> 

OPTION:
  -h, --help       show this is information;
  -V, --version    show number version;

Example:
   $APPNAME  00 LOCAL00 workstation  # Export a output XML on groupname  
  
$CONTACT"
      exit 0
}
#


function debug_log ()
{
log_
if [ $debugVisible = true ]
	then
	echo	$file_list_name, $group_name, $type_name, $folder
	     
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
      echo "versão: $VERSION" ;;

  	*)
  		;;
esac
}
#

# Classificar em forma crescente e sem repetição
function sortListUniq () {
# Use: sortListUniq NUMERO_GRUPO
# Ex.: sortListUniq 01

	file_sort_list=$1
	file_in_sort_tmp=$(mktemp "$TEMP_LOCAL_SIMBADR/"simbadr_sort.XXX) 
	sort -n "$baseDIR"$file_sort_list > $file_in_sort_tmp && cat $file_in_sort_tmp > "$baseDIR"$file_sort_list
	#rm -f $file_in_sort_tmp
	rm -f $file_in_sort_tmp 	
}
#

# Abre o arquivo de lista de IP's
function exportListForXml () {
# Use: exportListForXml NUMERO_GRUPO NOME_DO_GRUPO TIPO_DE_DISPOSITIVO
# Ex.: exportListForXml 14 $group_name_02 $ws 

	file_list_name=$1
	    group_name=$2
	     type_name=$3
		     folder=$1
	  group_number=$1    
		     
		     echo $1,$2,$3 > /tmp/simbadr/head.tmp.debug
	         
"$baseExec"infodevice.sh -p -f "$baseDIR"$file_list_name -x > "$TEMP_LOCAL_SIMBADR/"$file_list_name.xml && "$baseDIR_LIB"headxml.sh "$TEMP_LOCAL_SIMBADR/"$file_list_name.xml $group_number $type_name > $baseDIR_barra/$folder/$file_list_name.xml  
#echo ""$baseExec"infodevice.sh -p -f "$baseDIR"$file_list_name -x > "$TEMP_LOCAL_SIMBADR/"$file_list_name.xml && "$baseDIR_LIB"headxml.sh "$TEMP_LOCAL_SIMBADR/"$file_list_name.xml $group_name $type_name > $baseDIR_barra/$folder/$file_list_name.xml  "


}
#

# Begin	
	choose $argumentos
	debug_log
	sortListUniq $file_list_name
	#exportListForXml $file_list_name $group_name $type_name
	exportListForXml $file_list_name $group_name $type_name
	
	debug_log
	exit
# End
