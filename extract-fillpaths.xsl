<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">	


  <xsl:output method="xml"/>
  <xsl:strip-space elements="*"/>


  <xsl:param name="group" select="'group'"/>

  
  <xsl:template match="node() | @*">   
    <xsl:copy>	
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>


  <xsl:template match="svg:path">
   <xsl:if  test="not(@class)">
      <xsl:copy>	
	<xsl:apply-templates select="node() | @*"/>
      </xsl:copy>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
