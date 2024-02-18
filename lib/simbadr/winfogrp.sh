#!/bin/bash
##################################################################
#  File: winfogrp.sh 	       Built: 201910102155
#  Version: 1.0.1
#
#  Writer/Edit group
#
#  Written by Eduardo M. Araujo.
##################################################################
#  Copyright (c)2019-2024 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#  Required: 
#
#  Note: 
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2019Out10"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (C)2019-2024"
   CONTACT="Contact for email: <edocam@outlook.com>"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log

 TEMP_LOCAL_SIMBADR="/tmp/simbadr/"
 
 
# Habilita a impressao de variaveis
debugVerbose=false
debugVisible=true 
#

# Habilita as opcoes
argumentos=$@
#

baseDIR_LIB=$(simbadr-read-conf.sh -l)

# Log de variaveis
PIDexec=$(pgrep $APPNAME)
DATEpid=$(date "+%b %d %T")
logs_simbadr=$(echo "$DATEpid, PID ($PIDexec), exec_file --> $APPNAME, old_group_name --> $old_group_name, new_group_name --> $new_group_name, commit_enable  --> $commit_enable")
#


commit_enable=0
input_enable=0
output_enable=0

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION 
$COPYRIGHT $AUTHOR   
  Uso: $APPNAME [opções] --input nome --output nome [-c]
  
  OPÇÕES:
    -h, --help         apresenta esta informação para ajuda e finaliza;
    -V, --version      mostra a versão atual;
    -v, --verbose      mostra as variáveis habilitadas;
        -i, --input    nome a ser editado/atualizado;
        -o, --output   novo nome para atualização; 
        -c, --commit   confirmar e gravar;

   Exemplos:
    $APPNAME                                       # lista os grupos/nomes
    $APPNAME -i nome -o outro_nome                 # troca o nome
    $APPNAME --input outro --output nome2 --commit # grava a mudança
  
  $CONTACT"
      exit 0
}
#
# Debug print
function debug_console () {
if [ "$debugVerbose" = true ]
   then
      echo ""
      echo "$APPNAME"
      echo "=== Init Task ==="
      echo " old_group_name --> "$old_group_name
      echo " new_group_name --> "$new_group_name
      echo " commit_enable  --> "$commit_enable
      echo "=== END ==="
      echo ""
fi
}
#
function debug_log ()
{
if [ $debugVisible = true ]
	then
	# Log de variaveis
		PIDexec=$(pgrep $APPNAME)
		DATEpid=$(date "+%b %d %T")
		logs_simbadr=$(echo "$DATEpid, PID ($PIDexec), exec_file --> $APPNAME, old_group_name --> $old_group_name, new_group_name --> $new_group_name, commit_enable  --> $commit_enable")
		#
		echo $logs_simbadr  >> $AUTHLOG 2>> $AUTHLOG
fi
}

# Argumentos de linha de comando
choose_ () {
while test -n "$1"
do
   case "$1" in
     
     -h | --help )
            help_manual  ;;

     -V | --version )
    	      echo "versão: $VERSION" ;;

     -i | --input )
            input_enable=1
            shift
            old_group_name=$1
            ;;
            
     -o | --output )
            output_enable=1
            shift
            new_group_name=$1
            ;;      
            
     -c | --commit )
            commit_enable=1
            ;;        

     -v | --verbose )
            debugVerbose=true
            ;;        
            
                 *)
            
            if test -n "$1"
               then
                   echo $APPNAME  :  "$1"  é um argumento inválido.;
                   echo Experimente "$APPNAME" --help para maiores informações.; 
               fi;;
   esac
       shift
done
}
#


# Begin
choose_ $argumentos
debug_console

	if test $commit_enable -eq 0
		then
			"$baseDIR_LIB"rinfogrp.sh -l
		fi
	
		DIR=$(simbadr-read-conf.sh -s)			
	 	
	if test $commit_enable -eq 1  && test $input_enable -eq 1 && test $output_enable -eq 1
		then
		 	file_commit_tmp=$(mktemp "$TEMP_LOCAL_SIMBADR"committmp.XXXXXXXX)
		   cat  "$DIR"groups.xml > "$DIR"groups.xml~ 
	      cat "$DIR"groups.xml | sed "s/$old_group_name/$new_group_name/" | tail -n47 > $file_commit_tmp && cat $file_commit_tmp > "$DIR"groups.xml   
			debug_log	 	   
	   	   exit
    	fi       
   
	if test $input_enable -eq 1 && test $output_enable -eq 1
		then
	      cat "$DIR"groups.xml | sed "s/$old_group_name/$new_group_name/" | tail -n47 
    	fi       
		
# End
