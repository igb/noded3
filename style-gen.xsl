<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    version="1.0">	
  <xsl:output		method="xml"/>
  <xsl:template match="node() | @*">
    <xsl:copy>	
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="svg:svg">

    <xsl:copy>

      <xsl:apply-templates select="node() | @*"/>

                 <xsl:apply-templates select="document('./pattern-defs.xml')"/>
    </xsl:copy>

  </xsl:template>


  <xsl:template match="svg:polygons">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>


  <xsl:template match="svg:path">
    <xsl:variable name="i" select="position()" />
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
       <xsl:attribute name="class"> <xsl:value-of select="concat('fill00', $i mod 10)"/></xsl:attribute>
    </xsl:copy>
  </xsl:template>
    
  
</xsl:stylesheet>
