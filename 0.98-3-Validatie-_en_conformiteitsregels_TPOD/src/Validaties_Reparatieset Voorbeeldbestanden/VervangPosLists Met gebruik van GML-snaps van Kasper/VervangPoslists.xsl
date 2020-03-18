<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:gml="http://www.opengis.net/gml/3.2"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:output method="xml"/>

    <xsl:variable name="baseName" select="'Nieuwe_Hollandse_Waterline'"/>
    <xsl:variable name="IN" select="document(concat('Opdracht/', $baseName, '_snap.gml'))"/>
    <xsl:variable name="ORG" select="document(concat('Opdracht/', $baseName, '.gml'))"/>
    <xsl:variable name="OUT" select="concat($baseName, '_out.gml')"/>

    <xsl:variable name="snap_poslists" as="element()*">
        <xsl:for-each select="$IN//gml:posList">
            <xsl:element name="gml:posList">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="org_poslists" as="element()*">
        <xsl:for-each select="$ORG//gml:posList">
            <xsl:element name="gml:posList">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:variable name="inCount" select="count($snap_poslists)"/>
        <xsl:variable name="orgCount" select="count($org_poslists)"/>
        <xsl:value-of select="' SNAP: '"/>
        <xsl:value-of select="$inCount"/>
        <xsl:value-of select="' ORG: '"/>
        <xsl:value-of select="$orgCount"/>

        <xsl:variable name="out_xml"> </xsl:variable>

        <xsl:result-document href="{$OUT}" method="xml">
            <xsl:copy>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @* except gml:posList"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//gml:posList">
        <xsl:variable name="posList" select="."/>
        <xsl:for-each select="$org_poslists">
            <xsl:if test=". eq $posList">
                <xsl:variable name="pos" select="position()"/>
                <xsl:variable name="snapList">
                    <xsl:for-each select="$snap_poslists">
                        <xsl:if test="$pos = position()">
                            <xsl:value-of select="./text()"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:copy>
                    <xsl:value-of select="$snapList"/>
                </xsl:copy>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
