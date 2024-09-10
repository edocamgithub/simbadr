#!/bin/bash
##################################################################
#  File: rwinfodb.sh 	       Built: 201906221018
#  Version: 1.0.1
#
#  Function: Manager data - add, delete, compile/sort
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2019-2024 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#
#  Required: rinfogrp.sh
#
#  Note: new option -l for locate IP on database file and 
#        -e for exhibit all register on database 
#  
# created by template_bash.sh
##################################################################
 
   APPNAME=$(basename $0)
   VERSION="1.0.1"
     BUILT="2019Jun22"
    AUTHOR="Eduardo M. Araujo."
 COPYRIGHT="Copyright (c)2019-2024 "
   CONTACT="Contact for email: <edocam@outlook.com>"
   baseLOG=$(simbadr-read-conf.sh --backup)
   AUTHLOG="$baseLOG"simbadr.log

# Atualizado em 01Ago2019 - opcao -l para localizar IP

# Habilita a impressao de variaveis
debugVerbose=true
#

# Habilita as opcoes
argumentos=$@
#

# Diretorio de base
baseDIR=$(simbadr-read-conf.sh --setup)
baseDIR_LIB=$(simbadr-read-conf.sh --library)
baseDIR_GLOBAL=$(simbadr-read-conf.sh --global)
dirDB=$(simbadr-read-conf.sh -g)
dirDB_XML=$(simbadr-read-conf.sh --group92)
backupDIR=$(simbadr-read-conf.sh --backup)
baseSYS=$(simbadr-read-conf.sh -x | cut -d"/" -f1-3)
path=$baseDIR_LIB
#

#path=$(echo "$baseDIR_LIB"config.xml | cut -d">" -f2 | cut -d"<" -f1)
# Nome do arquivo de temporario XXX é randomico.
  TEMPNAME="/tmp/dbinfotools.XXX"


# Atribuíndo o valor 0 para as variáveis
  delete_enable=0
     add_enable=0
 compile_enable=0
numberdb_enable=0
    sort_enable=0
  locate_enable=0
 exhibit_enable=0
    wipe_enable=0
  backup_enable=0

# Manual de uso do script
help_manual() {
  echo "$APPNAME version $VERSION 
$COPYRIGHT $AUTHOR
  
   * Manipula dados em um arquivo de banco de dados textual *
  
  Uso: $APPNAME <opções> <filename>
  
  OPÇÕES:
    -h, --help         apresenta esta informação para ajuda e finaliza;
    -V, --version      mostra a versão atual;
    -v, --verbose      modo DEBUG;
    -n, --numberdb     apresenta o total de registro;
    -a, --add          adiciona um novo registro;
    -d, --delete       remove um novo registro;
    -c, --compile      prepara o arquivo de database;
    -f, --filename     nome de arquivo de db;
    -l, --locate       localiza o registro do IP;
    -e, --exhibit      exibe o conteúdo;
    -w, --wipe         limpa o arquivo de registro;
    -b, --backup       efetua backup da base de dados e configurações;  
        --log          registra todos os eventos; 
        --log-import   importa e executa as ações registradas nos eventos;
        --allsystem    compacta todo o sistema (executaveis e dados);
  
   Exemplos:
         $APPNAME -a 192.168.0.10 -f filename.db   # adiciona o IP no arquivo filename.db
         $APPNAME -d 172.16.0.10 -f database.txt   # remove o IP do arquivo database.txt
         $APPNAME -c database.txt                  # apaga duplicidades e ordena em forma numérica
         $APPNAME -s nomes.db                      # ordena em ordem alfabetica  
         $APPNAME -l 172.16.0.1                    # localiza onde o IP esta resgistrado    
  
  $CONTACT"
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
      echo " execute --> " $execute
      echo " database file --> " $name_file 
      echo " add_enable --> " $add_enable
      echo " add_ip --> "$add_ip
      echo " delete_enable --> "$delete_enable
      echo " delete_ip --> "$delete_ip
      echo " compile_enable --> "$compile_enable
      echo " compile_file --> " $compile_file
      echo " sort_enable --> " $sort_enable
      echo " locate_enable --> " $locate_enable
      echo " locate_ip --> " $locate_ip   
      echo " exhibit_enable --> " $exhibit_enable      
      echo " exhibit_file --> " $exhibit_file     
      echo " group ---> " $numberdb_file
      echo " group name --> " $groupName
      echo " backup_enable -->" $backup_enable
      echo " backup_file_db --> " "$backup_file"db.tar.gz
      echo " backup_file-sys --> " "$backup_file"sys.tar.gz
      echo " backup_simbadrdb.xml --> " "$backup_file"dbxml.tar.gz        
      echo " total reg. --> " $totalrg
      echo "=== END ==="
      echo ""
fi
}
#


