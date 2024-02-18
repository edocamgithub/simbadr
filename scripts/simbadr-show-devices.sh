#!/bin/bash
#Writer by Eduardo M. Araujo (c)2024 

baseDIR=$(simbadr-read-conf.sh -l)
soma1=0
soma2=0

echo -e  "[Id]\t[GroupName]\t[Unit.Devices]"
echo 

for s in {1..9}
	do
quant=$("$baseDIR"rwinfodb.sh -n /opt/simbadr/var/log/simbadr/blocks/00/"0"$s)
titulo=$("$baseDIR"rinfogrp.sh -"0"$s)

soma1=$(echo $(($quant + $soma1)))

echo -e " 0$s\t$titulo\t\t$quant"
	 
       done

for s in {10..32}
        do
quant=$("$baseDIR"rwinfodb.sh -n /opt/simbadr/var/log/simbadr/blocks/00/$s)
titulo=$("$baseDIR"rinfogrp.sh -$s)

soma2=$(echo $(($quant + $soma2)))
echo -e " $s\t$titulo\t\t$quant"
       done

echo $(($soma1 + $soma2))
