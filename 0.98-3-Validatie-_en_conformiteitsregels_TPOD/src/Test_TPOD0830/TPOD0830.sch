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

    <sch:pattern id="TPOD_0830">
        <sch:rule context="//tekst:Lijst">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $WV"/>
            <sch:let name="ancestorsFout" value="foo:checkEersteNiveauLijstLettersTPOD_0830(.)"> </sch:let>
            <sch:let name="CONDITION" value="string-length($ancestorsFout) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> TPOD_0830:
                    <sch:value-of select="$ancestorsFout"/></sch:assert>
        </sch:rule>
    </sch:pattern>

    <xsl:function name="foo:checkEersteNiveauLijstLettersTPOD_0830">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="fout">
            <xsl:variable name="ancestors" select="count($context/ancestor-or-self::tekst:Lijst)"/>
            <xsl:if test="$ancestors = 1">
                <xsl:variable name="found">
                    <xsl:for-each select="$context/tekst:Li">
                        <xsl:if test="not(matches(tekst:LiNummer, '[a-z]{1}\.'))">
                            <xsl:value-of select="concat(tekst:LiNummer, ', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:if test="string-length($found)>0">
                    <xsl:variable name="lid" select="$context/ancestor::tekst:Lid"/>
                    <xsl:variable name="bijlage" select="$context/ancestor::tekst:Bijlage"/>
                    <xsl:choose>
                        <xsl:when test="$lid">
                            <xsl:value-of
                                select="concat('In lijst (op het eerste niveau) in artikel ', $lid/ancestor::tekst:Artikel/tekst:Kop/tekst:Nummer, ', lid ', $lid/tekst:LidNummer/text(), ' moeten onderdelen op het eerste niveau worden aangegeven met letters. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:when>
                        <xsl:when test="$bijlage">
                            <xsl:value-of
                                select="concat('In lijst (op het eerste niveau) in bijlage ', $context/ancestor::tekst:Bijlage/tekst:Kop/tekst:Nummer, ' moeten onderdelen op het eerste niveau worden aangegeven met letters. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="concat('In lijst (op het eerste niveau) in artikel ', $context/ancestor::tekst:Artikel/tekst:Kop/tekst:Nummer, ' moeten onderdelen op het eerste niveau worden aangegeven met letters. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$fout"/>
    </xsl:function>

</sch:schema>
