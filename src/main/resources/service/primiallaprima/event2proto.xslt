<!--
  Copyright 2012-2013 Trento RISE
  
     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this file except in compliance with the License.
     You may obtain a copy of the License at
  
         http://www.apache.org/licenses/LICENSE-2.0
  
     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.
-->
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
