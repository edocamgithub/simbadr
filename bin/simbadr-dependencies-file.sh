#!/bin/bash
##################################################################
#  File: simbadr-dependencies-file.sh 	    Built: 202109280822 
#  Version: 0.0.1
#
#  Function: Read Head Script Files for Simbadr tools.
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-20201 Eduardo M. Araujo.
#
#  This file is part the Simbadr scripts tools collections.
#
#  Required: null
#
#  Note: null
#
#                   ---------------------------
#
# created by manual 
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="0.0.1"
     BUILT="2021Set28"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c) 2019-2021 Eduardo M. Araujo."
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG="/var/log/log_$$.log"

# Habilita a impressao de variaveis
debugVerbose=true
#

# Habilita as opcoes
argumentos=$@
#

# Habilita as opcoes
just=$(date "+%s")
#

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION $COPYRIGHT
 
   * Lista as propriedades do arquivo de Script
    
Uso: $APPNAME [file]
  
OPÇÕES:
  -h, --help         apresenta esta informação para ajuda e finaliza;
  -V, --version      mostra a versão atual;
 
Exemplos:
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
      echo "versão: $VERSION" ;;
	*)
	cat $options | grep -E "Required:|Built:|Note:|File:|Version:|Function:"
	;;
	
esac
}



# Begin
choose $argumentos


# End
