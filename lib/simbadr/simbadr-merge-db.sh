#!/bin/bash
##################################################################
#  File: simbadr-merge-db.sh 	       Built: 202209261146
#  Version: 0.0.1
#
#  Merge simbadrdb
#
#  Required: contact.list, hostname.list, inventory.list, system.list, vendor.list
#
#  Note:
#                  ---------------------------
#  Copyright (c)2022-2023 Eduardo M. Araujo..
##################################################################
   APPNAME=$(basename $0)
   VERSION="0.0.1"
     BUILT="2022set26"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c) 2022 Eduardo M. Araujo."
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG="/var/log/log_$$.log"


# Habilita a impressao de variaveis
debugVerbose=false
#

# Habilita as opcoes
argumentos=$@
#

simbadrdb_DIR=$(simbadr-read-conf.sh -92)
simbadrdb_TEMP_DIR=$(simbadr-read-conf.sh -91)

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION $COPYRIGHT"
  echo ""
  echo " * Consulta Algo ou faz algo  *"
  echo ""
  echo "Uso: $APPNAME [opções] <argumentos> {alvo} "
  echo ""
  echo "OPÇÕES:"
  echo "  -h, --help         apresenta esta informação para ajuda e finaliza;"
  echo "  -V, --version      mostra a versão atual;"
  echo "  -s, --system       usado para fazer outra coisa;"
  echo ""
  echo " Exemplos:"
  echo "       $APPNAME  -V            # faz isso ..."
  echo "       $APPNAME  -h            # faz isso ..."
  echo "       $APPNAME                # faz isso ..."
  echo ""
  echo ""
  echo "$CONTACT"
      exit 0
}
#
# Debug print
function debug_console () {
if [ "$debugVerbose" = true ]
   then
      echo ""
      echo "$APPNAME"
      echo "=== init DEBUG ==="
      echo " file_list_name --> "$file_list_name
      echo " file_sort_list --> "$file_list_name
      echo " group_name --> "$group_name
      echo " type_name --> "$type_name
      echo " folder --> "$folder
      echo "=== END ==="
      echo ""
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
      echo "versão: $VERSION" ;;

     -s | --ip-address )
      echo "origem do ip" ;;

	*);;
esac
}
#


# Begin
choose $argumentos
debug_console


while IFS="," read -r hostIPAddress 
do

ipaddress_=$hostIPAddress

#ipaddress_="172.16.255.2"

locate_ip=$(echo $ipaddress_ | cut -d "," -f "1")

file_merge_in=$2

echo $locate_ip
echo $file_merge_in
echo "$simbadrdb_DIR""$file_merge_in".list


grep -w "$locate_ip" "$simbadrdb_DIR""$file_merge_in".list
#line_read_ip_INVENTORY=$(grep -w "$locate_ip" "$simbadrdb_DIR"inventory.list) 
#line_read_ip_SYSTEM=$(grep -w "$locate_ip" "$simbadrdb_DIR"system.list) 
#line_read_ip_NETWORK=$(grep -w "$locate_ip" "$simbadrdb_DIR"network.list) 
#line_read_ip_VENDOR=$(grep -w "$locate_ip" "$simbadrdb_DIR"vendor.list) 
#line_read_ip_CONTACT=$(grep -w "$locate_ip" "$simbadrdb_DIR"contact.list) 


if [ $? = 0 ]
	then
	 #echo "encontrou" 
	 grep -w "$locate_ip" "$simbadrdb_DIR""$file_merge_in".list >> /tmp/"$file_merge_in".lock
	 #exit
	else
	grep -w "$locate_ip" "$simbadrdb_TEMP_DIR""$file_merge_in".tmp >> /tmp/"$file_merge_in".lock
   #echo "nao encontrou!!"
    
	fi 

done < $1

sort -u /tmp/"$file_merge_in".lock >> /tmp/"$file_merge_in".list
echo "/tmp/""$file_merge_in"" file closed!"
read -p 'would you like to update the file  '$file_merge_in' list now (yes or no)?' choice

if [ $choice = "yes" ]
	then
	 #backup_simbadrdbXML=$(date "+%s")
	 #mv $baseDIR_DB"simbadrdb.xml" $baseDIR_DB"simbadrdb."$backup_simbadrdbXML
	 cp /tmp/"$file_merge_in".list $simbadrdb_DIR"/"
   else
    echo "The files list to be at /tmp/ yet! "
   	exit
   fi	

# End
