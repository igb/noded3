<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">	
  <xsl:output method="text"/>

  <xsl:param name="file"/>


  <xsl:output method="text"/>

  <xsl:template match="@* | node()">
      <xsl:apply-templates select="@* | node()"/>
  </xsl:template>

  <xsl:template match="/">/Applications/Inkscape.app/Contents/MacOS/inkscape -g --select=<xsl:apply-templates select="@* | node()"/> --verb "command.evilmadscientist.eggbot_hatch.noprefs; FileSave; FileQuit" <xsl:value-of select="$file"/>;</xsl:template>  
  
  <xsl:template match="svg:path"><xsl:value-of select="./@id"/>,</xsl:template>

</xsl:stylesheet>

