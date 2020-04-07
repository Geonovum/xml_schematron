<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:r-ref="http://www.geostandaarden.nl/imow/regels-ref/v20190901"
    xmlns:l-ref="http://www.geostandaarden.nl/imow/locatie-ref/v20190901"
    xmlns:l="http://www.geostandaarden.nl/imow/locatie/v20190901"
    xmlns:g-ref="http://www.geostandaarden.nl/imow/geometrie-ref/v20190901"
    xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:lvbb="http://www.overheid.nl/2017/lvbb"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/">
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing/v20190709" prefix="ga"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901" prefix="rol"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709" prefix="rol-ref"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels-ref/v20190901" prefix="r-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/vrijetekst/v20190901" prefix="vt"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/kaartrecept/v20190901" prefix="k"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/pons/v20190901" prefix="p"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/tekst/" prefix="tekst"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>

    <!-- ====================================== GENERIC ============================================================================= -->
    <sch:let name="xmlDocuments" value="collection('.?select=*.xml')"/>
    <sch:let name="gmlDocuments" value="collection('.?select=*.gml')"/>
    <sch:let name="SOORT_REGELING"
        value="$xmlDocuments//stop:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>

    <sch:let name="AMvB" value="'/join/id/stop/regelingtype_001'"/>
    <sch:let name="MR" value="'/join/id/stop/regelingtype_002'"/>
    <sch:let name="OP" value="'/join/id/stop/regelingtype_003'"/>
    <sch:let name="OV" value="'/join/id/stop/regelingtype_004'"/>
    <sch:let name="WV" value="'/join/id/stop/regelingtype_005'"/>
    <sch:let name="OVI_PB" value="''"/>

    <!-- ============================================================================================================================ -->

    <sch:pattern id="TPOD_0781">
        <sch:rule context="//tekst:Artikel">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OV"/>
            <sch:let name="artikel" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="bevatLetters" value="foo:bevatGeletterdeNummersTPOD_0781(.)"/>
            <sch:let name="CONDITION_1" value="string-length($bevatLetters) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_1) or not($APPLICABLE)"> 
                TPOD_0781: De nummering van Leden bevat letters en kan niet middels schematron op geldigheid worden gecheckt.
                Dit moet handmatig gebeuren. (betreft artikelen, leden e.a.):<sch:value-of
                    select="$artikel"/>: <sch:value-of
                        select="substring($bevatLetters, 1, string-length($bevatLetters) - 2)"/></sch:assert>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0781(.)"/>
            <sch:let name="CONDITION_2" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_2) or not($APPLICABLE)"> 
                TPOD_0781: Leden moeten per artikel oplopend genummerd worden in Arabische cijfers
                (en indien nodig, een letter). (betreft artikelen, leden): <sch:value-of
                    select="$artikel"/>: <sch:value-of
                    select="substring($volgorde, 1, string-length($volgorde) - 2)"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:bevatGeletterdeNummersTPOD_0781">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="bevatLetters">
            <xsl:for-each select="$context/tekst:Lid">
                    <xsl:if test="matches(tekst:LidNummer, '\d{1,2}[a-z]{1,2}\.')">
                            <xsl:value-of select="concat(string(tekst:LidNummer),', ')"/>
                    </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$bevatLetters"/>
    </xsl:function>

    <xsl:function name="foo:volgordeTPOD_0781">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Lid">
                <xsl:variable name="pos" select="position()"/>
                <xsl:choose>
                    <xsl:when test="(matches(tekst:LidNummer, '\d{1,2}\.')) or (matches(tekst:LidNummer, '\d{1,2}[a-z]{1}\.'))">
                        <xsl:if test="matches(tekst:LidNummer, '\d{1,2}\.')">
                            <xsl:if test="not(string(tekst:LidNummer)=concat(string($pos), '.'))">
                                <xsl:value-of select="concat(string(tekst:LidNummer),', ')"/>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="matches(tekst:LidNummer, '\d{1,2}[a-z]{1}\.')">
                            <xsl:if test="not(string(tokenize(tekst:LidNummer,'[a-z]{1}')[1])=string($pos)) and not(ends-with(tekst:LidNummer, '.'))">
                                <xsl:value-of select="concat(string(tekst:LidNummer),', ')"/>
                            </xsl:if>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(string(tekst:LidNummer),', ')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>

</sch:schema>
