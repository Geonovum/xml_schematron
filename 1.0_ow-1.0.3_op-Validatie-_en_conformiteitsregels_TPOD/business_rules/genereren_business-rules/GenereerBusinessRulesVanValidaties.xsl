<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes"/>

    <xsl:variable name="validaties" select="document('validaties.sch')"/>
    <xsl:variable name="vars" select="$validaties/*/xsl:variable" />
    
    <xsl:template name="makeIndex">
        <xsl:param name="pText"/>
        <xsl:if test="string-length($pText)>0">
            <item>
                <xsl:value-of select=
                    "substring-before(concat($pText,' '), ' ')"/>
            </item>
            <xsl:call-template name="makeIndex">
                <xsl:with-param name="pText" select=
                    "substring-after($pText,' ')"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template match="/">
        <xsl:element name="BusinessRules" namespace="https://standaarden.overheid.nl/stop/imop/businessrules/">
            <xsl:namespace name="xsi" select="'http://www.w3.org/2001/XMLSchema-instance'"></xsl:namespace>
            <xsl:attribute name="schemaversie" select="'1.0.3'"></xsl:attribute>
            <xsl:attribute name="xsi:schemaLocation" select="'https://standaarden.overheid.nl/stop/imop/businessrules/ https://standaarden.overheid.nl/stop/1.0.3/imop-businessrules.xsd'"></xsl:attribute>
            <xsl:for-each-group select="$validaties/sch:schema/sch:pattern"
                group-by="sch:param[@name eq 'businessRuleGroup']/@value" xmlns:sch="http://purl.oclc.org/dsdl/schematron">
                <!--  name="{substring(current-grouping-key(),2)} -->
                <xsl:element name="businessRuleGroup">
                    <xsl:variable name="id" select="substring(current-grouping-key(), 2)"/>
                    <xsl:element name="groepsnaam"><xsl:value-of select="translate(substring(current-grouping-key(), 2),'_','/')"/></xsl:element>
                    <xsl:element name="id"><xsl:value-of select="$id"/></xsl:element>
                    <xsl:variable name="arrayName" select="concat($id,'_BRG')"/>
                    <xsl:variable name="array" select="$vars[@name = $arrayName]/@select"/>
                    <xsl:variable name="vrtfDoc">
                        <xsl:call-template name="makeIndex">
                            <xsl:with-param name="pText" select="$array"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:variable name="arrayIndexed" select="ext:node-set($vrtfDoc)/*" xmlns:ext="http://exslt.org/common"/>
                    <xsl:element name="geldtvoor">
                        <xsl:for-each select="$arrayIndexed">
                            <xsl:element name="soortRegeling"><xsl:value-of select="concat('/join/id/stop',.)"/></xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                    <xsl:element name="geldendeBusinessRules">
                        <xsl:for-each select="current-group()">
                            <xsl:element name="BusinessRule">
                                <xsl:element name="code">
                                    <xsl:value-of select="string(@id)"/>
                                </xsl:element>
                                <xsl:element name="ernst">
                                    <xsl:choose>
                                        <xsl:when test="string(@is-a) = 'abstractPatternWarning'">
                                            <xsl:value-of select="'waarschuwing'"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="'fout'"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:element>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each-group>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>
