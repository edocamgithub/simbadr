#!/bin/bash
##################################################################
#  File: jscarrossel.sh 	       Built: 202110060839 
#  Version: 1.0.1
#
#  Function: Recreator list for Carrossel.js
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#                   ---------------------------
#  Copyright (c)2021 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#
#  Required: simbadr-read-conf.sh
#
#  Note: output carrossel.js
#
#                   ---------------------------
#
##################################################################
baseDIR=$(simbadr-read-conf.sh -f)
baseJS=$(echo $baseDIR"js/")
baseDIR_LIB=$(simbadr-read-conf.sh --library)


baseCONF=$(simbadr-read-conf.sh -s)

filename_output="carrossel.js"

#echo $baseCONF  $baseJS $filename_output $baseDIR_LIB

"$baseDIR_LIB"simbadr-recreator-js.sh > /tmp/0001.js
cp /tmp/0001.js $baseJS"$filename_output"

 
