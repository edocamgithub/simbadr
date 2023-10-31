#!/bin/bash
##################################################################
#  File: ginfoconf.sh 	       Built: 201905161230
#  Version: 1.0.2
#
#  Function: Make XML Files for Simbadr.
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2021 Eduardo M. Araujo..
#
#  This file is part the Simbadr scripts tools collections.
#
#
#  Required: Permission for writer on directory 
#
#  Note: This is make file, config.xml; device.xml; groups.xml;  images.xml; snmp.xml
#
#                   ---------------------------
#
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.0"
     BUILT="2020Out4"
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
 
* Gera a saída padrão de configurações *
 
Uso: $APPNAME [opções]
  
OPÇÕES:
  -h, --help         apresenta esta informação para ajuda e finaliza;
  -V, --version      mostra a versão atual;
  -c, --config       gera a saída padrão para o arquivo config.xml
                     com o diretório base em /opt/; 
  -r, --rootDIR      gera a saída padrão para o arquivo config.xml
                     com o diretório base em /;
  -d, --devices      gera a saída padrão para o arquivo devices.xml;
  -i, --images       gera a saída padrão para o arquivo images.xml;
  -g, --groups       gera a saída padrão para o arquivo groups.xml;
  -s, --snmp         gera a saída padrão para o arquivo snmp.xml;
 
Exemplos:
   $APPNAME  --config               # mostra na tela a saída padrão.
   $APPNAME  -i > images.xml        # redireciona para o arquivo images.xml.
   $APPNAME  --groups > groups.xml  # redireciona para o arquivo groups.xml.
  
$CONTACT"
      exit 0
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
      echo "versão: $VERSION" ;;
         
     -c | --config ) 
       base="/opt/simbadr/"
       baseExec=$base
		 exportConfig  $base ;;
		
	  -r | --rootDIR )
	    base="/"
	    baseExec="/usr/local/"
		 exportConfig $base $baseExe ;;
	  
	  -d | --devices )

echo '<?xml version="1.0" encoding="UTF-8" ?>'
echo '<!-- file setup devices.xml for Simbadr serial='$just' -->'
echo "<list>"
echo '	<device alias="ws">Workstation</device>'
echo '	<device alias="sr">Server</device>'
echo '	<device alias="pr">Printer</device>'
echo '	<device alias="sw">Switch</device>'
echo '	<device alias="ap">Access Point</device>'
echo '	<device alias="st">Site</device>'
echo '	<device alias="ms">Mobile Station</device>'
echo '	<device alias="sp">Smartphone</device>'
echo '	<device alias="tb">Tablet</device>'
echo '	<device alias="ph">VoIP phone</device>'
echo "</list>"
;;

		-i | --images )

