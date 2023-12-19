var xmlHttp;

function createXMLHttpRequest() {
	if (window.ActiveXObject) {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
	else if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest ();				
		}
}

function handleStateChange() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
			alert ("The serve replied with: " + xmlHttp.responseText)
			}
	}
}

function startRequest() {
	createXMLHttpRequest();
	xmlHttp.onreadystatechange = handleStateChange;
	xmlHttp.open ("GET", "xml/infodash.xml", true);
	xmlHttp.send(null);
}


//function statusColor() {
    
  //  startRequest();
    
    //var sColor = xmlDoc.getElementsByTagName("percentage")[0].childNodes[0].nodeValue;    
    
   // if ( statusColor > 70) {
    	//	document.getElementsByClassName(deviceon).innerHTML = background-color: greenyellow;  	

//}


//function porcentagem(xml) {
  //  var xmlDoc = xml.responseXML;
   // document.getElementById("cento").innerHTML =
   // xmlDoc.getElementsByTagName("percentage")[0].childNodes[0].nodeValue;    	    
//}



