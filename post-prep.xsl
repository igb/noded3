<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">	


  <xsl:output method="text"/>
  <xsl:strip-space elements="*"/>


 

  
  <xsl:template match="/">
    <xsl:for-each select="//color-groups/group[not(.=preceding::*)]">xsltproc  extract-fillpaths.xsl  /tmp/group<xsl:value-of select="."/>.svg &gt; /tmp/hatch<xsl:value-of select="."/>.svg <xsl:text>&#xa;</xsl:text> 
</xsl:for-each>
    
    
  </xsl:template>


</xsl:stylesheet>
