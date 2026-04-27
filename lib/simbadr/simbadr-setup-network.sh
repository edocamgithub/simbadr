#!/bin/bash
##################################################################
#  File: simbadr-add-network.sh    Built: 202604230707
#  Version: 0.0.2        Update
#
#  Function: Export Network list for XML file 
##################################################################
#  Copyright (c)2019-2026 Eduardo M. Araujo..
#
#  This file is part the  Simbadr scripts tools collections.
#
#  Required: simbadr-read-conf.sh;network.xml
#
#  Note: 
#
# created by template_bash.sh
##################################################################
 
    APPNAME=$(basename $0)
    VERSION="0.0.2"  
      BUILT="2026April23"
     AUTHOR="Eduardo M. Araujo."
  COPYRIGHT="Copyright (C)2019-2026"
    CONTACT="Contact for email: <edocam@outlook.com>"

# Folders base
baseDIR=$(simbadr-read-conf.sh -g)
baseDIR_barra=$(echo $baseDIR | cut -d"/" -f1-7)
baseDIR_LIB=$(simbadr-read-conf.sh --library)
baseExec=$(simbadr-read-conf.sh --exec)
    baseLOG=$(simbadr-read-conf.sh --backup)
baseSetup=$(simbadr-read-conf.sh --setup)
  AUTHLOG="$baseLOG"simbadr.log
     TEMP_LOCAL_SIMBADR="/tmp/simbadr"
#

# Enable variable display 
debugVisible=$(grep debugVisible $baseSetup"simbadr" | cut -d"=" -f"2")
if test -z $debugVisible || test $debugVisible = "0"
then
		debugVisible=false
	fi
#

# Enable options
argumentos=$@
#

# Setup file for networks
setupDB="$baseSetup/network.xml"
#

# Limited 32 block of network
limitedNumberOfNetworks=4
#

function testBin () {
  which $1 > /dev/null
                if test $? -ne 0;
                        then
                                #echo "     =====>  " $1 " - not found!"
                                skipStep="1" 
                                else
                                skipStep="0"
                        fi
}

# Verify ipcalc command 
# apt install ipcalc (Debian or Ubuntu)
  testBin ipcalc
#

# Verify directory  DIR=tmp/simbadr/
if test -d $TEMP_LOCAL_SIMBADR
	then
  		echo "/tmp/simbadr not found!" >/dev/null
	else
  		mkdir $TEMP_LOCAL_SIMBADR
	fi

	    parameterV1=$1
	     
# Logs
function log_ () {
	PIDexec=$(pgrep -f $APPNAME)
	DATEpid=$(date "+%b %d %T")

logs_simbadr=$(echo "$DATEpid, PID ($PIDexec), exec_file --> $APPNAME,  \
                     parameterV1 --> $parameterV1, \
			         baseDIR_LIB --> $baseDIR_LIB")

if test $debugVisible = "true" || test $debugVisible = 1
	then

	log_debug_include=$(echo -e " $baseDIR\n $baseDIR_barra\n $baseDIR_LIB\n $baseExec\n $baseLOG\n \
	                             $baseSetup\n $AUTHLOG\n $TEMP_LOCAL_SIMBADR\n  \
								 Enable options = $argumentos\n  Limited $limitedNumberOfNetworks \
                 block of network = $networkUse spare  skipStep = $skipStep \n")
	fi
}
#


function debug_log ()
{
log_
if  [ $debugVisible = "false" ] 
 	then
	    echo $logs_simbadr  >> $AUTHLOG 2>> $AUTHLOG
		else
		#echo -e $file_list_name, $group_name, $type_name, $folder >> $AUTHLOG 2>>/dev/null
	    echo -e $logs_simbadr " *debugging* --> " $log_debug_include >> $AUTHLOG 2>>/dev/null  

	fi
}

# Use correct of script
help_manual() {
  echo "$APPNAME version $VERSION 
$COPYRIGHT $AUTHOR

  * Export XMLfiles *

Usage: $APPNAME <list | add | list | remove | > 

OPTION:
  -h, --help       show this is information;
  -V, --version    show number version;
  -l, --list       show list of networks
  -a, --add        add new network for list
  -r, --remove     remove network for list 
      --erase      erase list  
Example:
   $APPNAME  list  # Export a output XML list 
  
$CONTACT"
      exit 0
}
#

