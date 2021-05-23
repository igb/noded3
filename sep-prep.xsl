<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">	


  <xsl:output method="text"/>
  <xsl:strip-space elements="*"/>


 

  
  <xsl:template match="/">
    <xsl:for-each select="//color-groups/group[not(.=preceding::*)]">xsltproc --stringparam group group<xsl:value-of select="."/>  separations.xsl /tmp/foo1.xml  &gt; group<xsl:value-of select="."/>.xml<xsl:text>&#xa;</xsl:text> 
</xsl:for-each>
    
    
  </xsl:template>


</xsl:stylesheet>
