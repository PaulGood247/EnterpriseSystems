<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="/">

		<html>
			<head>
				<title>Display Shipment</title>
				<style>
					.bold { font-weight: bold }
					.inlineBlock { display: inline-block }
				</style>
			</head>
			<body>
				<!-- Display the shipmentid attribute of the shipment node -->
				<p><span class="bold">Shipment Number:</span> <xsl:value-of select="shipment/@shipmentid" /></p>
				<br/>
				<br/>
				<!-- Display all the nodes in the consignor node -->
				<div class="inlineBlock">
					<p class="bold">Consignor:</p>
					<p><xsl:value-of select="shipment/consignor/name" /></p>
					<p><xsl:value-of select="shipment/consignor/address_line_1" /></p>
					<p><xsl:value-of select="shipment/consignor/address_line_2" /></p>
					<p><xsl:value-of select="shipment/consignor/address_line_3" /></p>
					<p><xsl:value-of select="shipment/consignor/address_line_4" /></p>
				</div>
				<!-- Display all the nodes in the consignee node -->
				<div class="inlineBlock">
					<p class="bold">Consignee:</p>
					<p><xsl:value-of select="shipment/consignee/name" /></p>
					<p><xsl:value-of select="shipment/consignee/address_line_1" /></p>
					<p><xsl:value-of select="shipment/consignee/address_line_2" /></p>
					<p><xsl:value-of select="shipment/consignee/address_line_3" /></p>
				</div>
				<!-- Call the write_total_weight template -->
				<p class="bold">Summary:</p>
				<xsl:call-template name="write_total_weight">
					<xsl:with-param name="total_weight" select="/shipment/details/total_weight"/>
					<xsl:with-param name="total_weight_uom" select="/shipment/details/total_weight_uom"/>
				</xsl:call-template>
				
				<br/>
				<br/>
				<!-- Apply the template that matches all shipment/item nodes -->
				<table style="width:100%; text-align:center;">
					<tr>
						<th>Sequence</th>
						<th>ID</th>
						<th>Title</th>
						<th>Note</th>
						<th>Quantity</th>
						<th>Price</th>
						<th>Line Total</th>
					</tr>
					<xsl:apply-templates select="shipment/item">
						<xsl:sort select="quantity" data-type="number" order="ascending"/>
					</xsl:apply-templates>
				</table>

		
			</body>
		</html>

	</xsl:template>

	<!-- The template that matches all shipment/item nodes -->
	<xsl:template match="/shipment/item">
		<tr>
			<td><xsl:value-of select="position()"/></td>
			<td><xsl:value-of select="id"/></td>
			<td><xsl:value-of select="title"/></td>
			<td><xsl:value-of select="note"/></td>
			<td><xsl:value-of select="quantity"/></td>
			<td><xsl:value-of select="price"/></td>
			<td><xsl:value-of select="format-number(quantity * price, '#.00')"/></td>
		</tr>
	</xsl:template>
	
	<!-- A template that displays the summary of the invoice -->
	<xsl:template name="write_total_weight">
		<xsl:param name="total_weight" />
		<xsl:param name="total_weight_uom"/>
		<xsl:variable name="total_number_of_items" select="count(shipment/item)" />
		<xsl:variable name="total_quantity"        select="sum(shipment/item/quantity)" />		
		Total number of items: <xsl:value-of select="$total_number_of_items" />
		<br/>
		Total Weight: <xsl:value-of select="$total_weight" />&#160;<xsl:value-of select="$total_weight_uom" />
		<br/>
		Average Weight Per Item Line: <xsl:value-of select="$total_weight div $total_number_of_items" />
		<br/>
		Total Quantity: <xsl:value-of select="$total_quantity" />
	</xsl:template>
</xsl:stylesheet>