
function stopCarrossel() {
     clearInterval(StartCarrossel);	
}


function carrosselFrames() {
        var numberGroup =  sequenceGroup;
        globalVar ++;
	if (globalVar > 29) {
				globalVar = 0;
			}
     document.getElementById("janela").innerHTML = '<iframe scrolling="auto" src="xml/' + numberGroup[globalVar] + '" />' ;	  	}
		   	
var globalVar;
	 globalVar = -1;

var StartCarrossel = setInterval(carrosselFrames, 2000, globalVar);
var sequenceGroup = [ "statusinfo.xml", "01.xml","02.xml","03.xml","04.xml","05.xml","06.xml","07.xml","08.xml","09.xml","10.xml","11.xml","12.xml","13.xml","14.xml","15.xml","16.xml","17.xml","18.xml","19.xml","20.xml","21.xml","22.xml","23.xml","24.xml","25.xml","26.xml","27.xml","28.xml","29.xml" ];