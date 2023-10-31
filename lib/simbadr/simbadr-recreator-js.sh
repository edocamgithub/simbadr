#!/bin/bash
##################################################################
#  File: simbadr-recreator-js.sh 	       Built: 201905161412
#  Version: 1.0.1
#
#  Function: Read file simbadr in group enable for Javascript 
#
#  Written by Eduardo M. Araujo.
#
##################################################################
#                   ---------------------------
#  Copyright (C)2021 Eduardo M. Araujo..
#
#  This file is part the templates scripts tools collections.
#
#
#  Required: simbadr
#
#  Note: 
#
# created by manual
##################################################################

baseDIR=$(simbadr-read-conf.sh -f)
baseDIR_js=$(echo $baseDIR"js/")
baseJS=$baseDIR_js
baseCONF=$(simbadr-read-conf.sh -s)
filename_output="carrossel.js"


totalGroup=$(grep group_enable "$baseCONF"simbadr | cut -d"=" -f2 | wc -w)

groupsN=$(grep group_enable "$baseCONF"simbadr | cut -d"=" -f2) 


function writeCarrossel.js (){
echo	"
function carrosselFrames() {
        var numberGroup =  sequenceGroup;
        globalVar ++;"
echo	"	if (globalVar > "$totalGroup") {
				globalVar = 0;
			}"
		
#document.getElementById("janela").innerHTML = '<iframe scrolling="auto" src="xml/' + numberGroup[globalVar] + '" />' ;

echo -n "     document.getElementById("
echo -n '"janela"' 
echo -n ").innerHTML = "

echo -n  "'"
echo -n "<iframe scrolling="
echo -n '"auto" '
echo -n "src="
echo -n '"'
echo -n "xml/' + numberGroup[globalVar] +"
echo -n " '"
echo -n '"'
echo -n " />' ;"

echo "	  	}
		   	
var globalVar;
	 globalVar = -1;

var StartCarrossel = setInterval(carrosselFrames, 5000, globalVar);"
}


for i in $groupsN
do
 lista=$(echo '"'$i'.xml",')
 lista2=$(echo "$lista2""$lista")
done

listGrouponly=$(echo $lista2 | sed 's/.$//')

#var sequenceGroup = [ "01.xml", "02.xml", "03.xml" ]; 

writeCarrossel.js
echo -n  "var sequenceGroup = [ "
echo -n '"'
echo -n 'statusinfo.xml'
echo -n '"' 
echo -n ", "
echo -n "$listGrouponly "
echo -n "];"


#echo $filename_output
#echo "$baseJS"
 
