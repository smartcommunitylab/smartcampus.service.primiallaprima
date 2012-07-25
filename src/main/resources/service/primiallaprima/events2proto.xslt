<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes" indent="yes" />
	<xsl:template match="/" xmlns:cl="xalan://it.sayservice.platform.core.bus.common.util.XSLTUtil" xmlns:du="xalan://it.sayservice.platform.core.bus.common.util.DateUtil">
		<xsl:variable name="infoUrl" select="'http://www.buonconsiglio.com/free?service=EventInfo&amp;codEvento='" />
		<xsl:for-each select="//table/tr[position() mod 2 = 1]">
			<xsl:variable name="rawId" select="substring-before(substring-after(td/a[1]/@href,'('), ')')" />
			<xsl:variable name="id" select="cl:escapeJava(normalize-space(substring($rawId, 2, string-length($rawId) - 2)))" />
			<xsl:variable name="eventLocation" select="following-sibling::tr[1]/td/div[@class='EventLocation']/text()" />
			<xsl:variable name="luogo" select="normalize-space(substring-before($eventLocation, ' - '))" />
			<xsl:variable name="city" select="substring-after($eventLocation, ' - ')" />
			<xsl:variable name="eventDate" select="cl:escapeJava(normalize-space(following-sibling::tr[1]/td/div[@class='EventDate']/text()))" />
			<xsl:variable name="day" select="substring($eventDate, 1, string-length($eventDate) - 6)" />
			<xsl:variable name="hour" select="substring($eventDate, string-length($eventDate) - 4)" />
			<xsl:variable name="title" select="cl:escapeJava(normalize-space(td/a[@class='EventTitle']/text()))" />
			event {
				id: "<xsl:value-of select="$id" />"
				infoUrl: "<xsl:value-of select="concat($infoUrl, $id)" />"
				title: "<xsl:value-of select="$title" />"
				<xsl:choose>
					<xsl:when test="substring($luogo, string-length($luogo))='.' or substring($luogo, string-length($luogo))=':'">
						luogo: "<xsl:value-of select="cl:escapeJava(substring($luogo, 1, string-length($luogo)-1))" />"
					</xsl:when>
					<xsl:otherwise>
						luogo: "<xsl:value-of select="cl:escapeJava($luogo)" />"
					</xsl:otherwise>
				</xsl:choose>
				city: "<xsl:value-of select="cl:escapeJava(normalize-space($city))" />"
				day: "<xsl:value-of select="cl:escapeJava(normalize-space($day))" />"
				hour: "<xsl:value-of select="cl:escapeJava(normalize-space($hour))" />"
				detail {
				}
			}
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>