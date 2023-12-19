/*
File: info.js         Built 201902061252
Version: 0.0.1        Last update 202302091300

Function: Information On Devices

Required: statusinfo.xml

Note: (simbadr/var/www/html/simbadr/js/)

Written by Eduardo M. Araujo. - versão 0.0.1
Copyright (c)2019-2023 Eduardo M. Araujo..
*/


function loadInfo() {
	var xhttp = new XMLHttpRequest();
	
	xhttp.onreadystatechange = function() {
   		if (this.readyState == 4 && this.status == 200) {
					statusNow(this);    				
    			
    			}
		}	
		
	xhttp.open("GET", "xml/statusinfo.xml", true);
	xhttp.send();
}


function statusNow(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("on").innerHTML =
    xmlDoc.getElementsByTagName("ondevices")[0].childNodes[0].nodeValue;
}



var Panel = setInterval(loadInfo, 2000);	
