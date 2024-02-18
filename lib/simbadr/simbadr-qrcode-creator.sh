#!/bin/bash
##################################################################
#  File: simbadr-qrcode-creator.sh 	        
#  Version: 1.0.1					 
#
#  Function: Import list cvs for database XML 
#                   ---------------------------
#  Required: /tmp/simbadr_ip.list with Number IP,  
#            simbadr-read-conf.sh, simbadrdb.xml
#                   
#  Note: Filename export to htmlfile    e.g.: /tmp/Efdkal.html
#
#  Use: ./simbadr-label-creator 80  
#                 ---------------------------
#
#  Written by Eduardo M. Araujo. - versão 1.0.1
#  Copyright (c)2022-2024 Eduardo M. Araujo..
#
##################################################################
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2022May06"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2022-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG="/var/log/log_$$.log"
 TEMP_LOCAL_SIMBADR="/tmp/simbadr/"
 
 etcConfig=$(simbadr-read-conf.sh -s)
 
# default="./var/log/simbadr/blocks/92/simbadrdb.xml"
 default="/opt/simbadr/tmp/qrcodenote.xml" 
 
# Manual de uso do script
help_manual() {
echo "$APPNAME version $VERSION
$COPYRIGHT $AUTHOR
* Export type html file with QRCode image for print label *
    
Usage: $APPNAME [options]
  
OPTION:
- for width and height on img TAG for HTML -

  80        setting on width and height equal 80;
  100       setting on width and height equal 100;
  150       setting on width and height equal 150;
               
Example:
      $APPNAME  80
      $APPNAME  150
       
Note:  echo 172.16.0.1 > /tmp/simbadr/simbadr_ip.list or complete list of IP 
   
$CONTACT"
     exit 0
}
#

if test -z $1 
	then
		echo "Choose: 80, 100 or 150!"
		echo "File not found --> "$TEMP_LOCAL_SIMBADR"simbadr_ip.list" 	
		help_manual
    	exit
	fi


option=$1

sizeQRCode=$1	 

reportDIR=$(simbadr-read-conf.sh -r)
qrcodeDIR=$(simbadr-read-conf.sh -q)

rm -f "$TEMP_LOCAL_SIMBADR"*.png
rm -f "$TEMP_LOCAL_SIMBADR"labelfoot.*
rm -f "$TEMP_LOCAL_SIMBADR"*.html

file_list_add=$(mktemp "$TEMP_LOCAL_SIMBADR"labellist.XXX)
file_HeadHtml=$(mktemp "$TEMP_LOCAL_SIMBADR"labelhead.XXX)
file_FootHtml=$(mktemp "$TEMP_LOCAL_SIMBADR"labelfoot.XXX)
file_ReportQrCodeHtml=$(mktemp "$TEMP_LOCAL_SIMBADR"XXXXXXXX.html)
file_LabelXML=$(mktemp "$TEMP_LOCAL_SIMBADR"XXXXXXXX.xml )


StyleQRCode150 () {

echo '<style>
 
#folha {
   margin: auto;
   } 
 
.labelBase {
   background-color: greenyellow;
   width: 155px;
   height: 178px;
   border: 4px   black;
   align-items: center;
   text-align: center;
   margin: 1px;
   float: left;
   }  

.labelHostname {
   color: black;           
	}
	 
.qrcodeLabel {
   width: 155px;
   height: 155px;
   align-items: center;
   margin-top: -15px;
   }	
	
p.a {
   word-break: break-all; 
	margin-top: -1px;	
   font-family: arial;
   font-size: 110%;
   font-weight: bold;
   }

p.b {
   padding-top: 1px;
   padding-right: 1px;	
   padding-left: 1px;	   
   }
</style> '
}


StyleQRCode100 () {
echo '<style>
 
#folha {
   margin: auto;
   } 
 
.labelBase {
   background-color: greenyellow;
   width: 105px;
   height: 115px;
   border: 4px   black;
   align-items: center;
   text-align: center;
   margin: 1px;
   float: left;
	}  

