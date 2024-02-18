#!/bin/bash
##################################################################
#  File: rinfodevice.sh 	     Built: 201905161412
#  Version: 1.2.0               Update 202312062029
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
    -w, --workstation     return workstation fullname;
    -s, --server          return server fullname;
    -p, --printer         return printer fullname;
    -c, --switch          return switch or hub fullname;
    -a, --access-point    return AP or router fullname;
    -t, --site            return site or homepage;
    -m, --mobile          return mobile or cellphone fullname;
    -f, --smartphone      return smartphone fullname;
    -b, --tablet          return tablet fullname;
    -v, --voip-phone      return voip phone fullname;
    -d, --everything      return all;
  
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

     -m | --mobile )
			grep \"ms\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -f | --smartphone )
			grep \"sp\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -b | --table )
			grep \"tb\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;

		-d | --everything )
			grep \"ev\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
   
	*)
		exit 0;;
esac
}
#


# Begin
debug_console
choose $argumentos

# End
