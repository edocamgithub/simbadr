#!/bin/bash
#Writer by Eduardo M. Araujo (c)2024 
# Use -i for interactive for question

baseDIR=$(simbadr-read-conf.sh -l)
soma1=0
soma2=0

 if [[ $1 = "-i" ]] 
	then
		echo -e "[Id]\t[GroupName]"
			else
			echo -e "[Id]\t[GroupName]\t[Unit]"
			fi


#echo -e  "[Number] [GroupName]"



for s in {1..9}
	do
quant=$("$baseDIR"rwinfodb.sh -n /opt/simbadr/var/log/simbadr/blocks/00/"0"$s)
titulo=$("$baseDIR"rinfogrp.sh -"0"$s)

soma1=$(echo $(($quant + $soma1)))

#echo -e " 0$s\t$titulo\t\t$quant"
 if [[ $1 = "-i" ]] 
	then
		printf '%.2s %15s\n' 0$s $titulo 
		else
			printf '%.2s %15s\t%3s\n' 0$s $titulo $quant
			fi

 done



for s in {10..32}
        do
quant=$("$baseDIR"rwinfodb.sh -n /opt/simbadr/var/log/simbadr/blocks/00/$s)
titulo=$("$baseDIR"rinfogrp.sh -$s)

soma2=$(echo $(($quant + $soma2)))
#echo -e " $s\t$titulo\t\t$quant"

if [[  $1 = "-i" ]] 
	then
		printf '%.2s %15s\n' $s $titulo 
		else
 		 printf '%.2s %15s\t%3s\n' $s $titulo $quant
 		 fi

       done





if [[  $1 = "-i" ]] 
	then
      echo 
		else
echo $(($soma1 + $soma2))  
 		 fi
