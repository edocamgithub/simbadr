<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
	<head>
		<title>Inventory</title>
			<link href="../css/report.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<div id="groupname">Group Name: <xsl:value-of select="group/@name" /> 
			</div>
	   
	   <div id="grouptime"> 
	   		<span class="blocktext">Device Type: <xsl:value-of select="group/@typedevice" /> </span> 		
	   		<span class="blocktext">Total of Registered Devices: <xsl:value-of select="group/@total" /> </span>
	   		<span class="blocktext">On: <xsl:value-of select="group/@on" /> </span>
	   		<span class="blocktext">Off:  <xsl:value-of select="group/@off" /> </span>
	   		<span class="blocktext">Last Contact: <xsl:value-of select="group/@serial" /> </span>
	   	</div>
  
		 <div class="corpo">
				<xsl:for-each select="group/device"> 
			
					   <div id="caixa">
							
							<span class="statusnow">
								
								<!-- xsl:value-of select="status_now"  ENABLE ON or OFF display -->

								<xsl:value-of select="group/@typedevice" />
							</span>
							
							
							<span class="ipaddress"> 
			            
							<xsl:value-of select="network/ipadress" /> 
						
							</span>
						</div>

					</xsl:for-each>
			</div>
			
	</body>
</html>
</xsl:template>
</xsl:stylesheet>