#!/bin/bash
##################################################################
#  File: makeips.sh 	     Built: 201904081435
#  Version: 1.2.0         Update 202312062029
#
#  Function: Make sequetial IP list 
#
#  Written by Eduardo M. Araujo.
##################################################################
#  Copyright (c)2019-2024 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#  Required: null
#
#  Note: Output CIDR class C (/24)  example 192.168.0.1-255
#  
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.2.0"
     BUILT="2019Abr08"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   #AUTHLOG="/var/log/log_$$.log"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log

# Habilita a impressao de variaveis
debugVerbose=true
#

# Habilita as opcoes
argumentos=$@
#

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION 
$COPYRIGHT $AUTHOR
  * Make sequence 1..254 for IP *
  
  Usage: $APPNAME 
  
  OPTION:
    -h, --help         show this is information;
    -V, --version      show version number;
  
  $CONTACT"
      exit 0
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

# Begin
choose $argumentos
if test -z $1 
	then	
	read -t60 -p '  Enter network (e.g. 192.168.0. ) -->  ' rede
	if test -z $rede
		then
			exit 0			
		fi 
	else
	rede=$1
fi

for i in {1..254}
  	do
		echo "$rede$i"
  done
# End
