#!/bin/bash

baseDIR_LIB=$(simbadr-read-conf.sh --libary)
    baseDIR=$(simbadr-read-conf.sh --group)
    baseXML=$(simbadr-read-conf.sh --xml-files)

for numberGroup in {1..9}
	do
	baseDIR=$(simbadr-read-conf.sh -"$numberGroup")
	ln -s "$baseDIR""0""$numberGroup".xml "$baseXML""0""$numberGroup".xml
	done

for numberGroup in {10..32}
        do
        baseDIR=$(simbadr-read-conf.sh -"$numberGroup")
        ln -s "$baseDIR""$numberGroup".xml "$baseXML""$numberGroup".xml
        done

numberGroup=99
baseDIR=$(simbadr-read-conf.sh -"$numberGroup")

ln -s  "$baseDIR""infodash".xml "$baseXML""infodash".xml

ln -s  "$baseDIR""statusinfo".xml "$baseXML""statusinfo".xml

ln -s  "$baseDIR""warning".xml "$baseXML""warning".xml

