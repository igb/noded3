<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	    <xsl:output method="xml"/>
	    <xsl:strip-space elements="*"/>
	    <xsl:template match="node() | @*">
	    	<xsl:copy>
			<xsl:apply-templates select="node() | @*"/>
		</xsl:copy>
	     </xsl:template>

	     <xsl:template match="foo">
	    	<xsl:copy>
			     <xsl:variable name="foo_count"  select="position()"/>
			     <xsl:for-each select="document('merge-source-002.xml')/stuff/bar">
			     	<xsl:variable name="bar_count"  select="position()"/>	
			     <xsl:choose>
			       <xsl:when test="$foo_count = $bar_count">
					<xsl:value-of select="current()"/>
				</xsl:when>
			     </xsl:choose>
				</xsl:for-each>
		<xsl:apply-templates select="node() | @*"/>
		</xsl:copy>
	     	
	     </xsl:template>
 </xsl:stylesheet>

