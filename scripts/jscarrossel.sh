#!/bin/bash
##################################################################
#  File: jscarrossel.sh 	       Built: 202110060839 
#  Version: 1.0.2
#
#  Function: Recreator list for Carrossel.js
#
##################################################################
#  Copyright (c)2021-2024 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#  Required: simbadr-read-conf.sh
#
#  Note: output carrossel.js
#
##################################################################
    baseDIR=$(simbadr-read-conf.sh -f)
     baseJS=$(echo $baseDIR"js/")
baseDIR_LIB=$(simbadr-read-conf.sh --library)
   baseCONF=$(simbadr-read-conf.sh -s)

    filename_output="carrossel.js"
 TEMP_LOCAL_SIMBADR="/tmp/simbadr"

# Verifica a existenica do DIR=tmp/simbadr/
if test -d $TEMP_LOCAL_SIMBADR
	then
  		echo "/tmp/simbadr not found!" >/dev/null
	else
  		mkdir $TEMP_LOCAL_SIMBADR
	fi

#echo $baseCONF  $baseJS $filename_output $baseDIR_LIB

"$baseDIR_LIB"simbadr-recreator-js.sh >  "$TEMP_LOCAL_SIMBADR/"0001.js
cp "$TEMP_LOCAL_SIMBADR/"0001.js $baseJS"$filename_output"

 
