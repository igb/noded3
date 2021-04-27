<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">	
  <xsl:output method="xml"/>


  <xsl:template match="svg:defs">
    <style>
      <xsl:apply-templates select="svg:pattern"/>
      .polygons {
       fill: #ffffff;
       stroke: #000000;
      }
    

    </style>
  </xsl:template>

  <xsl:template match="svg:pattern">
    .fill<xsl:value-of select="position()" /> {
      fill: url(#<xsl:value-of select="./@id"/>);
      stroke: #000000;
    }
  </xsl:template>

    
  
</xsl:stylesheet>
