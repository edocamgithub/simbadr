#!/bin/bash
##################################################################
#  File: headxml.sh 	       Built: 201904041540
#  Version: 1.0.5
#
#  Function: Merge XML Files
#
#  Copyright (c)2019-2023; Written by Eduardo M. Araujo.
#
##################################################################
#   This file is part the  simbadr scripts tools collections.
#
#  Required: Input XML file from infodevice.sh;simbadr-read-conf.sh
#
#  Note: Remove Head on XML file and insert only one.
#  
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.2"
     BUILT="2019Abr04"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2023"
   CONTACT="Contact for email: <edocam@outlook.com>"
  #AUTHLOG="/var/log/log_$$.log"
   baseLOG=$(simbadr-read-conf.sh --backup)
   baseDIR_LIB=$(simbadr-read-conf.sh --library)
   AUTHLOG="$baseLOG"simbadr.log

TEMP_LOCAL_SIMBADR="/tmp/simbadr/"

# Enable Print VAR in default output
debugVerbose=true
#

# Enable OPTIONS
argumentos=$@
#

# HELP for user
help_manual() {
  echo "$APPNAME version $VERSION $COPYRIGHT
  
   * Modify input XMLfiles for default Simbadr XMLfiles  *
  
  Use: $APPNAME <filename> <groupname> <device> 
  
  OPTIONS:
    -h, --help         show this is information;
  
    -V, --version      show number of version;
  
   for exemple:
         $APPNAME  /tmp/test.xml 00 Workstation
  
  $CONTACT"
      exit 0
}
#


# INPUT inline argumments
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
	  #group_name=$2
	 type_device=$3
	 #group_number=$(echo $file_in_xml | cut -d "/" -f "3" | cut -d "." -f1)
 group_number=$2	 
	 
	 
	 group_name=$("$baseDIR_LIB"rinfogrp.sh -"$group_number")
	#echo "===----->" $group_number
	
	
# verificar a linha acima
#file_in_xml_tmp
file_in_xml_tmp=$(mktemp "$TEMP_LOCAL_SIMBADR"simbadr_xml.XXX)


sed 's/<?xml version="1.0" encoding="UTF-8" ?>//' $file_in_xml  >  $file_in_xml_tmp 

# Verify Error Arguments  
if test $? = 1  
 then
  echo "*"
  echo "Error!! Verify this is command! "
  exit 0
  fi
  
#cat $file_in_xml_tmp

# Make TIMES for screens
just_time=$(date "+%s")
 date_now=$(date "+%y%m%d")

# SUM devices
   on_device=$(grep -w "ON" $file_in_xml | wc -l)
  off_device=$(grep -w "OFF" $file_in_xml | wc -l)
total_device=$(echo $((on_device + off_device)))


# Export for XMLfile
echo '<?xml version="1.0" encoding="UTF-8" ?>' 
echo '<!-- created by headxml for Simbadr tools -->'
echo '<?xml-stylesheet type="text/xsl" href="../xsl/newstatus.xsl" ?>' 
echo '<group name="'$group_name'" number="'$group_number'" serial="'$just_time'" typedevice="'$type_device'" on="'$on_device'" off="'$off_device'" total="'$total_device'"   >' 
cat $file_in_xml_tmp
echo '</group>' 

# Remove XMLfile Temp
  rm -f $file_in_xml_tmp
# End
