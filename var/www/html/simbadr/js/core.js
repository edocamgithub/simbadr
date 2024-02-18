/*
File: core.js         Built 201902061252
Version: 0.0.1        Last update 202302091300

Function: Get numbers for total devices

Required: infodash.xml 

Note: (simbadr/var/www/html/simbadr/js/)

Written by Eduardo M. Araujo. - versão 0.0.1
Copyright (c)2019-2023
*/




function readfullXML(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("on").innerHTML =
    xmlDoc.getElementsByTagName("totalOnDevices")[0].childNodes[0].nodeValue;

    document.getElementById("off").innerHTML =
    xmlDoc.getElementsByTagName("totalOffDevices")[0].childNodes[0].nodeValue;

    document.getElementById("totaldevice").innerHTML =
    xmlDoc.getElementsByTagName("sumofgroups")[0].childNodes[0].nodeValue;

    document.getElementById("cento").innerHTML =
    xmlDoc.getElementsByTagName("percentage")[0].childNodes[0].nodeValue;
    
    document.getElementById("updatingtime").innerHTML =
    xmlDoc.getElementsByTagName("lastTime")[0].childNodes[0].nodeValue;      
}

function loadPanel() {
	var xhttp = new XMLHttpRequest();
	
	xhttp.onreadystatechange = function() {
   		if (this.readyState == 4 && this.status == 200) {
					readfullXML(this);
    			}
		}	
	xhttp.open("GET", "xml/infodash.xml", true);
	xhttp.send();
}
var Panel = setInterval(loadPanel, 2000);	