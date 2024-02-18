/*
File: time.js         Built 201902061252
Version: 0.0.1        Last update 202302091300

Function: Get time pt-BR 24 hours type

Required: variables hora, lastupdateTitle, relogio

Note: (simbadr/var/www/html/simbadr/js/)

Written by Eduardo M. Araujo. - versão 0.0.1
Copyright (c)2019-2023 Eduardo M. Araujo..
*/

function myTimer() {
  var nowTime = new Date();
  document.getElementById("hora").innerHTML = nowTime.toLocaleTimeString('pt-BR', {hour12:false});
	}

function myDate() {
  var today = new Date();
  document.getElementById("lastupdateTitle").innerHTML = today.toDateString();
	} 

var myVar = setInterval(myTimer, 1000);
var legal = setInterval(myDate, 1000);

