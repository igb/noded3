<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">	
  <xsl:output method="xml"/>

   <xsl:param name="hatchAngle" select="45"/>

  
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  
  <xsl:template match="@command.evilmadscientist.eggbot_hatch.hatchAngle">
    <xsl:attribute name="command.evilmadscientist.eggbot_hatch.hatchAngle"><xsl:value-of select="$hatchAngle"/></xsl:attribute>    
  </xsl:template>

    
  
</xsl:stylesheet>