# Argumentos de linha de comando
choose_ () {
while test -n "$1"
do
	case "$1" in
     
     -h | --help )
            help_manual  ;;

     -V | --version )
            echo "versão: $VERSION" ;;

     -v | --verbose )
            debugVerbose=true;;
            
     -a | --add )
            add_enable=1      
            shift
            add_ip=$1
            execute="add" ;;

     -d | --delete )
            delete_enable=1
            shift 
            delete_ip=$1
            execute="remove" ;;
      
     -c | --compile )
            compile_enable=1
            shift
            compile_file=$1
            execute="compile" ;;
  
     -f | --filename )
            filename_enable=1
            shift
            name_file=$1;;
            
     -s | --sort )
            sort_enable=1
            shift
            sort_file=$1;;            
            
     -l | --locate )
            locate_enable=1
            shift
            locate_ip=$1;;               
        
     -e | --exhibit )
            exhibit_enable=1
            shift
            exhibit_file=$1;;               
         
     -w | --wipe )
            wipe_enable=1
            shift
            wipe_file=$1;;     
      
     -b | --backup )
            backup_enable=1
            shift
            backup_file=$1;;      
            
     --allsystem  )         
            backup_system=1
            shift
            backup_file_system=$1;;              
                
     -n | --numberdb )
            numberdb_enable=1
            shift
            numberdb_file=$1
            totalrg=$(wc -l $numberdb_file | cut -d" " -f1)
            execute="total reg."              
            ;;      
                

      	            *)
            if test -n "$1"
			      then
				       echo ''$APPNAME' : "'$1'" é um argumento inválido.';
				       echo 'Experimente "'$APPNAME' --help" para maiores informações.';
				       exit 0
					fi;;
	esac
		shift
done
}
#

# Begin

if test -z "$argumentos" 
   	then
        exit
   		fi

choose_ $argumentos 




if test $delete_enable -eq 1 
   then   
      TEMPFILEDIR=$(mktemp $TEMPNAME)
      grep -v -w "$delete_ip" $name_file > $TEMPFILEDIR && cat $TEMPFILEDIR > $name_file
      rm $TEMPFILEDIR      
      exit 0
   fi
	   
if test $add_enable -eq 1      
   then
      echo "$add_ip" >> $name_file
      exit 0
   fi
   
if test $compile_enable -eq 1
   then
      TEMPFILEDIR=$(mktemp $TEMPNAME)
      cat $compile_file | sort -n -u -t '.' -k 1,1 -k 2,2 -k 3,3 -k 4,4  > $TEMPFILEDIR && cat $TEMPFILEDIR > $compile_file
      rm $TEMPFILEDIR
      exit 0
   fi   

if test $numberdb_enable -eq 1
   then
      totalrg=$(wc -l $numberdb_file | cut -d" " -f1) 
      echo $totalrg   
      exit 0
   fi
     

if test $locate_enable -eq 1
   then

   #dirDB=$(simbadr-read-conf.sh -g)

      for i in {1..32}
  			do
				if  test "$i" -lt 10 
					then
		    			string_zero="0"
					else
						string_zero=""
		 			fi
		 
    search=$(grep -w $locate_ip $dirDB"$string_zero$i") && groupName=$("$path"rinfogrp.sh -"$string_zero$i") && echo $search":$string_zero$i"":"$groupName

  done
                     
      exit 0 
   fi   
   
if test $sort_enable -eq 1
   then
      TEMPFILEDIR=$(mktemp $TEMPNAME)
#      cat $sort_file | sort -d > $TEMPFILEDIR && cat $TEMPFILEDIR > $sort_file
cat $sort_file | sort -n -u -t '.' -k 1,1 -k 2,2 -k 3,3 -k 4,4  > $TEMPFILEDIR && cat $TEMPFILEDIR > $sort_file
      rm $TEMPFILEDIR                  
      exit 0 
   fi
     

if test $exhibit_enable -eq 1
   then
   if test -e $exhibit_file
   	then 
     		cat  $exhibit_file           
      	exit 0
      	else
      	   #echo "Arquvio não encontrado ou base de dados inexistente!";
				exit 0
			fi   
   fi


if test $wipe_enable -eq 1
   then
   if test -e $wipe_file
   	then 
   	TEMPFILEDIR=$(mktemp $TEMPNAME)
         cp $wipe_file $TEMPFILEDIR     		
     		#echo > $wipe_file          
         rm $wipe_file 
         touch $wipe_file        	
      	exit 0
      	else
      	   #echo "Arquvio não encontrado ou base de dados inexistente!";
				exit 0
			fi   
   fi


if test $backup_enable -eq 1
   then
   	if test -z $backup_file 
   		then
   	  	  backup_file=$(date "+%s")		
		     
     		  tar -czf "$backup_file"db.tar.gz  -P "$baseDIR_GLOBAL"* && mv "$backup_file"db.tar.gz "$backupDIR"
     		  tar -czf "$backup_file"dbxml.tar.gz  -P "$dirDB_XML"simbadrdb.xml && mv "$backup_file"dbxml.tar.gz "$backupDIR"
     		  tar -czf "$backup_file"dblist.tar.gz  -P "$dirDB_XML"*.list && mv "$backup_file"dblist.tar.gz "$backupDIR"
     		  tar -czf "$backup_file"sys.tar.gz -P "$baseDIR"* && mv "$backup_file"sys.tar.gz "$backupDIR"
     		else
     		  
     		  tar -czf "$backup_file"db.tar.gz -P "$baseDIR_GLOBAL"* && mv "$backup_file"db.tar.gz "$backupDIR"
     		  tar -czf "$backup_file"dbxml.tar.gz  -P "$dirDB_XML"simbadrdb.xml && mv "$backup_file"dbxml.tar.gz "$backupDIR"
     		  tar -czf "$backup_file"dblist.tar.gz  -P "$dirDB_XML"*.list && mv "$backup_file"dblist.tar.gz "$backupDIR"
     		  tar -czf "$backup_file"sys.tar.gz -P "$baseDIR"* && mv "$backup_file"sys.tar.gz "$backupDIR"
			fi   

 
   fi
   
#if test $backup_system -eq 1
#	then
#		if test -z $backup_file_system 
#		then
#	echo "Wait moment! Backup in progress..."
#	tar -czf "$baseSYS"system.tar.gz -P /tmp/"$backupDIR"
#	echo "Finished Backup!"
#		fi
#	fi

   
 debug_console $@           
                       
# End
