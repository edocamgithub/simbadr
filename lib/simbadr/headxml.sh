#!/bin/bash
##################################################################
#  File: headxml.sh 	       Built: 201904041540
#  Version: 1.0.1
#
#  Function: Merge XML Files
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2023 Eduardo M. Araujo..
#
#   This file is part the  simbadr scripts tools collections.
#
#
#  Required: Input XML file from infodevice.sh;simbadr-read-conf.sh
#
#  Note: Remove Head on XML file and insert only one.
#  
#
#                   ---------------------------
#
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.2"
     BUILT="2019Abr04"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c) 2019-2023 Eduardo M. Araujo."
   CONTACT="Contact for email: <edocam@outlook.com>"
   #AUTHLOG="/var/log/log_$$.log"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log
    TEMP_LOCAL_SIMBADR="/tmp/simbadr/"

# Habilita a impressao de variaveis
debugVerbose=true
#

# Habilita as opcoes
argumentos=$@
#

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION $COPYRIGHT
  
   * Transforma o arquivo XML de entrada para o padrão  *
  
  Uso: $APPNAME <filename> <groupname> <device> 
  
  OPÇÕES:
    -h, --help         apresenta esta informação para ajuda e finaliza;
  
    -V, --version      mostra a versão atual;
  
   Exemplos:
         $APPNAME  /tmp/test.xml 00 Workstation
  
  $CONTACT"
      exit 0
}
#


# Argumentos de linha de comando
choose () {
        options=$argumentos

case "$options" in
     -h | --help )
       help_manual 
		 exit 0	       
        ;;

     -V | --version )
      echo "versão: $VERSION" 
		exit 0      
      ;;

	*);;
esac
}
#


# Begin
choose $argumentos

    file_in_xml=$1
	  group_name=$2
	 type_device=$3
	 group_number=$(echo $file_in_xml | cut -d "/" -f 3 | cut -d "." -f1)
	 
# verificar a linha acima
#file_in_xml_tmp
file_in_xml_tmp=$(mktemp "$TEMP_LOCAL_SIMBADR"simbadr_xml.XXX)


sed 's/<?xml version="1.0" encoding="UTF-8" ?>//' $file_in_xml  >  $file_in_xml_tmp 


#cat $file_in_xml_tmp

just_time=$(date "+%s")
date_now=$(date "+%y%m%d")

on_device=$(grep -w "ON" $file_in_xml | wc -l)
off_device=$(grep -w "OFF" $file_in_xml | wc -l)
total_device=$(echo $((on_device + off_device)))


echo '<?xml version="1.0" encoding="UTF-8" ?>' 
echo '<!-- created by Simbadr tools -->'
echo '<?xml-stylesheet type="text/xsl" href="../xsl/newstatus.xsl" ?>' 
echo '<group name="'$group_name'" number="'$group_number'" serial="'$just_time'" typedevice="'$type_device'" on="'$on_device'" off="'$off_device'" total="'$total_device'"   >' 

#echo '<group name="'$group_name'" number="'$group_number'" serial="'$just_time'" " on="'$on_device'" off="'$off_device'" total="'$total_device'"   >' 

cat $file_in_xml_tmp
echo '</group>' 

rm -f $file_in_xml_tmp



# End
