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
#  Copyright (c)2019-2023 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#  Required: simbadr-read-conf.sh, rinfodevice.sh, rinfogrp.sh, blocksxml.sh, infodash.sh, grpinfor.sh
#
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2021out14"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (C)2019-2023 Eduardo M. Araujo."
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
  echo "$APPNAME version $VERSION $COPYRIGHT

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
 
 #cat "$grouplocal"infodash.xml

#cat "$grouplocal"infodash.xml

#total_g16=$("$baseDIR_LIB"infodash.sh 27 | head -n2 | grep -v "#" | cut -d "," -f 6 | cut -d" " -f2) && echo "    <voip>"$total_g16"</voip>" > /tmp/infodash_01.xml
#total_g15=$("$baseDIR_LIB"infodash.sh 26 | head -n2 | grep -v "#" | cut -d "," -f 6 | cut -d" " -f2) && echo "    <printer>"$total_g15"</printer>" > /tmp/infodash_02.xml

# Begin
  #"$baseDIR_LIB"infodash.sh "$number" | tail -9 | head -n5 > /tmp/infodash_head.xml
# End
  #"$baseDIR_LIB"infodash.sh "$number" | tail -4 > /tmp/infodash_toes.xml
# Merge
  #cat /tmp/infodash_head.xml /tmp/infodash_01.xml /tmp/infodash_02.xml /tmp/infodash_toes.xml >  "$grouplocal"infodash.xml

#"$baseDIR_LIB"grpinfor.sh -a > "$grouplocal"statusinfo.xml
"$baseDIR_LIB"grpinfor.sh -a > "$TEMP_LOCAL_SIMBADR/"statusinfo.xml

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
   
exit
# End
