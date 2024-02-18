#!/bin/bash
##################################################################
#  File: ginfoconf.sh    Built: 201905161230
#  Version: 1.1.0        Update 202312062029
#
#  Function: XML File creator for setup  
#
##################################################################
#  Copyright (c)2019-2024 Eduardo M. Araujo..
#
#  This file is part the simbadr scripts tools collections.
#
#  Required: simbadr-read-conf.sh for read setup
#
#  Note: Output config.xml;device.xml;groups.xml;images.xml;snmp.xml
#
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2020Out4"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log

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
  echo "$APPNAME version $VERSION 
$COPYRIGHT $AUTHOR
     * Output default XMLfile for configuration *
 
Usage: $APPNAME [opções]
  
OPTIONS:
  -h, --help         show this is information;
  -V, --version      show number version;
  -c, --config       output default for config.xml with DIR =  /opt/; 
  -r, --rootDIR      output default for config.xml with ROOT DIR =  /;
  -d, --devices      output default for devices.xml;
  -i, --images       output default for images.xml;
  -g, --groups       output default for groups.xml;
  -s, --snmp         output default for snmp.xml;
 
Example:
   $APPNAME  --config               # show config for default output;
   $APPNAME  -i > images.xml        # redirect for images.xml file (Note:  ../etc/simbadr/);
   $APPNAME  --groups > groups.xml  # redirect for groups.xml file ;
  
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
echo '<list>
<device alias="ws">Workstation</device>
<device alias="sr">Server</device>
<device alias="pr">Printer</device>
<device alias="sw">Switch</device>
<device alias="ap">Access Point</device>
<device alias="st">Site</device>
<device alias="ms">Mobile Station</device>
<device alias="sp">Smartphone</device>
<device alias="tb">Tablet</device>
<device alias="ph">VoIP phone</device>
<device alias="uk">Unknown</device>
<device alias="ev">Everything</device>
</list>'
;;

      -i | --images )

