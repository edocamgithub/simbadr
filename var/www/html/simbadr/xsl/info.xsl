<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" 
						xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
						xmlns:xlink="http://www.w3.org/1999/xlink">
					 
 <xsl:template match="/">

  <html>

	<head>
		<title>Network Information</title>
        	<meta http-equiv="refresh" content="30"/>
        	<meta http-equiv="chache-control" content="max-age=0"/>
        	<meta http-equiv="pragma" content="no-cache"/>
			<link href="../css/statusinfo.css" rel="stylesheet" type="text/css"/>
	</head>
	
	<body>
	       	
	       	
      <xsl:for-each select="status/group">
     
     <div id="body_info"> 
       <xsl:choose>
        
         <xsl:when test="information = 'normal'" >
                  	   <xsl:value-of select="grouplink" />  
           	  	  
	    	   <div id="block_info_normal">
	    	   <a  target="_blank" rel="noopener noreferrer"  href="{grouplink}"> 
	    	    
            	<xsl:value-of select="information"/>
              
            	<span id="number_info" > 
            		<p><xsl:value-of select="information/@groupnumber"/></p>
         	   </span>    
       			
       			<span id="name_info" >
      				<xsl:value-of select="information/@groupname"/>
    				</span> 	    
      	      	  </a>    	
      	    	</div>

        </xsl:when>

	       <xsl:when test="information = 'warning'" >
	       <xsl:value-of select="grouplink" />  
	    	 
	    	   <div id="block_info_warning">

					<a  target="_blank" rel="noopener noreferrer"  href="{grouplink}"> 
					
            	<xsl:value-of select="information"/>
   
            	<span id="number_info" >
						<p><xsl:value-of select="information/@groupnumber"/></p>
					</span>
					    
       			<span id="name_info" >
      				<xsl:value-of select="information/@groupname"/>
    				</span>
					</a>
      	    </div>
	       </xsl:when>       
       
       <xsl:otherwise>
        <xsl:value-of select="grouplink" /> 
          <div id="block_info_alert">
          <a  target="_blank" rel="noopener noreferrer"  href="{grouplink}"> 
         		<xsl:value-of select="information"/>
   
         		<span id="number_info" >
         			<p> <xsl:value-of select="information/@groupnumber"/> </p>
         	   	</span>    

       			<span id="name_info" >
      				<xsl:value-of select="information/@groupname"/>
    					</span>
				</a>
			 </div>
       </xsl:otherwise>
       </xsl:choose>  		
 	</div>
       		
		</xsl:for-each>
 	  
	</body>
	</html>
 
 </xsl:template>

</xsl:stylesheet>


								