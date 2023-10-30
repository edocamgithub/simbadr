#!/bin/bash
##################################################################
#  File: simbadr-read-conf.sh	       Built: 201905161239
#  Version: 1.0.2
#
#  Function: Read config file for Simbadr system.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2022 Eduardo M. Araujo.
#
#  This file is part the simbadr scripts tools collections.
#
#  Required: config.xml
#
#  Note: Old filename is rinfoconf.sh
#  
#                   ---------------------------
#
# created by manual script
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.0"
     BUILT="2019Mai16"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2021 Eduardo M. Araujo."
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

 * Retorna o diretório de configuração em config.xml *

Uso: $APPNAME <opções>

OPÇÕES:
  -h, --help                   apresenta esta informação para ajuda e finaliza;
  -V, --version                mostra a versão atual;
  -s, --setup                  retorna o diretório para o setup;
  -x, --exec                   retorna o diretório dos executáveis;      
  -l, --library                retorna o diretório das bibliotecas;
  -b, --backup                 retorna o diretório para backup;
  -f, --front-end              retorna o diretório do front-end;
  -m, --xml-files              retorna o diretório de destino para LinkSimbolicos; 
  -y, --history                retorna o diretório do history para relatórios;
  -q, --qr-codes               retorna o diretório de deposito do qrcode;  
  -r, --reports                retorna o diretório de deposito de Reposts;   
  -d, --images-device          retorna o diretório de imagens;
  -n, --images-network         retorna o diretório de imagens;
  -e, --images-enterprise      retorna o diretório de imagens;
  -H, --helper                 retorna o diretório de ajuda;
  -g, --global                 retorna o diretório global dos dispositivos; 
  -X, --group[X]               retorna o diretório para o grupo X,
                               (ex.: -1 ou --group01 até -32 ou group32);
  -99 | --group99              retorna o diretório do grupo temporário 99;

 Exemplos:
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
