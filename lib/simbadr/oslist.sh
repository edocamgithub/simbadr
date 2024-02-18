#!/bin/bash
##################################################################
#  File: oslist.sh 	   Built: 201904280929
#  Version: 1.2.0       Update 202312062029
#
#  Function: Make OS names for sequential 
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#  Copyright (c)2019-2024 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#  Required: oslist.db
#
#  Note: Only add new OS names. 
#  
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.2.0"
     BUILT="2019Abr28"
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
 * Register New OS name for use in Database *

Usage: $APPNAME

OPTION:
  -h, --help         show this is information;
  -V, --version      show version number;

$CONTACT"
      exit 0
}
#

addOS () {
#
echo 
echo "          = = = ADD Operational System = = ="
echo "
TEMPLATE
DistributorID: Version: Codname: Generic Name: Full Name: Plataform: Distributor Name:Release date
Ubuntu:18.04 LTS:Bionic Beaver:GNU/Linux:Ubuntu 18.04 LTS:x86:Canonical
Windows:10:Titanium:Windows Plataform:Microsoft Windows 10 Pro:x86_64:Microsoft"
echo " "
read -t60 -p 'OS name(e.g.: Ubuntu)-->  ' osname
read -t60 -p 'Version (e.g.: 12.04 LTS)-->  ' versionnumber  
read -t60 -p 'CodName version(e.g.: Precise Pangolin)-->  ' codname 
read -t60 -p 'Generic Name (e.g.:GNU/Linux)-->' genericname
read -t60 -p 'Fullname IOD (Microsoft Windows 10 Enterprise)-->  ' fullnameiod
read -t60 -p 'Plataform (x86,x64 or x86_x64)--> ' plataform
read -t60 -p 'Distributor Name (Canonical,Microsoft,..)-->' distributorname
read -t60 -p 'Release date-->' releasedate
read -t60 -p 'Number Version -->' numberversion
echo $osname:$versionnumber:$codname:$genericname:$fullnameiod:$plataform:$distributorname:$releasedate:$numberversion >> "$dirSetup"oslist.db
echo
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
	dirSetup=$(simbadr-read-conf.sh -s)
	addOS
# End
