<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">	
  <xsl:output method="text"/>

  <xsl:template match="@* | node()">
      <xsl:apply-templates select="@* | node()"/>
  </xsl:template>

  
  <xsl:template match="svg:path[contains(@id, 'mypath')]">
    /Applications/Inkscape.app/Contents/MacOS/inkscape -g --select=<xsl:value-of select="@id"/> --verb "command.evilmadscientist.eggbot_hatch.noprefs; FileSave; FileQuit" /tmp/foo2.svg
    
  </xsl:template>

    
  
</xsl:stylesheet>
