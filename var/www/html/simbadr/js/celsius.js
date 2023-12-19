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
					celsiusupdate(this);    				   				
    			}
		}	
		
	xhttp.open("GET", "xml/celsius.xml", true);
	xhttp.send();
}

function celsiusupdate(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("celsiusg").innerHTML =
    xmlDoc.getElementsByTagName("temper")[0].childNodes[0].nodeValue;
}

var Panel = setInterval(loadPanel, 2000);	