echo '<?xml version="1.0" encoding="UTF-8" ?>'
echo '<!-- file setup images.xml for Simbadr serial='$just' -->'
echo "<imageStandard>"
echo ""	
echo '   <deviceHost status="0" content="image/png" description="Imagem com status indefinido">device.png</deviceHost>'
echo '   <deviceHost status="1" content="image/png" description="Imagem com status desligado (black)">statusOFF.png</deviceHost>'
echo '   <deviceHost status="2" content="image/png" description="Imagem com status ligado (green)">statusON.png</deviceHost>'
echo '   <deviceHost status="3" content="image/png" description="Imagem com status Games1 (green)">game.png</deviceHost>'
echo '   <deviceHost status="4" content="image/png" description="Imagem com status Games2 (yellow)">game2.png</deviceHost>'	
echo '   <deviceHost status="5" content="image/png" description="Imagem com status OK (green)">statusOK.png</deviceHost>'
echo ""
echo '   <devicePrinter status="0" content="image/png" description="Imagem com status StandBy">printer0.png</devicePrinter>'
echo '   <devicePrinter status="1" content="image/png" description="Imagem com status Tonner 100%">printer100t.png</devicePrinter>'
echo '   <devicePrinter status="2" content="image/png" description="Imagem com status Tonner 50%">printer50t.png</devicePrinter>'
echo '   <devicePrinter status="3" content="image/png" description="Imagem com status Alert (yellow)">printer00t.png</devicePrinter>'
echo '   <devicePrinter status="4" content="image/gif" description="Animação com status Alert GIF">printer_st2.gif</devicePrinter>'
echo '   <devicePrinter status="5" content="image/gif" description="Animação com status Working GIF">a_printer2.gif</devicePrinter>'
echo ""			
echo '   <deviceSwitch status="0" content="image/png" description="Imagem com status desligado (gray)">switch0.png</deviceSwitch>'
echo '   <deviceSwitch status="1" content="image/png" description="Imagem com status ligado (gray)">switch1.png</deviceSwitch>'
echo '   <deviceSwitch status="2" content="image/png" description="Imagem com status desligado (black)">switch_.png</deviceSwitch>'
echo '   <deviceSwitch status="3" content="image/png" description="Imagem com status ligado (black)">switch.png</deviceSwitch>'
echo ""
echo '   <deviceCam status="0" content="image/png" description="Imagem com status da camera ligada">cam0.png</deviceCam>'
echo '   <deviceCam status="1" content="image/png" description="Imagem com status da camera desligada">cam1.png</deviceCam>'
echo '   <deviceCam status="2" content="image/gif" description="Animação com status da camera Working GIF">cam2.gif</deviceCam>'
echo ""
echo '   <hostLaptop status="0" content="image/png" description="Imagem com status Conectado">laptop_0.png</hostLaptop>'
echo '   <hostLaptop status="1" content="image/png" description="Imagem com status Desconectado">laptop_1.png</hostLaptop>'
echo '   <hostLaptop status="2" content="image/gif" description="Imagem com status OS Windows">laptop_2.png</hostLaptop>'
echo '   <hostLaptop status="3" content="image/png" description="Imagem com status OS BSD/Unix">laptop_3.png</hostLaptop>'
echo '   <hostLaptop status="4" content="image/png" description="Imagem com status OS MACOSX">laptop_4.png</hostLaptop>'
echo '   <hostLaptop status="5" content="image/gif" description="Imagem com status OS Linux">laptop_5.png</hostLaptop>'
echo '   <hostLaptop status="6" content="image/png" description="Imagem com status OS MAC Classic">laptop_6.png</hostLaptop>'
echo '   <hostLaptop status="7" content="image/png" description="Animação com status Working GIF">laptop_7.gif</hostLaptop>'
echo ""
echo '   <hostRetired status="0" content="image/png" description="Imagem com status Removido">desativado1.png</hostRetired>'
echo '   <hostRetired status="1" content="image/png" description="Imagem com status Removido">desativado2.png</hostRetired>'	
echo '   <hostRetired status="2" content="image/png" description="Imagem com status Removido">desativado3.png</hostRetired>'	
echo '   <hostRetired status="3" content="image/png" description="Imagem com status Removido">desativado4.png</hostRetired>'	
echo ""
echo '   <hostWorkstation status="0" content="image/png" description="Imagem com status old Workstation (gray)">workstation0.png</hostWorkstation>'
echo '   <hostWorkstation status="1" content="image/png" description="Imagem com status Workstation Desconectado (gray)">workstation1.png</hostWorkstation>'
echo '   <hostWorkstation status="2" content="image/png" description="Imagem com status Workstation Conectado (gray)">workstation2.png</hostWorkstation>'
echo '   <hostWorkstation status="3" content="image/png" description="Imagem com status Workstation Conectado (black)">workstation3.png</hostWorkstation>'
echo '   <hostWorkstation status="4" content="image/png" description="Animaçãocom status Working (GIF)">workstation4.gif</hostWorkstation>'
echo ""
echo '   <hostDeny status="0" content="image/gif" description="Animação com status Deny (bloqueado)">a_deny.gif</hostDeny>'
echo '   <hostAlert status="0" content="image/png" description="Imagem com status desligado (red)">statusOFF_2.png</hostAlert>'
echo '   <hostAlert status="1" content="image/png" description="Imagem com status Alerta ">warning.png</hostAlert>'
echo ""
echo '   <hostServer status="0" content="image/png" description="Imagem com status desligado (black)">serverOFF.png</hostServer>'
echo '   <hostServer status="1" content="image/png" description="Imagem com status ligado (white)">serverON.png</hostServer>'
echo '   <hostServer status="2" content="image/png" description="Imagem com status Working (gray)">serverworkbusy.png</hostServer>'
echo '   <hostServer status="3" content="image/png" description="Imagem com status VirtualServerOn ">serverworkON.png</hostServer>'
echo '   <hostServer status="4" content="image/png" description="Imagem com status VirtualServerOff ">serverworkOFF.png</hostServer>'
echo ""
echo '   <hostWeb status="0" content="image/png" description="Imagem com status Site WWW (black)">w3black.png</hostWeb>'
echo '   <hostWeb status="1" content="image/png" description="Imagem com status Site WWW (white)">w3white.png</hostWeb>'
echo '   <hostWeb status="2" content="image/png" description="Imagem com status Site WWW (red)">w3red.png</hostWeb>'
echo ""
echo '   <hostLinux status="0" content="image/png" description="Imagem com status Linux ON (white)">os_linux.png</hostLinux>'
echo '   <hostLinux status="1" content="image/png" description="Imagem com status Linux On (green)">os_linux2.png</hostLinux>'
echo '   <hostLinux status="2" content="image/gif" description="Animação com status Linux Working">a_os_linux.gif</hostLinux>'
echo ""
echo '   <hostBsd status="0" content="image/png" description="Imagem com status Bsd OFF (green)">os_openbsd_0.png</hostBsd>'
echo '   <hostBsd status="1" content="image/png" description="Imagem com status Bsd ON (red)">os_openbsd.png</hostBsd>'
echo '   <hostBsd status="2" content="image/gif" description="Animação com status Bsd (GIF)">a_os_openbsd.gif</hostBsd>'
echo ""
echo '   <hostWindows status="0" content="image/png" description="Imagem com status Windows ON (blue)">os_windows.png</hostWindows>'
echo '   <hostWindows status="1" content="image/gif" description="Animação com status Windows (GIF)">a_os_windows.gif</hostWindows>'
echo ""
echo '   <hostMac status="0" content="image/png" description="Imagem com status Mac OFF (black)">macOFF.png</hostMac>'
echo '   <hostMac status="1" content="image/png" description="Imagem com status Mac ON (yellow)">macTYPE2.png</hostMac>'
echo '   <hostMac status="2" content="image/gif" description="Animação com status Mac Working (GIF)">a_macTYPE2.gif</hostMac>'
echo ""
echo '   <hostPhoneIP status="0" content="image/png" description="Imagem com status IP phone Conectado (white)">phoneip.png</hostPhoneIP>'
echo '   <hostPhoneIP status="1" content="image/png" description="Imagem com status IP phone Desconectado (red cross)">phoneip2.png</hostPhoneIP>'
echo '   <hostPhoneIP status="2" content="image/gif" description="Animação com status IP phone (GIF)">phoneip.gif</hostPhoneIP>'
echo ""
echo '   <deviceXbox status="0" content="image/png" description="Imagem com status Xbox Conectado">xbox0.png</deviceXbox>'
echo '   <deviceXbox status="1" content="image/png" description="Imagem com status Xbox Desconectado">xbox1.png</deviceXbox>'
echo ""
echo '   <devicePlaystation status="0" content="image/png" description="Imagem com status PlayStation Conectado">ps0.png</devicePlaystation>'
echo '   <devicePlaystation status="1" content="image/png" description="Imagem com status PlayStation Desconectado">ps1.png</devicePlaystation>'
echo ""
echo '   <deviceWii status="0" content="image/gif" description="Imagem com status Nintendo Wii Conectado">wii0.png</deviceWii>'
echo '   <deviceWii status="1" content="image/gif" description="Imagem com status Nintendo Wii Desconectado">wii1.png</deviceWii>'
echo ""
echo '   <deviceAp status="0" content="image/png" description="Imagem com status antena desligado">antena1.png</deviceAp>'
echo '   <deviceAp status="1" content="image/png" description="Imagem com status antena ligado">antena1_0.png</deviceAp>'
echo '   <deviceAp status="2" content="image/gif" description="Animação com status antena Working GIF">antena1.gif</deviceAp>'
echo ""	
echo "</imageStandard>"
;;

		-g | --groups )

