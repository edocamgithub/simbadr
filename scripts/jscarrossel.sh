#!/bin/bash
##################################################################
#  File: jscarrossel.sh 	       Built: 202110060839 
#  Version: 1.0.1
#
#  Function: Recreator list for Carrossel.js
#
#  Written by Eduardo M. Araujo.
##################################################################
#  Copyright (c)2021-2023
#
#  This file is part the templates scripts tools collections.
#
#  Required: simbadr-read-conf.sh
#
#  Note: output carrossel.js
##################################################################
baseDIR=$(simbadr-read-conf.sh -f)
baseJS=$(echo $baseDIR"js/")
baseDIR_LIB=$(simbadr-read-conf.sh --library)
filename_output="carrossel.js"
TEMP_LOCAL_SIMBADR="/tmp/simbadr"

# Verifica a existenica do DIR=tmp/simbadr/
if test -d $TEMP_LOCAL_SIMBADR
	then
  		echo "/tmp/simbadr not found!" >/dev/null
	else
  		mkdir $TEMP_LOCAL_SIMBADR
	fi

baseCONF=$(simbadr-read-conf.sh -s)

#echo $baseCONF  $baseJS $filename_output $baseDIR_LIB

"$baseDIR_LIB"simbadr-recreator-js.sh > /tmp/0001.js
cp "$TEMP_LOCAL_SIMBADR/"0001.js $baseJS"$filename_output"

 