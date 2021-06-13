<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">	


  <xsl:output method="text"/>
  <xsl:strip-space elements="*"/>



  
  <xsl:template match="node() | @*">
   
    <xsl:copy>	
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>

  </xsl:template>

  <xsl:template match="/">
    <xsl:for-each select="//color-groups/group[not(.=preceding::*)]">
      <xsl:variable name="count"  select="."/><xsl:for-each select="document('cmyk.xml')//colors/color"><xsl:if test="$count = position()">xsltproc --stringparam color <xsl:value-of select="@name"/>  --stringparam filename /tmp/group<xsl:value-of select="$count"/>.svg  cmyk-sep-gen.xsl cmyk.xml<xsl:text>&#xa;</xsl:text></xsl:if></xsl:for-each>
    </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>
