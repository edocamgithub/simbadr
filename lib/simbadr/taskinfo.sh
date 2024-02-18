#!/bin/bash
##################################################################
#  File: taskinfo.sh 	       Built: 201910131828
#  Version: 1.0.1
#
#  Function: 
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2024 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#
#  Required: 
#
#  Note:
#  
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2019Out13"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG="/var/log/log_$$.log"


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
   * Carrega o perfil de configuração  *
  
  Uso: $APPNAME [opções] <argumentos> {alvo} 
  
  OPÇÕES:
    -h, --help      apresenta esta informação para ajuda e finaliza;
    -V, --version   mostra a versão atual;
    -s, --slow      carrega o perfil 'long';
    -n, --normal    carrega o perfil 'normal';
    -m, --medium    carrega o perfil 'mean';
    -q, --quick     carrega o perfil 'fast';
  
   Exemplos:
         $APPNAME  -n
  
  $CONTACT"
      exit 0
}
#
# Debug print
function debug_console () {
if [ "$debugVerbose" = true ]
   then
      echo "=== Job                 $taskExecuteStart $taskExecuteCOB"  
      echo " taskExecuteTime    --> "$taskExecuteTime
      echo " taskExecuteReport  --> "$taskExecuteReport      
      echo " taskExecuteGroup   --> "$taskExecuteGroup
      echo " taskExecuteComment --> "$taskExecuteComment

fi
}
#
# Argumentos de linha de comando
choose () {

if test -z "$argumentos" 
   	then
        exit
   		fi
   		
   		
        options=$argumentos

case "$options" in
     -h | --help )
       help_manual  ;;

     -V | --version )
      echo "versão: $VERSION" 
      exit;;

     -s | --slow )
      getConfig="slow" ;;

     -n | --normal )
      getConfig="normal" ;;

     -m | --medium )
      getConfig="medium" ;;

     -q | --quick )
      getConfig="quick" ;;

		*)
			if test -n "$1"
      		then
         		echo $APPNAME  :  "$1"  é um argumento inválido.;
            	echo Experimente "$APPNAME" --help para maiores informações.; 
         		fi
  		exit;;
esac
}
#


# Begin
choose $argumentos

DIR=$( simbadr-read-conf.sh --setup )

taskExecuteTime=$(grep $getConfig  "$DIR"schedule.xml | cut -d '"' -f2)
taskExecuteReport=$(grep $getConfig "$DIR"schedule.xml | cut -d '"' -f4)
taskExecuteGroup=$(grep $getConfig  "$DIR"schedule.xml | cut -d ">" -f2 | cut -d"<" -f1 | sed "s/,/ /g" )
taskExecuteComment=$(grep $getConfig  "$DIR"schedule.xml | cut -d '"' -f6)
taskExecuteStart=$(grep "start"  "$DIR"schedule.xml | cut -d '"' -f2)
taskExecuteCOB=$(grep "COB"  "$DIR"schedule.xml | cut -d '"' -f2)


debug_console
# End
