#!/bin/bash
##################################################################
#  File: rinfodevice.sh 	     Built: 201905161412
#  Version: 1.2.0               Update 202312062029
#										  lastUpdate 202402252008
#
#  Function: Read devices.xml
#
#  Written by Eduardo M. Araujo.
##################################################################
#  Copyright (c)2019-2024 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#  Required: devices.xml
#
#  Note: null
#           24 set 2019 - +ipphone
#           14 nov 2023 +Any devices
#
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.2.0"
     BUILT="2019Mai16"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log

#Export tempfiles  
	TEMP_LOCAL_SIMBADR="/tmp/simbadr"

	
# Habilita a impressao de variaveis
debugVerbose=false
#

# Habilita as opcoes
argumentos=$@
#

# Configuração principal 
config=$(simbadr-read-conf.sh -s)

# Diretorio de base
baseDIR_LIB=$(simbadr-read-conf.sh --library)

#
#

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION 
$COPYRIGHT $AUTHOR
    * Query devices.xml file and return fullname  *
  
  Usage: $APPNAME <options> 
  
  OPTIONS:
    -h, --help            show help information;
    -V, --version         show version;
    -i                    for interactive question;
    -w, --workstation     return Workstation fullname;
    -s, --server          return Server fullname;
    -p, --printer         return Printer fullname;
    -c, --switch          return Switch or hub fullname;
    -a, --access-point    return AP or router fullname;
    -t, --site            return Site or homepage;
    -l, --laptop          return laptop and Notebook fullname;
    -f, --smartphone      return Smartphone fullname;
    -b, --tablet          return Tablet fullname;
    -v, --voip-phone      return VoIP phone fullname;
    -d, --everything      return everything or an IoT;
    -y, --security-cam	  return Security Cam;
  
   Example:
         $APPNAME  -f
         $APPNAME  --access-point
         $APPNAME  -c
  
  $CONTACT"
      exit 0
}
#

function debug_console ()
{
if [ $debugVerbose = true ] 
	then
		echo ""	
		echo "===>" $config
		echo ""
fi
}
#


interactive_List () {
echo -e " 
What is your device? 

         s          c            a               w             v        t 
    [ Server ] [ Switch ] [ Access Point ] [ Workstation ] [ VoIP ] [ Site ]

         b         p             l               f            u
    [ Tablet ] [Printer ] [Laptop/Notebook] [ Smartphone  ] [ UPS ]

         e             *             y
    [ Everything ] [ Unknown ] [Security CAM]

"
read -p "->" device_selected

argumentos="-"$device_selected

choose $argumentos > $TEMP_LOCAL_SIMBADR/rinfodevice_interactive  
}


# Argumentos de linha de comando
choose () {
        options=$argumentos

case "$options" in
     -h | --help )
       	help_manual  ;;

     -V | --version )
      	echo "versão: $VERSION" ;;

     -v | --voip-phone )
			grep \"ph\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;

     -w | --workstation )
        grep \"ws\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -s | --server )
			grep \"sr\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -p | --printer )
			grep \"pr\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -c | --switch )
			grep \"sw\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;

     -a | --access-point )
			grep \"ap\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -t | --site )
			grep \"st\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;

     -l | --laptop )
			grep \"ln\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -f | --smartphone )
			grep \"sp\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -b | --table )
			grep \"tb\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;

	  -e | --everything )
			grep \"ev\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
		
	  -u | --ups )
			grep \"up\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
			
	  -y |  --security-cam )	
	  	  grep \"sc\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
		
	  -i | --interactive )
	   	interactive_List ;;	

	  * )
			grep \"uk\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1
			exit 0;;
esac
}
#


# Begin
debug_console
choose $argumentos

# End
