/*
File: core.js         Built 201902061252
Version: 0.0.1        Last update 202302091300

Function: Get numbers for total devices

Required: infodash.xml 

Note: (simbadr/var/www/html/simbadr/js/)

Written by Eduardo M. Araujo. - versão 0.0.1
Copyright (c)2019-2023 Eduardo M. Araujo..
*/




function loadPanel() {
	var xhttp = new XMLHttpRequest();
	
	xhttp.onreadystatechange = function() {
   		if (this.readyState == 4 && this.status == 200) {
		/*			contaOFF(this);    				
    				contaON(this);
    				porcentagem(this);
    				totalRegister(this);
    				t_workstation(this);
               t_voip(this);
               t_printer(this);
    				loadtimeupdate(this); */
    				readfullXML(this);
    			}
		}	
		
	xhttp.open("GET", "xml/infodash.xml", true);
	xhttp.send();
}

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

    document.getElementById("totalworkstation").innerHTML =
    xmlDoc.getElementsByTagName("workstation")[0].childNodes[0].nodeValue;

    document.getElementById("totalvoip").innerHTML =
    xmlDoc.getElementsByTagName("voip")[0].childNodes[0].nodeValue;

    document.getElementById("totalprinter").innerHTML =
    xmlDoc.getElementsByTagName("printer")[0].childNodes[0].nodeValue;

    document.getElementById("updatingtime").innerHTML =
    xmlDoc.getElementsByTagName("last")[0].childNodes[0].nodeValue;
}


function contaON(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("on").innerHTML =
    xmlDoc.getElementsByTagName("totalOnDevices")[0].childNodes[0].nodeValue;
}

function contaOFF(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("off").innerHTML =
    xmlDoc.getElementsByTagName("totalOffDevices")[0].childNodes[0].nodeValue;
}

function totalRegister(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("totaldevice").innerHTML =
    xmlDoc.getElementsByTagName("sumofgroups")[0].childNodes[0].nodeValue;
}

function porcentagem(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("cento").innerHTML =
    xmlDoc.getElementsByTagName("percentage")[0].childNodes[0].nodeValue;
}


function t_workstation(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("totalworkstation").innerHTML =
    xmlDoc.getElementsByTagName("workstation")[0].childNodes[0].nodeValue;
}


function t_voip(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("totalvoip").innerHTML =
    xmlDoc.getElementsByTagName("voip")[0].childNodes[0].nodeValue;
}

function t_printer(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("totalprinter").innerHTML =
    xmlDoc.getElementsByTagName("printer")[0].childNodes[0].nodeValue;
}

function loadtimeupdate(xml) {
    var xmlDoc = xml.responseXML;
    document.getElementById("updatingtime").innerHTML =
    xmlDoc.getElementsByTagName("lastTime")[0].childNodes[0].nodeValue;
}

var Panel = setInterval(loadPanel, 2000);	


