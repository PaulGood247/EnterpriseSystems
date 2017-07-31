<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/PackageName">
        <Package>
            <TransmissionID><xsl:value-of select="@TransmissionID"/></TransmissionID>
            <PackageType>PackageName</PackageType>
            <xsl:copy-of select="Version"/>
            <xsl:copy-of select="DateReported"/>
            <xsl:copy-of select="TimeReported"/>
            <Disposition><xsl:value-of select="ReportPackage/@Status"/></Disposition>
            <packageID><xsl:value-of select="ReportPackage/Parts/@packageID"/></packageID>
            <packageClientAccount><xsl:value-of select="ReportPackage/Parts/packageClientAccount"/></packageClientAccount>
            <Addresses>
                <PersonAddress>
                    <xsl:apply-templates select="ReportPackage/Addresses/Address"/>
                </PersonAddress>
                <VendorAddress>
                    <xsl:apply-templates select="ReportPackage/Parts//PartVendor"/>
                </VendorAddress>
            </Addresses>
            <xsl:apply-templates select="ReportPackage/Parts"/>
            <AdditionalData>
                <Vendor><xsl:value-of select=".//PartVendor/VendorName"/></Vendor>
                <Mode><xsl:value-of select=".//AdditionalItems[@qualifier='mode']/Text"/></Mode>
                <Indicator><xsl:value-of select=".//AdditionalItems[@qualifier='indicator']/Text"/></Indicator>
            </AdditionalData>
        </Package>
    </xsl:template>

    <xsl:template match="Parts">
        <Parts>
            <AssemblyId>
                <xsl:attribute name="id">
                    <xsl:value-of select=".//AssemblyId/IdValue"/>
                </xsl:attribute>
                <Status><xsl:value-of select=".//AssemblyStatus/Status"/></Status>
                <DateReOrderReceived><xsl:value-of select=".//AssemblyStatus/DateReOrderReceived"/></DateReOrderReceived>
                <xsl:for-each select=".//PartsMainSegment/AdditionalSegment/PartSpecs/Spec">
                    <Part>
                        <xsl:variable name="part-id" select="PartId"/>
                        <PartId><xsl:value-of select="PartId"/></PartId>
                        <PartName><xsl:value-of select="Name"/></PartName>
                        <Level><xsl:value-of select="ThresholdLevel"/></Level>
                        <PartType><xsl:value-of select="//AdditionallPartsSegment/Spec[PartId = $part-id]/PartType"/></PartType>
                    </Part>
                </xsl:for-each>
            </AssemblyId>
        </Parts>
    </xsl:template>

    <xsl:template match="Address">
        <Name><xsl:value-of select="Name"/></Name>
        <Address><xsl:value-of select="Address"/></Address>
        <City><xsl:value-of select="City"/></City>
        <State><xsl:value-of select="State"/></State>
        <Zip><xsl:value-of select="Zip"/></Zip>
        <Phone><xsl:value-of select="Phone"/></Phone>
    </xsl:template>

    <xsl:template match="PartVendor">
        <Name><xsl:value-of select="VendorName"/></Name>
        <Address><xsl:value-of select="VendorAddress/IdValue[@name='Address']"/></Address>
        <City><xsl:value-of select="VendorAddress/IdValue[@name='City']"/></City>
        <State><xsl:value-of select="VendorAddress/IdValue[@name='State']"/></State>
        <Zip><xsl:value-of select="VendorAddress/IdValue[@name='Zip']"/></Zip>
        <Phone><xsl:value-of select="VendorAddress/IdValue[@name='Phone']"/></Phone>
    </xsl:template>

</xsl:stylesheet>