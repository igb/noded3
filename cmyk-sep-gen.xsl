<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns="http://www.w3.org/2000/svg"
    version="1.0">	


  <xsl:output method="text" indent="yes"/>
  <xsl:strip-space elements="*"/>



  
  <xsl:template match="node() | @*">
   
    <xsl:copy>	
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>

  </xsl:template>	

  <xsl:template match="color">
    <xsl:variable name="unit">
      <xsl:call-template name="get_unit">
	<xsl:with-param name="c"><xsl:value-of select="c"/></xsl:with-param>
	<xsl:with-param name="m"><xsl:value-of select="m"/></xsl:with-param>
	<xsl:with-param name="y"><xsl:value-of select="y"/></xsl:with-param>
	<xsl:with-param name="k"><xsl:value-of select="k"/></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="$unit"/><xsl:text>&#160;</xsl:text><xsl:value-of select="c"/><xsl:text>&#160;</xsl:text><xsl:value-of select="m"/><xsl:text>&#160;</xsl:text><xsl:value-of select="y"/><xsl:text>&#160;</xsl:text><xsl:value-of select="k"/><xsl:text>&#xa;</xsl:text>
    </xsl:template>


  <xsl:template name="get_unit">
    <xsl:param name="c"/>
    <xsl:param name="m"/>
    <xsl:param name="y"/>
    <xsl:param name="k"/>

    <xsl:variable name="c_val" select="floor($c div 10)"/>
    <xsl:variable name="m_val" select="floor($m div 10)"/>
    <xsl:variable name="y_val" select="floor($y div 10)"/>
    <xsl:variable name="k_val" select="floor($k div 10)"/>

    <xsl:call-template name="gcd">
      <xsl:with-param name="x"><xsl:value-of select="$c_val"/></xsl:with-param>
      <xsl:with-param name="y">
	<xsl:call-template name="gcd">
	  <xsl:with-param name="x"><xsl:value-of select="$m_val"/></xsl:with-param>
	  <xsl:with-param name="y">
	    <xsl:call-template name="gcd">
	      <xsl:with-param name="x"><xsl:value-of select="$y_val"/></xsl:with-param>
	      <xsl:with-param name="y"><xsl:value-of select="$k_val"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:with-param>
	</xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
        
  </xsl:template>

  <xsl:template name="gcd">
    <xsl:param name="x"/>
    <xsl:param name="y"/>
    <xsl:choose>
      <xsl:when test="$x=0"><xsl:value-of select="$y"/></xsl:when>
       <xsl:when test="$y=0"><xsl:value-of select="$x"/></xsl:when>
      <xsl:when test="$x=$y"><xsl:value-of select="$y"/></xsl:when>
      <xsl:otherwise>
	<xsl:choose>
	  <xsl:when test="$y &gt; $x">
	    <xsl:call-template name="gcd">
	      <xsl:with-param name="x"><xsl:value-of select="$y"/></xsl:with-param>
	      <xsl:with-param name="y"><xsl:value-of select="$x"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:when test="($x mod $y)=0"><xsl:value-of select="$y"/></xsl:when>
	  <xsl:otherwise>
	    <xsl:call-template name="gcd">
	      <xsl:with-param name="x"><xsl:value-of select="$x"/></xsl:with-param>
	      <xsl:with-param name="y"><xsl:value-of select="$y - 1"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