echo '<?xml version="1.0" encoding="UTF-8" ?>'
echo '<!-- file setup images.xml for Simbadr serial='$just' -->'
echo "<imageStandard>"
echo ""
echo '   <deviceHost status="0" content="image/png" description="Unknown device">device.png</deviceHost>'
echo '   <deviceHost status="1" content="image/png" description="Black color Off-line status icon">statusOFF.png</deviceHost>'
echo '   <deviceHost status="2" content="image/png" description="Green color On-line status icon">statusON.png</deviceHost>'
echo '   <deviceHost status="3" content="image/png" description="Green color Games1 status icon">game.png</deviceHost>'
echo '   <deviceHost status="4" content="image/png" description="Yellow color Games2 status icon">game2.png</deviceHost>'	
echo '   <deviceHost status="5" content="image/png" description="Green color status OK icon">statusOK.png</deviceHost>'
echo ""
echo '   <devicePrinter status="0" content="image/png" description="StandBy Printer status icon">printer0.png</devicePrinter>'
echo '   <devicePrinter status="1" content="image/png" description="Tonner or Ink 100% Printer status icon">printer100t.png</devicePrinter>'
echo '   <devicePrinter status="2" content="image/png" description="Tonner or Ink 50% Printer status icon">printer50t.png</devicePrinter>'
echo '   <devicePrinter status="3" content="image/png" description="Yellow color Alert Printer status icon">printer00t.png</devicePrinter>'
echo '   <devicePrinter status="4" content="image/gif" description="GIF Animation Alert Printer status">printer_st2.gif</devicePrinter>'
echo '   <devicePrinter status="5" content="image/gif" description="GIF Animation Working Printer status">a_printer2.gif</devicePrinter>'
echo ""
echo '   <deviceSwitch status="0" content="image/png" description="Gray color Off-line Switch status icon">switch0.png</deviceSwitch>'
echo '   <deviceSwitch status="1" content="image/png" description="Gray color On-line Switch status icon">switch1.png</deviceSwitch>'
echo '   <deviceSwitch status="2" content="image/png" description="Black color Off-line Switch status icon">switch_.png</deviceSwitch>'
echo '   <deviceSwitch status="3" content="image/png" description="Black color On-line Switch status icon">switch.png</deviceSwitch>'
echo ""
echo '   <deviceCam status="0" content="image/png" description="Security CAM On-line status icon">cam0.png</deviceCam>'
echo '   <deviceCam status="1" content="image/png" description="Security CAM Off-line status icon">cam1.png</deviceCam>'
echo '   <deviceCam status="2" content="image/gif" description="GIF Animation Working Security CAM status">cam2.gif</deviceCam>'
echo ""
echo '   <hostLaptop status="0" content="image/png" description="Connecting Laptop status icon">laptop_0.png</hostLaptop>'
echo '   <hostLaptop status="1" content="image/png" description="Desconneting Laptop status icon">laptop_1.png</hostLaptop>'
echo '   <hostLaptop status="2" content="image/gif" description="Laptop with System Windows">laptop_2.png</hostLaptop>'
echo '   <hostLaptop status="3" content="image/png" description="Laptop with System BSD/Unix">laptop_3.png</hostLaptop>'
echo '   <hostLaptop status="4" content="image/png" description="Laptop with System MACOSX">laptop_4.png</hostLaptop>'
echo '   <hostLaptop status="5" content="image/gif" description="Laptop with System GNU/Linux">laptop_5.png</hostLaptop>'
echo '   <hostLaptop status="6" content="image/png" description="Laptop with System MACos Classic">laptop_6.png</hostLaptop>'
echo '   <hostLaptop status="7" content="image/png" description="GIF Animation Working Laptop status">laptop_7.gif</hostLaptop>'
echo ""
echo '   <hostRetired status="0" content="image/png" description="Removed 0 status">desativado1.png</hostRetired>'
echo '   <hostRetired status="1" content="image/png" description="Removed 1 status">desativado2.png</hostRetired>'	
echo '   <hostRetired status="2" content="image/png" description="Removed 2 status">desativado3.png</hostRetired>'	
echo '   <hostRetired status="3" content="image/png" description="Removed 3 status">desativado4.png</hostRetired>'	
echo ""
echo '   <hostWorkstation status="0" content="image/png" description="Gray color Old Workstation status icon">workstation0.png</hostWorkstation>'
echo '   <hostWorkstation status="1" content="image/png" description="Gray color Desconected Workstation status icon">workstation1.png</hostWorkstation>'
echo '   <hostWorkstation status="2" content="image/png" description="Gray color Conected Workstation status icon">workstation2.png</hostWorkstation>'
echo '   <hostWorkstation status="3" content="image/png" description="Black color Conected Workstation status icon">workstation3.png</hostWorkstation>'
echo '   <hostWorkstation status="4" content="image/png" description="GIF Animation Workstation status">workstation4.gif</hostWorkstation>'
echo ""
echo '   <hostDeny status="0" content="image/gif" description="GIF Animation Deny status">a_deny.gif</hostDeny>'
echo '   <hostAlert status="0" content="image/png" description="Red color Off-line status icon">statusOFF_2.png</hostAlert>'
echo '   <hostAlert status="1" content="image/png" description="Alert status icon">warning.png</hostAlert>'
echo ""
echo '   <hostServer status="0" content="image/png" description="Black color Off-line Server status icon">serverOFF.png</hostServer>'
echo '   <hostServer status="1" content="image/png" description="White color On-line Server status icon">serverON.png</hostServer>'
echo '   <hostServer status="2" content="image/png" description="Gray color Busy Server status icon">serverworkbusy.png</hostServer>'
echo '   <hostServer status="3" content="image/png" description="Virtual Machine Server On-line status icon">serverworkON.png</hostServer>'
echo '   <hostServer status="4" content="image/png" description="Virtual Server Off-line status icon">serverworkOFF.png</hostServer>'
echo ""
echo '   <hostWeb status="0" content="image/png" description="Black color Server Web or Intranet status icon">w3black.png</hostWeb>'
echo '   <hostWeb status="1" content="image/png" description="White color Server Web or Intranet status icon">w3white.png</hostWeb>'
echo '   <hostWeb status="2" content="image/png" description="Red color Server Web or Intranet status icon">w3red.png</hostWeb>'
echo ""
echo '   <hostLinux status="0" content="image/png" description="White color GNU/Linux ON status icon">os_linux.png</hostLinux>'
echo '   <hostLinux status="1" content="image/png" description="Green color GNU/Linux ON status icon">os_linux2.png</hostLinux>'
echo '   <hostLinux status="2" content="image/gif" description="GIF Animation GNU/Linux status">a_os_linux.gif</hostLinux>'
echo ""
echo '   <hostBsd status="0" content="image/png" description="Green color BSD OFF status icon">os_openbsd_0.png</hostBsd>'
echo '   <hostBsd status="1" content="image/png" description="Red color BSD ON status icon">os_openbsd.png</hostBsd>'
echo '   <hostBsd status="2" content="image/gif" description="GIF Animation BSD status">a_os_openbsd.gif</hostBsd>'
echo ""
echo '   <hostWindows status="0" content="image/png" description="Blue color Windows ON status icon">os_windows.png</hostWindows>'
echo '   <hostWindows status="1" content="image/gif" description="GIF Animation Windows status icon">a_os_windows.gif</hostWindows>'
echo ""
echo '   <hostMac status="0" content="image/png" description="Black color MacOS OFF status icon">macOFF.png</hostMac>'
echo '   <hostMac status="1" content="image/png" description="Yellow color MacOS ON status icon">macTYPE2.png</hostMac>'
echo '   <hostMac status="2" content="image/gif" description="GIF Animation MacOS status">a_macTYPE2.gif</hostMac>'
echo ""
echo '   <hostPhoneIP status="0" content="image/png" description="White color Conected IP Phone status icon">phoneip.png</hostPhoneIP>'
echo '   <hostPhoneIP status="1" content="image/png" description="Red color Desconeted IP Phone status icon">phoneip2.png</hostPhoneIP>'
echo '   <hostPhoneIP status="2" content="image/gif" description="GIF Animation IP Phone status">phoneip.gif</hostPhoneIP>'
echo ""
echo '   <deviceXbox status="0" content="image/png" description="Conected Xbox status icon">xbox0.png</deviceXbox>'
echo '   <deviceXbox status="1" content="image/png" description="Desconected Xbox status icon">xbox1.png</deviceXbox>'
echo ""
echo '   <devicePlaystation status="0" content="image/png" description="Conected PlayStation status icon">ps0.png</devicePlaystation>'
echo '   <devicePlaystation status="1" content="image/png" description="Desconected PlayStation status icon">ps1.png</devicePlaystation>'
echo ""
echo '   <deviceWii status="0" content="image/gif" description="Conected Wii status icon ">wii0.png</deviceWii>'
echo '   <deviceWii status="1" content="image/gif" description="Desconected Wii status icon">wii1.png</deviceWii>'
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
		echo '   <name alias="0'$i'">NAME0'$i'</name>'		
	done

for i in {10..32}
	do
	   echo '   <name alias="'$i'">NAME'$i'</name>'				
	done

echo '   <name alias="90">OutOfGroup</name>'
echo '   <name alias="91">RESERVED1</name>'
echo '   <name alias="92">simbadrDB</name>'
echo '   <name alias="93">RESERVED2</name>'
echo '   <name alias="94">RESERVED3</name>'
echo '   <name alias="95">DISABLED</name>'
echo '   <name alias="96">BACKUP</name>'
echo '   <name alias="97">LABEL</name>'
echo '   <name alias="98">RESERVED4</name>'
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


	*);;
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
   <qrcodes>"$baseDir"var/log/simbadr/reports/qrcodes/</qrcodes>
   <images>
      <devices>"$baseDir"var/www/html/simbadr/images/devices/</devices>
      <enterprise>"$baseDir"var/www/html/simbadr/images/enterprise/</enterprise>
      <network>"$baseDir"var/www/html/simbadr/images/network/</network>
   </images>     
   <help>"$baseDir"share/simbadr/tutorial/</help>
   <setup>"$baseDir"etc/simbadr/</setup>
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
