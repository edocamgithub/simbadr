#!/bin/bash
# Created 9 nov 2021 0855
# Write by Eduardo M. Araujo (c)2021-2024



# Diretorio de base
baseDIR=$(simbadr-read-conf.sh --global)
baseDIR_barra=$(echo $baseDIR | cut -d"/" -f1-7)
grouplocal=$(simbadr-read-conf.sh --group99)
baseDIR_LIB=$(simbadr-read-conf.sh --library)

#


"$baseDIR_LIB"grpinfor.sh -a > /tmp/statusinfo.tmp
cp /tmp/statusinfo.tmp  "$grouplocal"statusinfo.xml