.labelHostname {
   color: black;
	 }
	 
.qrcodeLabel {
   width: 105px;./var/log/simbadr/blocks/92/simbadrdb.xml
	height: 105px;
	align-items: center;
	margin-top: -15px;
	}	
	
p.a {
   word-break: break-all; 
	margin-top: -5px;	
	font-family: arial;
	font-size: 81%;
	font-weight: bold;
   }

p.b {
   padding-top: 1px;
 	padding-right: 1px;	
 	padding-left: 1px;	   
   }
</style> '
	
}



StyleQRCode80 () { 

echo '<style>
 
#folha {
   margin: auto;
   } 
 
.labelBase {
   background-color: greenyellow;
   width: 84px;
   height: 100px;
   border: 4px   black;
   align-items: center;
   text-align: center;
   margin: 1px;
   float: left;
   }  

.labelHostname {
   color: black;
   }
	 
.qrcodeLabel {
   width: 84px;
   height: 120px;
   align-items: center;
   margin-top: -15px;
   }	
	
p.a {
   word-break: break-all; 
   margin-top: -40px;	
   font-family: arial;
   font-size: 81%;
  	font-weight: bold;
   }

p.b {
   padding-top: 1px;
   padding-right: 1px;	
   padding-left: 1px;	   
   }
</style> '
}

HeadHtml () {

echo '<!DOCTYPE html>
<html>
   <head> '


if [ $option -eq 150 ] 
	then
		StyleQRCode150
		elif [ $option -eq 100 ]
				then				
					StyleQRCode100		
				else
					StyleQRCode80
					fi						
	
echo '      <meta charset="utf-8" />
      <title>QRCode Label Simbadr</title>
   </head>
<body>'
}

FootHtml () {
echo '
</body>
</html>'
}


makeDivQRCode () {



echo '   <div class="labelBase" >
     <div class="qrcodeLabel">
        <p class="b"> 	
               <img src="/tmp/simbadr/'$xpath_hostname'.png" width="'$sizeQRCode'" height="'$sizeQRCode'" alt="">
        </p>
     </div>
        <p class="a">
               <span class="labelHostname">'$xpath_hostname'</span>
       </p>
     </div>' >> $file_list_add
}
  


  
while read idForIP
do

			##xpath  -e '/group/host[@id="'$idForIP'"]' ./var/log/simbadr/blocks/92/simbadrdb.xml > $file_LabelXML

			xpath  -e '/group/host[@id="'$idForIP'"]' "$default" > $file_LabelXML
		   
		   xpath_hostname_XML=$(xpath -q -e 'host/hostname' $file_LabelXML) 

   		xpath_hostname=$(echo $xpath_hostname_XML | cut -d ">" -f "2" | cut -d "<" -f "1")


   if [ "$2" = "full" ]
      then   
   	 		qrencode -m 3 -s 3 -r  $file_LabelXML  -o "$TEMP_LOCAL_SIMBADR"$xpath_hostname.png

      else 
        
        domainName=$(xpath -e 'network/domain' "$etcConfig"network.xml | cut -d ">" -f "2" | cut -d "<" -f "1")
        
        echo $domainName"/simbadr/php/device.php?host="$idForIP > /tmp/simbadr/texto.txt
        
        qrencode -m 3 -s 3 -r  /tmp/simbadr/texto.txt  -o "$TEMP_LOCAL_SIMBADR"$xpath_hostname.png
      
       fi 
      
   makeDivQRCode $idForIP

done < /tmp/simbadr/simbadr_ip.list


HeadHtml > $file_HeadHtml 
FootHtml > $file_FootHtml

cat $file_HeadHtml $file_list_add $file_FootHtml >  $file_ReportQrCodeHtml

chmod 444 $file_ReportQrCodeHtml

rm $file_HeadHtml $file_list_add $file_FootHtm $file_LabelXML
