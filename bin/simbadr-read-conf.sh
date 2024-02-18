#!/bin/bash
##################################################################
#  File: simbadr-read-conf.sh     Built: 201905161239
#  Version: 1.0.3                 Update 202312062029
#
#  Function: Read config file for Simbadr system.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2024 Eduardo M. Araujo.
#
#  This file is part the simbadr scripts tools collections.
#
#  Required: config.xml
#
#  Note: Old filename is rinfoconf.sh
#  
# created by manual script
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.2"
     BUILT="2019Mai16"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2024."
   CONTACT="Contact for email: <edocam@outlook.com>"
   AUTHLOG="/var/log/log_$$.log"


# Habilita a impressao de variaveis
debugVerbose=true
#

# Habilita as opcoes
argumentos=$@
#

# Configura o diretorio e configuração padrão
#dirconfig=$(grep lib  /etc/simbadr/config.xml | cut -d">" -f2 | cut -d"<" -f1)
baseDIR=/etc/simbadr/
#

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION $COPYRIGHT
 * Display config directory for ../config.xml *

Use: $APPNAME <option>

OPTION:
  -h, --help                   show this is information;
  -V, --version                show version number;
  -s, --setup                  display path from setup;
  -x, --exec                   display path from exec;      
  -l, --library                display path from lib;
  -b, --backup                 display path from backup;
  -f, --front-end              display path from front-end;
  -m, --xml-files              display path from Symbolic Link; 
  -y, --history                display path from history;
  -q, --qr-codes               display path from qrcode;  
  -r, --reports                display path from Reports;   
  -d, --images-device          display path from Devices images or icons default;
  -n, --images-network         display path from Network images or icons ;
  -e, --images-enterprise      display path from Enterprise imagens or icons customized;
  -H, --helper                 display path from help;
  -g, --global                 display path from config device global; 
  -X, --group[X]               display path from X group,(ex.:-1 or --group01/-32 ou group32);
  -99 | --group99              display path from group temp 99;

 Example:
       $APPNAME  --setup
       $APPNAME  -14
       $APPNAME  --group09

$CONTACT"
      exit 0
}
#

#
function pathGroupConfig () {
  	numberGroup=$1
	grep  \<group"$numberGroup"\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1
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

     -s | --setup )
      
      	grep  \<setup\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;

     -x | --exec )
      
      	grep  \<exec\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;

     -r | --reports )
      
      	grep  \<reports\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;

     -q | --qr-codes )
      
      	grep  \<qrcodes\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;

     -l | --library )

			grep  \<library\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;
			
     -b | --backup )
		
			grep  \<backup\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;
			
     -f | --front-end )
	
			grep  \<front-end\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;

     -y | --history )
	
			grep  \<history\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;
			
     -e | --images-enterprise )
			
			grep  \<enterprise\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;

     -d | --images-device )
			
			grep  \<devices\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;

     -n | --images-network )
			
			grep  \<network\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;

     -H | --helper )
		
			grep  \<help\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;

	  -m | --xml-files )
		
			grep  \<xml-files\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;

     -0 | -00 | -g | --global )

			grep  \<global\>  "$baseDIR"config.xml  | cut -d">" -f2 | cut -d"<" -f1;;
			
     -1 | -01 | --group01 )
			
			pathGroupConfig "01" ;;
		
     -2 | -02 | --group02 )
			
			pathGroupConfig "02" ;;
			
     -3 | -03 | --group03 )

			pathGroupConfig "03" ;;
			
     -4 | -04 | --group04 )
			
			pathGroupConfig "04" ;;
			
     -5 | -05 | --group05 )

			pathGroupConfig "05" ;;
			
     -6 | -06 | --group06 )

			pathGroupConfig "06" ;;
			
     -7 | -07 | --group07 )
		
			pathGroupConfig "07" ;;
			
     -8 | -08 | --group08 )
			
			pathGroupConfig "08" ;;
			
     -9 | -09 | --group09 )
		
			pathGroupConfig "09" ;;
			
     -10 | --group10 )
			
			pathGroupConfig "10" ;;
			
     -11 | --group11 )
			
			pathGroupConfig "11" ;;
			
     -12 | --group12 )
			
			pathGroupConfig "12" ;;
			
     -13 | --group013 )
			
			pathGroupConfig "13" ;;
			
     -14 | --group14 )
     
			pathGroupConfig "14" ;;
			
     -15 | --group15 )
			
			pathGroupConfig "15" ;;

     -16 | --group16 )

			pathGroupConfig "16" ;;

     -17 | --group17 )
			
			pathGroupConfig "17" ;;
			
     -18 | --group18 )
     
			pathGroupConfig "18" ;;
						
     -19 | --group19 )
     
			pathGroupConfig "19" ;;
			
     -20 | --group20 )

			pathGroupConfig "20" ;;
			
     -21 | --group21 )

			pathGroupConfig "21" ;;

     -22 | --group22 )
     
			pathGroupConfig "22" ;;
			
     -23 | --group23 )

			pathGroupConfig "23" ;;
					
     -24 | --group24 )

  			pathGroupConfig "24" ;;
		
     -25 | --group25 )
		
			pathGroupConfig "25" ;;
			
     -26 | --group26 )
		
			pathGroupConfig "26" ;;

     -27 | --group27 )

			pathGroupConfig "27" ;;
				
     -28 | --group28 )
			
			pathGroupConfig "28" ;;
			
     -29 | --group29 )
     
			pathGroupConfig "29" ;;
			
     -30 | --group30 )
     		
     		pathGroupConfig "30" ;;
			
     -31 | --group31 )
						
			pathGroupConfig "31" ;;
			
     -32 | --group32 )
     
     		pathGroupConfig "32" ;;

     -90 | --group90 )

  			pathGroupConfig "90" ;;
		
     -91 | --group91 )
		
			pathGroupConfig "91" ;;
			
     -92 | --group92 )
		
			pathGroupConfig "92" ;;

     -93 | --group93 )

			pathGroupConfig "93" ;;
				
     -94 | --group94 )
			
			pathGroupConfig "94" ;;
			
     -95 | --group95 )
     
			pathGroupConfig "95" ;;
			
     -96 | --group96 )
     		
     		pathGroupConfig "96" ;;
			
     -97 | --group97 )
						
			pathGroupConfig "97" ;;
			
     -98 | --group98 )
     
     		pathGroupConfig "98" ;;

     -99 | --group99 )
			
			pathGroupConfig "99" ;;

	*);;
esac
}
#

# Begin
choose $argumentos
# End
