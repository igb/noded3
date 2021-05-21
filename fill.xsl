<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">	


  <xsl:output method="xml"/>
  <xsl:strip-space elements="*"/>


  <xsl:param name="style" select="'style'"/>

  
  <xsl:template match="node() | @*">
   
    <xsl:copy>	
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="svg:svg">




    <xsl:text disable-output-escaping="yes">&lt;!--</xsl:text>
    <xsl:value-of select="position()"/>
    <xsl:text disable-output-escaping="yes">--&gt;</xsl:text>



    <xsl:copy>

      <xsl:apply-templates select="node() | @*"/>

      <xsl:if test="$style='pattern-fill'">

	<xsl:apply-templates select="document('./pattern-defs.xml')"/>

      </xsl:if>

    </xsl:copy>


    
  </xsl:template>


  <xsl:template match="svg:polygons">

    <xsl:text disable-output-escaping="yes">&lt;!--</xsl:text>
    <xsl:value-of select="position()"/>
    <xsl:text disable-output-escaping="yes">--&gt;</xsl:text>

    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>

  </xsl:template>

  

  <xsl:template match="svg:style">

    <xsl:text disable-output-escaping="yes">&lt;!--</xsl:text>
    <xsl:value-of select="position()"/>
    <xsl:text disable-output-escaping="yes">--&gt;</xsl:text>



    <style>
      <xsl:value-of select="document('./style.xml')"/>
    </style>
  </xsl:template>

  
  <xsl:template match="svg:path">
    <!-- NOTE: the value of position() is a function of the chidren of the parent "<g>" node, including it's attributes. This means
	 if there is a "class" attribute on the "<g>" node we will have to account for it on the counter if we are trying to
	 accuratley count the number of child path elements starting at 1 --> 
    <xsl:variable name="i" select="position() - 1" />

    <xsl:text disable-output-escaping="yes">&lt;!--</xsl:text> position is <xsl:value-of select="position()"/> and $i is  <xsl:value-of select="$i"/> <xsl:text disable-output-escaping="yes">--&gt;</xsl:text>

    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
      <xsl:choose>
	<xsl:when test="$style='pattern-fill'">
	  <xsl:attribute name="class"> <xsl:value-of select="concat('fill', $i mod 48)"/></xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="class"> <xsl:value-of select="concat('group', $i mod 12)"/></xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>
          <xsl:attribute name="id"> <xsl:value-of select="concat('mypath', $i)"/></xsl:attribute>
    </xsl:copy>
  </xsl:template>
    
  
</xsl:stylesheet>
