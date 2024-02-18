#!/bin/bash
##################################################################
#  File: make_link_for_web.sh 	       Built: 202305282009
#  Version: 1.0.0				      
#  
#  Function: Maker link for web.
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#  Copyright (c)2023-2024 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#  Required: 
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.0"
     BUILT="2023mai28"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (C)2023-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG_=$(simbadr-read-conf.sh -y)
   AUTHLOG=$AUTHLOG_"00/log_$$.log"

# Habilita a impressao de variaveis
debugVerbose=true
#

# Habilita as opcoes
argumentos=$@
list_group=$@
#

# Diretorio de base
baseDIR=$(simbadr-read-conf.sh --global)
baseDIR_barra=$(echo $baseDIR | cut -d"/" -f1-7)
grouplocal=$(simbadr-read-conf.sh --group99)
baseDIR_LIB=$(simbadr-read-conf.sh --library)
etc_DIR=$(simbadr-read-conf.sh -s)
group_enable_list="simbadr"
baseDIR_etc=$(simbadr-read-conf.sh --setup)
webDIR_xml=$(simbadr-read-conf.sh -m)
simbadr_ETC=$(simbadr-read-conf.sh -s)
#

echo $baseDIR
echo $baseDIR_barra
echo $grouplocal
echo $baseDIR_LIB
echo $etc_DIR
echo $group_enable_list
echo $baseDIR_etc
echo $webDIR_xml
echo $simbadr_ETC
echo $grouplocal

cd "$webDIR_xml"

#group_enable=01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29

numbers_Groups=$(cat $simbadr_ETC"simbadr"  | grep group_enable | cut -d"=" -f"2")

for i in $numbers_Groups
do
ln -s  $baseDIR_barra"/$i""/""$i.xml"

done

ln -s $grouplocal"infodash.xml"
ln -s $grouplocal"statusinfo.xml"
exit
