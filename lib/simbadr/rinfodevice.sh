#!/bin/bash
##################################################################
#  File: rinfodevice.sh 	       Built: 201905161412
#  Version: 1.0.2
#
#  Function: Read devices.xml
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2023 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#
#  Required: devices.xml
#
#  Note: null
#           24 set 2019 - +ipphone
#           14 nov 2023 +Any devices
#
#                   ---------------------------
#
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2019Mai16"
    AUTHOR="Written by Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2021 Eduardo M. Araujo."
   CONTACT="Contact for email: <edocam@outlook.com>"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log


# Habilita a impressao de variaveis
debugVerbose=false
#

# Habilita as opcoes
argumentos=$@
#

# Configuração principal 
config=$(simbadr-read-conf.sh -s)

# Diretorio de base
baseDIR_LIB=$(simbadr-read-conf.sh --library)

#
#

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION $COPYRIGHT
  
   * Consulta o arquivo devices.xml e retorna a nome completo  *
  
  Uso: $APPNAME <opções> 
  
  OPÇÕES:
    -h, --help            apresenta esta informação para ajuda e finaliza;
    -V, --version         mostra a versão atual;
    -w, --workstation     retorna o nome padrão ou marca;
    -s, --server          retorna o nome padrão ou marca;
    -p, --printer         retorna o nome padrão ou marca;
    -c, --switch          retorna o nome padrão ou marca;
    -a, --access-point    retorna o nome padrão ou marca;
    -t, --site            retorna o nome padrão ou marca;
    -m, --mobile          retorna o nome padrão ou marca;
    -f, --smartphone      retorna o nome padrão ou marca;
    -b, --tablet          retorna o nome padrão ou marca;
    -v, --voip phone      retorna o nome padrão ou marca;
    -d, --any devices      retorna o nome padrão ou marca;
  
   Exemplos:
         $APPNAME  -f
         $APPNAME  --access-point
         $APPNAME  -c
  
  $CONTACT"
      exit 0
}
#

function debug_console ()
{
if [ $debugVerbose = true ] 
	then
		echo ""	
		echo "===>" $config
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

     -v | --voip-phone )
			grep \"ph\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;

     -w | --workstation )
        grep \"ws\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -s | --server )
			grep \"sr\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -p | --printer )
			grep \"pr\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -c | --switch )
			grep \"sw\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;

     -a | --access-point )
			grep \"ap\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -t | --site )
			grep \"st\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;

     -m | --mobile )
			grep \"ms\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -f | --smartphone )
			grep \"sp\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;
    
     -b | --table )
			grep \"tb\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;;


-d | --any devices )
			grep \"ad\"  "$config"devices.xml | cut -d">" -f2 | cut -d"<" -f1;; 
   
	*)
		exit 0;;
esac
}
#


# Begin
debug_console
choose $argumentos

# End
