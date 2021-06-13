<xsl:stylesheet	
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">	


  <xsl:output method="text" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:param name="color" select="'color'"/>
  <xsl:param name="filename" select="'filename'"/>
  


  
  <xsl:template match="node() | @*">
      <xsl:apply-templates select="color"/>
  </xsl:template>	

  <xsl:template match="color">
    <xsl:if test="$color = @name">

      <xsl:variable name="c"><xsl:value-of select="c"/></xsl:variable>
      <xsl:variable name="m"><xsl:value-of select="m"/></xsl:variable>
      <xsl:variable name="y"><xsl:value-of select="y"/></xsl:variable>
      <xsl:variable name="k"><xsl:value-of select="k"/></xsl:variable>
      
      
      <xsl:variable name="unit">
	<xsl:call-template name="get_unit">
	  <xsl:with-param name="c"><xsl:value-of select="$c"/></xsl:with-param>
	  <xsl:with-param name="m"><xsl:value-of select="$m"/></xsl:with-param>
	  <xsl:with-param name="y"><xsl:value-of select="$y"/></xsl:with-param>
	  <xsl:with-param name="k"><xsl:value-of select="$k"/></xsl:with-param>
	</xsl:call-template>
      </xsl:variable>
      
      <xsl:variable name="c_unit" select="((floor($c div 10)) * 10) div $unit"/>
      <xsl:variable name="m_unit" select="((floor($m div 10)) * 10) div $unit"/>
      <xsl:variable name="y_unit" select="((floor($y div 10)) * 10) div $unit"/>
      <xsl:variable name="k_unit" select="((floor($k div 10)) * 10) div $unit"/>
      

      <xsl:variable name="step"  select="floor(180 div ($c_unit + $m_unit + $y_unit + $k_unit))"/>
      <xsl:variable name="init_angle" select="'180'"/>
      <xsl:variable name="color" select="@name"/>
      

      <xsl:call-template name="generate_separation">
	<xsl:with-param name="color"><xsl:value-of select="$color"/></xsl:with-param>
	<xsl:with-param name="cmyk">c</xsl:with-param>
	<xsl:with-param name="step"><xsl:value-of select="$step"/></xsl:with-param>
	<xsl:with-param name="unit"><xsl:value-of select="$c_unit * $step"/></xsl:with-param>
	<xsl:with-param name="angle">0</xsl:with-param>
      </xsl:call-template>

      
      <xsl:call-template name="generate_separation">
	<xsl:with-param name="color"><xsl:value-of select="$color"/></xsl:with-param>
	<xsl:with-param name="cmyk">m</xsl:with-param>
	<xsl:with-param name="step"><xsl:value-of select="$step"/></xsl:with-param>
	<xsl:with-param name="unit"><xsl:value-of select="$m_unit * $step"/></xsl:with-param>
	<xsl:with-param name="angle"><xsl:value-of select="$c_unit * $step"/></xsl:with-param>
      </xsl:call-template>
	      
      <xsl:call-template name="generate_separation">
	<xsl:with-param name="color"><xsl:value-of select="$color"/></xsl:with-param>
	<xsl:with-param name="cmyk">y</xsl:with-param>
	<xsl:with-param name="step"><xsl:value-of select="$step"/></xsl:with-param>
	<xsl:with-param name="unit"><xsl:value-of select="$y_unit * $step"/></xsl:with-param>
	<xsl:with-param name="angle"><xsl:value-of select="($c_unit + $m_unit) * $step"/></xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="generate_separation">
	<xsl:with-param name="color"><xsl:value-of select="$color"/></xsl:with-param>
	<xsl:with-param name="cmyk">k</xsl:with-param>
	<xsl:with-param name="step"><xsl:value-of select="$step"/></xsl:with-param>
	<xsl:with-param name="unit"><xsl:value-of select="$k_unit * $step"/></xsl:with-param>
	<xsl:with-param name="angle"><xsl:value-of select="($c_unit + $m_unit + $y_unit) * $step"/></xsl:with-param>
      </xsl:call-template>	      
	
      
    </xsl:if>
  </xsl:template>

  <xsl:template name="generate_separation">
    
    <xsl:param name="color"/>
    <xsl:param name="cmyk"/>
    <xsl:param name="step"/>
    <xsl:param name="unit"/>
    <xsl:param name="angle"/>

      <xsl:if test="$unit &gt;  0">
	<xsl:value-of select="concat('xsltproc --stringparam hatchAngle ', $angle, ' hatchscript-rotate.xsl   ~/Library/Application\ Support/org.inkscape.Inkscape/config/inkscape/preferences.xml &gt; /tmp/preferences.xml;')"/>
	<xsl:text>
	</xsl:text>
	<xsl:value-of select="string('cp /tmp/preferences.xml   ~/Library/Application\ Support/org.inkscape.Inkscape/config/inkscape/;')"/>
	<xsl:text>
	</xsl:text>
	<xsl:value-of select="concat('cp ', $filename,  ' /tmp/',$color,'-',$cmyk, '-', $angle,'.svg;')"/>
	<xsl:text>
	</xsl:text>
	<xsl:value-of select="concat('/Applications/Inkscape.app/Contents/MacOS/inkscape -g  --verb &quot;command.evilmadscientist.eggbot_hatch.noprefs; FileSave; FileQuit&quot; /tmp/',$color,'-',$cmyk, '-', $angle,'.svg;')"/>
	<xsl:text>
	</xsl:text>
	<xsl:value-of select="concat('xsltproc extract-fillpaths.xsl  /tmp/',$color,'-',$cmyk, '-', $angle,'.svg >  /tmp/hatch-',$color,'-',$cmyk, '-', $angle,'.svg;')"/>
	<xsl:text>
	</xsl:text>
	<xsl:text>
	</xsl:text>
	<xsl:text>
	</xsl:text>
	<xsl:call-template name="generate_separation">
	  <xsl:with-param name="color"><xsl:value-of select="$color"/></xsl:with-param>
	  <xsl:with-param name="cmyk"><xsl:value-of select="$cmyk"/></xsl:with-param>
	  <xsl:with-param name="step"><xsl:value-of select="$step"/></xsl:with-param>
	  <xsl:with-param name="unit"><xsl:value-of select="$unit - $step"/></xsl:with-param>
	  <xsl:with-param name="angle"><xsl:value-of select="$angle + $step"/></xsl:with-param>
	</xsl:call-template>
      </xsl:if>
  </xsl:template>
  
  
  <xsl:template name="get_unit">
    
    <xsl:param name="c"/>
    <xsl:param name="m"/>
    <xsl:param name="y"/>
    <xsl:param name="k"/>

    <xsl:variable name="c_val" select="floor($c div 10) * 10"/>
    <xsl:variable name="m_val" select="floor($m div 10) * 10"/>
    <xsl:variable name="y_val" select="floor($y div 10) * 10"/>
    <xsl:variable name="k_val" select="floor($k div 10) * 10"/>

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
