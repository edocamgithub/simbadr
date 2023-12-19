#!/bin/bash
##################################################################
#  File: simbadr-dependencies-file.sh 	    Built: 202109280822 
#  Version: 1.0.0                      Update 202312062029
#
#  Function: Read Head Script Files for Simbadr tools.
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2023 Eduardo M. Araujo.
#
#  This file is part the Simbadr scripts tools collections.
#
#  Required: null
#
#  Note: null
#
# created by manual 
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="0.0.1"
     BUILT="2021Set28"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2023."
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG="/var/log/log_$$.log"

# Enable debug displayed
debugVerbose=true
#

# Options enable
argumentos=$@
#

# Timestamp
just=$(date "+%s")
#

# Display help
help_manual() {
echo "$APPNAME version $VERSION $COPYRIGHT
   * Read Script file dependences *
    
Usage: $APPNAME [file]
 
OPTION:
  -h, --help         show this is information;
  -V, --version      show version number;
 
Example:
   $APPNAME  simbadr-write-conf.sh               
   $APPNAME  /opt/simbadr/lib/simbadr/reports.sh 
   
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

     -V | --version | -v )
      echo "version: $VERSION" ;;
	*)
	cat $options | grep -E  "Required:|Built:|Note:|File:|Version:|Function:"
	;;
	
esac
}

# Begin
choose $argumentos
# End
