#!/bin/bash
##################################################################
#  File: reports.sh 	       Built: 201906160820
#  Version: 1.0.1
#
#  Function: Manager for Print Reports
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2021 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#
#  Required: 
#
#  Note:
#  
#                   ---------------------------
#
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2019Jun16"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (C)2019-2021 Eduardo M. Araujo."
   CONTACT="Contact for email: <edocam@outlook.com>"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log


# Habilita a impressao de variaveis
debugVerbose=true
debugVisible=false
#

# Habilita as opcoes
argumentos=$@
#

# Diretorio de base
baseDIR=$(simbadr-read-conf.sh --global)
baseDIR_barra=$(echo $baseDIR | cut -d"/" -f1-7)
grouplocal=$(simbadr-read-conf.sh --group99)
baseDIR_LIB=$(simbadr-read-conf.sh --library)


#
    
# Log de variaveis
function log_ () {
PIDexec=$(pgrep $APPNAME)
DATEpid=$(date "+%b %d %T")
logs_simbadr=$(echo "$DATEpid, PID ($PIDexec), exec_file --> $APPNAME, date_reg. --> $datereg, serial --> $getserial , name_group --> $groupname, number_group --> $numbergroup, directory --> $3, filename --> $filename, total_last_devices --> $devicenumber, output_file --> $compress, ouptut -- > $outputhistory$numbergroup"/" ")
}
#


# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION $COPYRIGHT
  
 * Armazena o arquivo XML para relatório *

Uso: $APPNAME [opções] <grupo>

OPÇÕES:
  -h, --help         apresenta esta informação para ajuda e finaliza;
  -V, --version      mostra a versão atual;

 Exemplos:
       $APPNAME 01            # armazena no arquivo histórico
                                para consulta posterior.
$CONTACT"
      exit 0
}
#
# Debug print
function debug_console () {

	datereg=$(date --date="@"$1"")

if [ "$debugVerbose" = true ]
   then
      echo "$APPNAME
      === init DEBUG ===
      date reg. --> $datereg
      serial --> $1
      group name --> $5
      group number --> $2
      directory --> $3
      file name --> $6
      total last devices --> $4
      output file --> $7
      ouptut -- > $8
      === * ===" 
fi
}
#
function debug_log () {
log_
if [ $debugVisible = true ]
	then
		echo $logs_simbadr     	
		echo $logs_simbadr  >> $AUTHLOG 2>> $AUTHLOG
		else
			echo $logs_simbadr  >> $AUTHLOG 2>> $AUTHLOG
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
      echo "versão: $VERSION" 
      exit 0 ;;
	   *);;
esac
}
#


# Begin

choose $argumentos



	if test -z $1 
		then 
			exit 0
		fi

# Define o numero do Grupo
numbergroup=$1

# Recupera o PATH para o Grupo definido em NUMBERGROUP 
db=$(simbadr-read-conf.sh  -"$numbergroup")

# Recupera o PATH para o HISTORY (backup)
outputhistory=$(simbadr-read-conf.sh  -y)

# Define o arquivo para leitura da SERIAL
name_file=$(echo "$db""$numbergroup") 

# Apresenta o total de dispositivos no Grupo
devicenumber=$(grep ipadress "$db"/"$numbergroup".xml | wc -l)

# Recupera o nome atribuído no Grupo
groupname=$(grep -w name "$db"/"$numbergroup".xml | cut -d"\"" -f2)

# Define o nome do arquvio padrão XML
filename=$(echo "$numbergroup".xml)

# Recupera a Serial do arquivo XML
getserial=$(grep -w serial "$db""$numbergroup".xml | cut -d"\"" -f4)

# Atribuí um nome para o arquivo a ser compactado
compress=$(echo "$getserial".tar.gz)


# File test

	if test -e "$name_file".xml; 
		then 
			echo "$getserial"
		 	#	echo "Arquivo "$filename" associado ao Grupo" $numbergroup "já existente!" ; 
			else
				echo "nao exite"
				exit 1 # echo "nao existe!"	
		fi
#

#tar -zcf "$getserial".tar.gz blocks/"$numbergroup"/"$numbergroup".xml 

tar -zcf "$outputhistory$numbergroup"/"$compress"  "$db" 2>/dev/null


debug_console $getserial $numbergroup $db $devicenumber $groupname $filename $compress $outputhistory$numbergroup"/"
debug_log

exit 0



# End








