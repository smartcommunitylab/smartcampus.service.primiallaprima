<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes" indent="yes" />
	<xsl:template match="/" xmlns:cl="xalan://it.sayservice.platform.core.bus.common.util.XSLTUtil">	
		address: "<xsl:value-of select="cl:escapeJava(normalize-space(translate(//div[@class='EventAddress']/text(),'\302\240','')))" />"
		<xsl:choose>
			<xsl:when test="normalize-space(//td[@class='Label' and @colspan='2']/B/text())!=''">
				type: "<xsl:value-of select="cl:escapeJava(normalize-space(//td[@class='Label' and @colspan='2']/B/text()))" />"
			</xsl:when>
			<xsl:otherwise>
				type: "ALTRO"
			</xsl:otherwise>
		</xsl:choose>
		contact: "<xsl:value-of select="cl:escapeJava(normalize-space(//div[@class='EventContatti']/text()))" />"
		contactUrl: "<xsl:value-of select="cl:escapeJava(normalize-space(//div[@class='EventUrl']/a/@href))" />"
		description: "<xsl:value-of select="cl:escapeJava(normalize-space(//td[@class='EventDesc']/text()))" />"
	</xsl:template>
</xsl:stylesheet>