echo '<?xml version="1.0" encoding="UTF-8" ?>'
echo '<!-- file setup groups.xml for Simbadr serial='$just' -->'
echo "<groups>"
echo '   <name alias="00">GLOBAL</name>'

for i in {1..9}
	do
		echo '   <name alias="0'$i'">NOME0'$i'</name>'		
	done

for i in {10..32}
	do
	   echo '   <name alias="'$i'">NOME'$i'</name>'				
	done

for i in {90..98}
	do
	   echo '   <name alias="'$i'">SYSTEM'$i'</name>'				
	done
	
echo '   <name alias="99">REPORTS</name>'
echo "</groups>"
;;


		-s | --snmp )

echo '<?xml version="1.0" encoding="UTF-8" ?>'
echo '<!-- file setup snmp.xml for Simbadr serial='$just' -->'
echo "<version>"
echo '   <infobasic>'
echo '       <sysDescr oid=".1.3.6.1.2.1.1.1.0">iso.org.dod.internet.mgmt.mib-2.system.sysDescr.0</sysDescr>'	
echo '       <sysContact oid=".1.3.6.1.2.1.1.4.0">iso.org.dod.internet.mgmt.mib-2.system.sysContact.0</sysContact>'
echo '       <sysName oid=".1.3.6.1.2.1.1.5.0">iso.org.dod.internet.mgmt.mib-2.system.sysName.0</sysName>'	  
echo '       <sysLocation oid=".1.3.6.1.2.1.1.6.0">iso.org.dod.internet.mgmt.mib-2.system.sysLocation.0</sysLocation>' 	
echo '       <hrSystemUptime oid=".1.3.6.1.2.1.25.1.1.0">iso.org.dod.internet.mgmt.mib-2.25.hrSystemUptime.0</hrSystemUptime>'
echo '       <hrSystemDate oid=".1.3.6.1.2.1.25.1.2.0">iso.org.dod.internet.mgmt.mib-2.25.hrSystemDate.0</hrSystemDate>'
echo '       <hrSystemNumUsers oid=".1.3.6.1.2.1.25.1.5.0">iso.org.dod.internet.mgmt.mib-2.25.hrSystemNumUsers.0</hrSystemNumUsers>'
echo '       <hrSystemProcesses oid=".1.3.6.1.2.1.25.1.6.0" >iso.org.dod.internet.mgmt.mib-2.25.hrSystemProcesses.0</hrSystemProcesses>'
echo '   </infobasic>'
echo '   <oid osid="windows"></oid>'
echo '   <oid osid="bsd"></oid>'
echo '   <oid osid="linux"></oid>'
echo '   <oid osid="mac"></oid>'
echo '   <snmp version="v1"></snmp>'
echo '   <snmp version="v2c"></snmp>'
echo '<snmp version="v3"></snmp>'
echo "</version>"
;;

		-t | --task-execution )
		
