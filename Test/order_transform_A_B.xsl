<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes"/>
 
 
 <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" />
    </xsl:copy>
  </xsl:template>

<xsl:template match="order">
    <order_document><xsl:value-of select="." /></order_document>
 </xsl:template>
 
 
 <xsl:template match="order/person">
    <parties></parties>
 </xsl:template>
 
 <xsl:template match="order/shipto">
    <ship_to><xsl:value-of select="." /></ship_to>
 </xsl:template>

	
	
</xsl:stylesheet>