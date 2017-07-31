<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
		<html>
			<head>
				<title>Display Shipment</title>
			</head>
			<body>
			<!--<xsl:apply-templates/>-->
			<xsl:call-template name="write_total_weight"/>
			
			
			
			
			
			</body>
		</html>
	</xsl:template>
	<xsl:template match="/shipment/item">
		<!--Shipment Number : <xsl:value-of select="title" />-->
		
		
	
	
	</xsl:template>
	<xsl:template name="write_total_weight">
		<xsl:param name="total_weight"/>
		<xsl:param name="total_weight_uom"/>
	
		
			<b>Shipment Number : </b> <xsl:value-of select="shipment/@shipmentid" /><br/><br/>
			<b>Cosignor:  </b> <xsl:value-of select="shipment/consignor" />  
			<b>Cosignee:  </b> <xsl:value-of select="shipment/consignee" /> <br/><br/>
			
			<b>Summary:  </b> <br/>
			Total number of items:  <xsl:value-of select="count(/shipment/item)" /><br/>
			Total Weight: <xsl:value-of select="shipment/details/total_weight" /><xsl:value-of select="shipment/details/total_weight_uom" /><br/>
			Average Weight Per Item Line: <xsl:value-of select="format-number(shipment/details/total_weight div count(/shipment/item), '#,##0')" /><br/>
			Total quantity: <xsl:value-of select="sum(/shipment/item/quantity)" /><br/><br/>
			
		
			<b>Sequence ID Title Note Quantity Price Line Total </b><br/>
			<xsl:for-each select="shipment/item">
				<xsl:value-of select="id" />&#160;
				<xsl:value-of select="title" />&#160;
				<xsl:value-of select="note" />&#160;
				<xsl:value-of select="quantity" />&#160;
				<xsl:value-of select="price" />&#160;
				<xsl:value-of select="format-number(quantity*price ,'#,##0.00')" />&#160;
				<br/>
			
			</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>