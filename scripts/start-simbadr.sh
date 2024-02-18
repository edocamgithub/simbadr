#!/bin/bash
##################################################################
#  File: start-simbadr.sh 	       Built: 202110142216
#  Version: 1.0.2				      Update 12092022 
#  
#  Function:  Execute the system Simbadr.
#
#  Written by Eduardo M. Araujo. 1-48
#
##################################################################
#                   ---------------------------
#  Copyright (c)2021-2024 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#  Required: simbadr-read-conf.sh, rinfodevice.sh, rinfogrp.sh, blocksxml.sh, infodash.sh, grpinfor.sh
#
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.2"
     BUILT="2021out14"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (C)2021-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG_=$(simbadr-read-conf.sh -y)
   AUTHLOG=$AUTHLOG_"00/log_$$.log"
   TEMP_LOCAL_SIMBADR="/tmp/simbadr"

# Verifica a existenica do DIR=tmp/simbadr/
if test -d $TEMP_LOCAL_SIMBADR
	then
  		echo "/tmp/simbadr not found!" >/dev/null
	else
  		mkdir $TEMP_LOCAL_SIMBADR
	fi




# Habilita a impressao de variaveis
debugVerbose=false
#



# Habilita as opcoes
argumentos=$@
#list_group=$@
#

# Diretorio de base
          baseDIR=$(simbadr-read-conf.sh --global)
    baseDIR_barra=$(echo $baseDIR | cut -d"/" -f1-7)
       grouplocal=$(simbadr-read-conf.sh --group99)
      baseDIR_LIB=$(simbadr-read-conf.sh --library)
        #  etc_DIR=$(simbadr-read-conf.sh -s)
group_enable_list="simbadr"
      baseDIR_etc=$(simbadr-read-conf.sh --setup)

#


simbadr_group=$(cat $baseDIR_etc/$group_enable_list | grep -w group_enable | cut -d "=" -f "2" )



# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION 
$COPYRIGHT $AUTHOR
Uso: $APPNAME <group or list of groups>

OPÇÕES:
  -h, --help         apresenta esta informação para ajuda e finaliza;
  -V, --version      mostra a versão atual;
 
 Exemplos:
        $APPNAME 01 02     # Executa a tarefa para o grupo 01 e 02           
        $APPNAME 32        # Executa a tarefa somente para o grupo 32
  
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
      echo "versão: $VERSION" 
      exit;;

	*);;
esac
}
#


startLog () {
	datelog=$(date "+%h %d-%m-%Y %H:%M:%S")
	pidlog=$(pgrep $APPNAME | tail -n1 )

echo "<warning>
    <line1>'>'</line1>
    <line2>Starting task...</line2>
    <line3>Running script!</line3>
    <line4>Reading database...</line4>
    <line5>Archive last information...</line5>
</warning>" > "$grouplocal"warning.xml
}
#
finishLog () {
	datelog=$(date "+%h %d-%m-%Y %H:%M:%S")
echo "<warning>
    <line1>Reading database...</line1>
    <line2>Archive last information...</line2>
    <line3>Updated group '$number' '$group'! </line3>
    <line4>Task end.</line4>
    <line5>Waiting next update!</line5>
</warning>" > "$grouplocal"warning.xml			
}
#
waitupdateLog () {
echo "<warning>
    <line1></line1>
    <line2></line2>
    <line3>Waiting next update! </line3>
    <line4></line4>
    <line5></line5>
</warning>" > "$grouplocal"warning.xml
}
#





export_infodash () {

   #Get XML format information for Panel On and OFF 
# "$baseDIR_LIB"infodash.sh "$list_group" | tail -n13 > "$grouplocal"infodash.xml
 "$baseDIR_LIB"infodash.sh "$simbadr_group" | tail -n13 > "$grouplocal"infodash.xml

 "$baseDIR_LIB"grpinfor.sh -a > "$TEMP_LOCAL_SIMBADR/"statusinfo.xml

echo "<lastupdate>" > "$TEMP_LOCAL_SIMBADR/"lastupdate.xml
grep lastTime "$grouplocal"infodash.xml >>  "$TEMP_LOCAL_SIMBADR/"lastupdate.xml
echo "</lastupdate>" >> "$TEMP_LOCAL_SIMBADR/"lastupdate.xml

}

# Begin
choose $argumentos



for groupList in $@
	do
	# echo $groupList
	startLog

  number=$groupList
  device=$("$baseDIR_LIB"rinfodevice.sh -d)
   group=$("$baseDIR_LIB"rinfogrp.sh -"$number")
         # "$baseDIR_LIB"reports.sh $number 
          "$baseDIR_LIB"blocksxml.sh "$number" "$group" "$device"
echo "$number" >>  "$TEMP_LOCAL_SIMBADR/"number.txt
	finishLog
	waitupdateLog
	done

	export_infodash
	cp "$TEMP_LOCAL_SIMBADR/"statusinfo.xml "$grouplocal"statusinfo.xml  
   cp "$TEMP_LOCAL_SIMBADR/"lastupdate.xml "$grouplocal"lastupdate.xml
exit
# End
