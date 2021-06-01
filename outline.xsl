<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">	


  <xsl:output method="xml"/>
  <xsl:strip-space elements="*"/>


  
  <xsl:template match="node() | @*">   
    <xsl:copy>	
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

 <xsl:template match="svg:g">
    <xsl:choose>
      <xsl:when test="'links'=@class">
<!--	<xsl:apply-templates select="node() | @*"/> -->
      </xsl:when>
      <xsl:when test="'sites'=@class">
<!--	<xsl:apply-templates select="node() | @*"/> -->
      </xsl:when>
      <xsl:otherwise>
	 <xsl:copy>	
	   <xsl:apply-templates select="node() | @*"/> 
	 </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
