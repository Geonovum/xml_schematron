<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/">
        <xsl:for-each select="document('instance.svrlt')//svrl:schematron-output/svrl:failed-assert/svrl:text">
            <xsl:value-of select="./text()"/>
        </xsl:for-each>
        <!--<xsl:for-each select="document('instance.svrlt')//svrl:schematron-output/svrl:successful-report/svrl:text">
            <xsl:value-of select="./text()"/>
        </xsl:for-each>-->
    </xsl:template>
    
</xsl:stylesheet>