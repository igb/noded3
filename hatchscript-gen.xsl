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
    <xsl:variable name="i" select="@id"/>
    <xsl:variable name="j" select="substring($i, 7) mod 180"/>
    
    xsltproc --stringparam hatchAngle  <xsl:value-of select="$j"/>  hatchscript-rotate.xsl   ~/Library/Application\ Support/org.inkscape.Inkscape/config/inkscape/preferences.xml > /tmp/preferences.xml;

    cp /tmp/preferences.xml   ~/Library/Application\ Support/org.inkscape.Inkscape/config/inkscape/;


    /Applications/Inkscape.app/Contents/MacOS/inkscape -g --select=<xsl:value-of select="@id"/> --verb "command.evilmadscientist.eggbot_hatch.noprefs; FileSave; FileQuit" /tmp/foo2.svg;


    
    
  </xsl:template>

    
  
</xsl:stylesheet>