echo "<?xml version="1.0" encoding="UTF-8" ?>
<!-- file setup schedule.xml for  Simbadr serial="$just" -->
<program>
	<verify>
		<long time="36000" report="no" comment="60min">01, 02, 03</long>
		<normal time="6000" report="yes" comment="10min">01, 02, 03</normal>	
		<mean time="3000" report="no" comment="5min">01, 02, 03</mean>
		<fast time="60" report="yes" commment="1min">01, 02, 03</fast>
	</verify>
</program> "
;;

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
exportConfig () {

baseDir=$base
execDir=$baseExec

echo "<?xml version="1.0" encoding="UTF-8" ?>
<!-- file setup config.xml for Simbadr serial="$just" -->
<config>
   <exec>"$baseExec"bin/</exec>
   <library>"$baseDir"lib/simbadr/</library>
   <backup>"$baseDir"var/log/simbadr/backup/</backup>
   <front-end>"$baseDir"var/www/html/simbadr/</front-end>
   <xml-files>"$baseDir"var/www/html/simbadr/xml/</xml-files>
   <reports>"$baseDir"var/log/simbadr/reports/</reports>
   <images>
      <devices>"$baseDir"var/www/images/devices/</devices>
      <enterprise>"$baseDir"var/www/images/enterprise/</enterprise>
      <network>"$baseDir"var/www/images/network/</network>
   </images>   
   <help>"$baseDir"share/simbadr/tutorial/</help>
   <setup>/etc/simbadr/</setup>
   <history>"$baseDir"var/log/simbadr/history/</history>
   <groups>
      <global>"$baseDir"var/log/simbadr/blocks/00/</global>"

for i in {1..9}
	do
		echo "      <group"0$i">"$baseDir"var/log/simbadr/blocks/0$i/</group"0$i">"		
	done
 
 
for i in {10..32}
	do
		echo "      <group"$i">"$baseDir"var/log/simbadr/blocks/$i/</group"$i">"		
	done

for i in {90..99}
	do
		echo "      <group"$i">"$baseDir"var/log/simbadr/blocks/$i/</group"$i">"		
	done

echo "   </groups>	
</config>"

}
#


# Begin
choose $argumentos

# End
