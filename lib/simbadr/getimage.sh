#!/bin/bash
##################################################################
#  File: getimage.sh 	       Built: 201906101120
#  Version: 1.0.1
#
#  Function: Show a image path for Status file
#
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2021 Eduardo M. Araujo..
#
#  This file is part the  simbadr scripts tools collections.
#
#
#  Required: images.xml;simbadr-read-conf.sh
#
#  Note: 31jan2021 add security cameras, 23fev2021 add mobile, 20ago2021 add new workstation  
#  
#                   ---------------------------
#
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2019Jun10"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c) 2019-2021 Eduardo M. Araujo."
   CONTACT="Contact for email: <edocam@outlook.com>"
  baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log  
  #AUTHLOG="/var/log/log_$$.log"


# Habilita a impressao de variaveis
debugVisible=false
debugVerbose=false
#

# Habilita as opcoes
argumentos=$@
#

# Configura o diretorio e configuração padrão
dirconfig=$(simbadr-read-conf.sh --setup)
dirlocal=$(simbadr-read-conf.sh -d)
dirrelative=$(echo $dirlocal | sed 's/www/./')
#

# Log de variaveis
function log_ () {
PIDexec=$(pgrep $APPNAME)
DATEpid=$(date "+%b %d %T")
logs_simbadr=$(echo "$DATEpid, PID ($PIDexec), exec_file --> $APPNAME, description --> $descr, image (device/host) -->  $this, status -->  $numberstatus, local -->  $dirlocal, pathway -->  $dirlocal$this, dirconfig -->  $dirconfig")
}
#



# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION $COPYRIGHT
  
   * Retorna o nome do arquivo em image.xml  *
  
  Uso: $APPNAME <device> <status[0..x]> 
  
  OPÇÕES:
    -h, --help         apresenta esta informação para ajuda e finaliza;
    -V, --version      mostra a versão atual;
    --deviceAp         dispositivo Access Point;
    --deviceHost       dispositivo Host comum;
    --devicePrinter    dispositivo de Impressão;
    --deviceSwitch     dispositivo HUB/Switch;
    --deviceCam        dispositivo CAMera de segurança;
    --hostLaptop       host móvel;
    --hostAlert        host em alerta;
    --hostRetired      host destivado;
    --hostDeny         host bloqueado ou sem comunicação;
    --hostBsd          host com S.O. FreeBSD/OpenBSD;
    --hostLinux        host com S.O. GNU/Linux ou Unix like;
    --hostWindows      host com S.O. Windows (Microsoft);
    --hostMac          host com S.O. MacOS (Apple);
    --hostServer       host com S.O. para Servidor;
    --hostWeb          host com WebServer habilitado;
    --hostWorkstation  host Workstation (any O.S.);
    --hostPhoneIP      dispositivo IP phone(VoIP);
    
   Exemplos:
         $APPNAME  -V                   # apresenta a versão atual.
         $APPNAME  --hostWorkstation 0  # retorna o nome do arquivo para
                                          hostWorkstation com o Status 0.
  $CONTACT"
      exit 0
}
#

# Debug print

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


# Debug print
function debug_console () {
if [ "$debugVerbose" = true ]
   then
      echo ""
      echo "$APPNAME"
      echo "=== Information ==="
      echo " description --> " $descr
      echo " image (device/host) --> " $this
      echo " status --> " $numberstatus
      echo " local --> " $dirlocal
      echo " pathway --> " $dirlocal$this 
      echo " dirconfig --> " $dirconfig
      echo "=== * ==="
      echo ""
fi
}
#

# Teste de Status
verstatus () {
	if test -z $numberstatus 
				then
					echo "O valor atribuído para Status é inválido ou vazio."
				   echo 'Experimente "'$APPNAME' --help" para maiores informações.'
				exit 0
				fi
}
#

