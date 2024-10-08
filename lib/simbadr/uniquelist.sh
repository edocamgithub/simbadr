#!/bin/bash
##################################################################
#  File: uniquelist.sh 	       Built: 201904202325
#  Version: 1.0.1
#
#  Agrupar lista
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#  Copyright (c)2019-2024 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#  Required: 
#
#  Note:
#
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2019Abr20"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2024"
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG="/var/log/log_$$.log"
TEMP_LOCAL_SIMBADR="/tmp/simbadr/"

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
   * Unifica todas as lista de IP's  *
  
  Uso: $APPNAME
  
  Lê todas as listas e gera a lista 99 com todos os IP's
  
  OPÇÕES:
    -h, --help         apresenta esta informação para ajuda e finaliza;
    -V, --version      mostra a versão atual;
  
   Exemplos:
         $APPNAME                # unifica a lista 00 até 16.
  
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

     -s | --ip-address )
      echo "origem do ip" ;;

	*);;
esac
}
#


# Begin
choose $argumentos

	file_in_sort_tmp=$(mktemp "$TEMP_LOCAL_SIMBADR"simbadrsort.XXXXXXXX)

for i in {01..32}
	do
   #echo "blocks/00/"$i"" 
		
	cat blocks/00/"$i" >> $file_in_sort_tmp && sort -n -u -t '.' -k 1,1 -k 2,2 -k 3,3 -k 4,4  $file_in_sort_tmp > blocks/00/99

	#echo "------"
	done
# End
