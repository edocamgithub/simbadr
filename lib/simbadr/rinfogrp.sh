#!/bin/bash
##################################################################
#  File: rinfogrp.sh 	     Built: 201906082334
#  Version: 1.2.0            Update 202312062029
#
#  Function: Read XML file for Groups Names
##################################################################
#  Copyright (c)2020-2024 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#  Required: groups.xml
#
#  Note: version 0.0.2 add -l for all groups
#  
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.2.0"
     BUILT="2020Out09"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2020-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log


# Habilita as opcoes
argumentos=$@
#

# Diretorio de base
baseDIR=$(simbadr-read-conf.sh -s)

##

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION  
$COPYRIGHT $AUTHOR
     * Display Groupname *
  
  Usage: $APPNAME <options> 
  
  OPTION:
    -h, --help         show this is information;
    -V, --version      show version number;
    -l, --all          display all groups;
    -X, --group0       display static groupname, ex.: -1 ou --group1 até -32 ou group32;
  Example:
         $APPNAME -0          # display groupname 00
         $APPNAME --group01   # display groupname 01
         $APPNAME -14         # display groupname 14
    
  $CONTACT"
      exit 0
}
#

#
function translateNumberforGroup () {
 	numberGroup=$1
	#baseDIR=/etc/simbadr/
	grep alias "$baseDIR"groups.xml | grep "$numberGroup"  | cut -d">" -f2 | cut -d"<" -f1 
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

     -0 | --group0 | -00 | --group00 )
      
      translateNumberforGroup "00" ;;
     
     -1 | --group1 | -01 | --group01 )
      translateNumberforGroup "01" ;;
      
     -2 | --group2 | -02 | --group02 )
		translateNumberforGroup "02" ;;      
      
	  -3 | --group3 | -03 | --group03 )
      translateNumberforGroup "03" ;;      
      
     -4 | --group4 | -04 | --group04 )
		translateNumberforGroup "04" ;;      
                  
     -5 | --group5 | -05 | --group05 )
      translateNumberforGroup "05" ;;      
      
     -6 | --group6 | -06 | --group06 )
      translateNumberforGroup "06" ;;      
      
     -7 | --group7 | -07 | --group07 )
	   translateNumberforGroup "07" ;;      
            
	  -8 | --group8 | -08 | --group08 )
      translateNumberforGroup "08" ;;      
      
     -9 | --group9 | -09 | --group09 )
      translateNumberforGroup "09" ;;      
      
     -10 | --group10 )
      translateNumberforGroup "10" ;;      
      
     -11 | --group11 )
     translateNumberforGroup "11" ;;      
      
     -12 | --group12 )
     translateNumberforGroup "12" ;;      
      
	  -13 | --group13  )
      translateNumberforGroup "13" ;;      
      
     -14 | --group14  )
     translateNumberforGroup "14" ;;      
          
     -15 | --group15 )
     translateNumberforGroup "15" ;;      
            
     -16 | --group16 )
     translateNumberforGroup "16" ;;      

     -17 | --group17 )
     translateNumberforGroup "17" ;;
     
     -18 | --group18 )
     translateNumberforGroup "18" ;;      

     -19 | --group19 )
     translateNumberforGroup "19" ;;      

     -20 | --group20 )
     translateNumberforGroup "20" ;;      

     -21 | --group21 )
     translateNumberforGroup "21" ;;      

     -22 | --group22 )
     translateNumberforGroup "22" ;;      

     -23 | --group23 )
     translateNumberforGroup "23" ;;      

     -24 | --group24 )
     translateNumberforGroup "24" ;;      

     -25 | --group25 )
     translateNumberforGroup "25" ;;      

     -26 | --group26 )
     translateNumberforGroup "26" ;;      

     -27 | --group27 )
     translateNumberforGroup "27" ;;      

     -28 | --group28 )
     translateNumberforGroup "28" ;;      

     -29 | --group29 )
     translateNumberforGroup "29" ;;      

     -30 | --group30 )
     translateNumberforGroup "30" ;;      

     -31 | --group31 )
     translateNumberforGroup "31" ;;      

     -32 | --group32 )
     translateNumberforGroup "32" ;;      

     -90 | --group90 )
     translateNumberforGroup "90" ;;      

     -91 | --group91 )
     translateNumberforGroup "91" ;;      

     -92 | --group92 )
     translateNumberforGroup "92" ;;      

     -93 | --group93 )
     translateNumberforGroup "93" ;;      

     -94 | --group94 )
     translateNumberforGroup "94" ;;      

     -95 | --group95 )
     translateNumberforGroup "95" ;;      

     -96 | --group96 )
     translateNumberforGroup "96" ;;      

     -97 | --group97 )
     translateNumberforGroup "97" ;;      
      
	  -98 | --group98 )
     translateNumberforGroup "98" ;;       

	  -99 | --group99  )
      translateNumberforGroup "98" ;;  
      
	  -l | --all  )
      grep alias "$baseDIR"groups.xml | cut -d"=" -f2 | cut -d"<" -f1 | sed "s/>/ /" | sed 's/"/ /' | sed 's/"//' | grep -v 00 | grep -v 90 | grep -v 91 | grep -v 92 | grep -v 93 | grep -v 94 | grep -v 95 | grep -v 96 | grep -v 97 | grep -v 98 | grep -v 99 | cut -d" " -f2-3;;
                     
	*);;
	
   esac
}
#

# Begin
choose $argumentos
# End