exportNetwork()
{
echo -e "<domain>" > $TEMP_LOCAL_SIMBADR/simbadrSetupNetwork.conf
xpath -q -e 'domain' -e 'network'   "$setupDB" >> $TEMP_LOCAL_SIMBADR/simbadrSetupNetwork.conf 2>>/dev/null
echo -e '<network name="'$youNameNetwork'" >
   <subnet>'$youNetwork'</subnet>
   <netmask>'$youMaskNetwork'</netmask>
</network>\n</domain>' >> $TEMP_LOCAL_SIMBADR/simbadrSetupNetwork.conf
cp -f $TEMP_LOCAL_SIMBADR/simbadrSetupNetwork.conf $setupDB

}

templateListNetwork ()
{
echo "<?xml version="1.0" encoding="UTF-8" ?>
<domain>
  <network name="VLAN1" >
   <subnet>172.16.0.0</subnet>
   <netmask>255.255.0.0</netmask>
  </network>
  
  <network name="LAN">
   <subnet>172.16.0.0</subnet>
   <netmask>255.255.0.0</netmask>
  </network>

 <network name="WAN">
   <subnet>172.16.0.0</subnet>
   <netmask>255.255.0.0</netmask>
  </network>

 <network name="PAN">
   <subnet>172.16.0.0</subnet>
   <netmask>255.255.0.0</netmask>
  </network>
</domain>
serial=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)

"
}

callListNameNetork()
{
networkListName=$(xpath -q -e 'domain' -e 'network/@name' "$setupDB" | cut -d'"' -f2)
#echo $networkListName
}

verifyLimitsForNetworks()
{
numberNets=$(xpath -q -e 'domain' -e 'network/@name'   "$setupDB" | wc -l)
let networkUse=$limitedNumberOfNetworks-$numberNets
}

listNetwork()
{
verifyLimitsForNetworks

echo -e " List of networks registers - MAX $limitedNumberOfNetworks Networks"
echo -e " Ready to use "$networkUse "networks\n"

xpath -q -e 'domain' -e 'network'   "$setupDB" 2>> /dev/null
}

updateAfterRemovedNetwork()
{
echo -e "<domain>" > $TEMP_LOCAL_SIMBADR/simbadrSetupNetwork.conf

for idx in $removeNetworkListName
do
xpath -q -e 'domain' -e 'network[@name="'$idx'"]'   "$setupDB" >> $TEMP_LOCAL_SIMBADR/simbadrSetupNetwork.conf
done

echo -e '\n</domain>' >> $TEMP_LOCAL_SIMBADR/simbadrSetupNetwork.conf
cp -f $TEMP_LOCAL_SIMBADR/simbadrSetupNetwork.conf $setupDB

}

removeNetwork()
{
callListNameNetork
echo $networkListName

read -p " Enter with network for remove: " youNetwork
if test -z $youNetwork ; then 
   exit ;  fi

removeNetworkListName=$(echo $networkListName | sed 's/'$youNetwork'//')
updateAfterRemovedNetwork

}




addNetwork()
{

verifyLimitsForNetworks
if [ $networkUse = 0 ]
then
  echo "Maximum limit!!"
  exit
fi

read -p " Enter your network: " youNetwork
if test -z $youNetwork ; then 
   exit ;  fi
read -p "       Network mask: " youMaskNetwork
if test -z $youMaskNetwork ; then 
   exit ; fi
read -p "   Name for network: " youNameNetwork
if test -z $youNameNetwork ; then 
   exit ; 
   fi

callListNameNetork
echo $networkListName | grep -w $youNameNetwork

if test $? = 0 ; then 
   echo "Existing name!!!"
   exit ;
    fi


if test $skipStep = "0"  
then
ipcalc $youNetwork $youMaskNetwork
else
echo -e "==> Network setup:  $youNetwork Netmask: $youMaskNetwork Name: $youNameNetwork"

fi
read -p "Is this correct (Y/N)?" chooseYesOrNo

 

case "$chooseYesOrNo" in
    
     Y | y )
      echo "correct!" 
      exportNetwork
      ;;

	   n | N )
      echo "no correct!"
      addNetwork     ;;

	  	*)
	    exit
  		;;
esac
}


# Argumments
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
      echo "versão: $VERSION" ;;

	 -l | --list | -L )
      listNetwork ;;

	 -a | --add )
      addNetwork ;;

	 -r | --remove )
      removeNetwork ;;  


	  --erase )
      cat /etc/simbadr/network.xml >> /tmp/simbadr/network.xml.bkp
      echo "" > /etc/simbadr/network.xml ;;

  	*)
	parameterV1="error"
  		;;
esac
}
#

# Begin	
	choose $argumentos
	debug_log

	#debug_log
	exit
# End