# Argumentos de linha de comando
choose () {

while test -n "$1"
	do
	case "$1" in
     -h | --help )
       help_manual  ;;

     -V | --version )
      echo "versão: $VERSION" ;;

     --deviceAp )
   			shift 
				numberstatus=$1  
			   verstatus $1
		descr=$(grep deviceAp  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	   
      this=$(grep deviceAp  "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)
      echo "$dirrelative$this:$descr:$this"      ;;     
      
     --deviceHost )
   			shift 
				numberstatus=$1 
				verstatus $1   
		descr=$(grep deviceHost  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)			
      this=$(grep deviceHost "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1) 
		echo "$dirrelative$this:$descr:$this";;            
      
     --devicePrinter )
     		   shift 
		      numberstatus=$1
		      verstatus $1
		descr=$(grep devicePrinter  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	        
      this=$(grep devicePrinter "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1) 
      echo "$dirrelative$this:$descr:$this";;     

     --deviceSwitch )
     	      shift 
		      numberstatus=$1 
		      verstatus $1 
	   descr=$(grep deviceSwitch  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	      
      this=$(grep deviceSwitch "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)
      echo "$dirrelative$this:$descr:$this";;  
         
     --hostAlert )
     			shift 
		      numberstatus=$1  
		      verstatus $1
	   descr=$(grep hostAlert  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	      
      this=$(grep hostAlert "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)
      echo "$dirrelative$this:$descr:$this";;        

     --hostRetired )
     	      shift 
		      numberstatus=$1
		      verstatus $1  
	   descr=$(grep hostRetired  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	      
      this=$(grep hostRetired "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)
      echo "$dirrelative$this:$descr:$this";;        
             
     --hostDeny )
     	     shift 
		     numberstatus=$1 
		     verstatus $1 
	   descr=$(grep hostDeny  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	      
      this=$(grep hostDeny "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)
      echo "$dirrelative$this:$descr:$this";;        
       
     --hostBsd )
     	     shift 
		     numberstatus=$1  
		     verstatus $1
	   descr=$(grep hostBsd  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	      
      this=$(grep hostBsd  "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)
      echo "$dirrelative$this:$descr:$this";;        
       
     --hostLinux )
     	     shift 
		     numberstatus=$1  
		     verstatus $1
	   descr=$(grep hostLinux  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	      
      this=$(grep hostLinux "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)
      echo "$dirrelative$this:$descr:$this";;
        
     --hostMac )
     	     shift 
		     numberstatus=$1   
		     verstatus $1
	   descr=$(grep hostMac  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	      
      this=$(grep hostMac  "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)
      echo "$dirrelative$this:$descr:$this";;        
       
     --hostServer )
     	     shift 
		     numberstatus=$1  
		     verstatus $1
	   descr=$(grep hostServer  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	
      this=$(grep hostServer "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)
      echo "$dirrelative$this:$descr:$this";;        

     --hostWeb )
     	     shift 
		     numberstatus=$1  
		     verstatus $1
	   descr=$(grep hostWeb  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	      
      this=$(grep hostWeb "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)    
      echo "$dirrelative$this:$descr:$this";;  
      
     --hostWindows )
     	     shift 
		     numberstatus=$1  
		     verstatus $1
	   descr=$(grep hostWindows  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	  
      this=$(grep hostWindows "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)
      echo "$dirrelative$this:$descr:$this";;   
      
     --hostWorkstation )
     	     shift 
		     numberstatus=$1  
		     verstatus $1
	   descr=$(grep hostWorkstation  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	      
      this=$(grep hostWorkstation "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)    
      echo "$dirrelative$this:$descr:$this";;  

     --deviceCam )
     	     shift 
		     numberstatus=$1  
		     verstatus $1
	   descr=$(grep deviceCam  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	      
      this=$(grep deviceCam "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)    
      echo "$dirrelative$this:$descr:$this";; 
      
      --hostLaptop )
     	     shift 
		     numberstatus=$1  
		     verstatus $1
	   descr=$(grep hostLaptop  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	      
      this=$(grep hostLaptop "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)    
      echo "$dirrelative$this:$descr:$this";;  

     --hostPhoneIP )
     	     shift 
		     numberstatus=$1  
		     verstatus $1
	   descr=$(grep hostPhoneIP  "$dirconfig"images.xml | grep -w $numberstatus | cut -d"=" -f4 | cut -d">" -f1 | cut -d"\"" -f2)	  
      this=$(grep hostPhoneIP "$dirconfig"images.xml | grep -w $numberstatus | cut -d">" -f2 | cut -d"<" -f1)
      echo "$dirrelative$this:$descr:$this";;   

      
	*)

	if test -n "$1"
			then
				echo ''$APPNAME' : "'$1'" é um argumento inválido.';
				echo 'Experimente "'$APPNAME' --help" para maiores informações.';
				else
				exit 0;
		fi;;
		
	esac
		shift
	done
}
#

# Begin
choose $argumentos
debug_log


#debug_console
# End
