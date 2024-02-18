/*
File: screenstop.js   Built 202312202010
Version: 0.0.1        

Function: Screen stop

Required: 

Note: (simbadr/var/www/html/simbadr/js/)

Written by Eduardo M. Araujo. - versão 0.0.1
Copyright (c)2019-2023 
*/




function minhaFuncao(e) {
    
    document.getElementById("janela").innerHTML = '<iframe scrolling="auto" src="xml/' + numberGroup[globalVar] + '" />' ;	  	
}

var elementos = document.getElementById("janela").innerHTML = '<iframe scrolling="auto" src="xml/' + numberGroup[globalVar] + '" />' ;

    elementos.addEventListener('mouseover', minhaFuncao);
	
