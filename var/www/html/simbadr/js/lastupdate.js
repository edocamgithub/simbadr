/*
File: celsius.js         Built 202312152058
Version: 0.0.1        

Function: 
Required: celsius.xml 

Note: (simbadr/var/www/html/simbadr/js/)

Copyright (c)2023 Eduardo M. Araujo..
*/

function loadPanel() {
	var xhttp = new XMLHttpRequest();
	
	xhttp.onreadystatechange = function() {
   		if (this.readyState == 4 && this.status == 200) {
					lastupdate(this);    				   				
    			}
		}	
		
	xhttp.open("GET", "xml/lastupdate.xml", true);
	xhttp.send();
}

function lastupdate(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("updatingtime").innerHTML =
    xmlDoc.getElementsByTagName("lastTime")[0].childNodes[0].nodeValue;
}

var Panel = setInterval(loadPanel, 2000);	