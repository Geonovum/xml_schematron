<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels-ref/v20190901" prefix="r-ref"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/locatie/v20190901" prefix="l"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/locatie-ref/v20190901" prefix="l-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901" prefix="rol"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709" prefix="rol-ref"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing/v20190709" prefix="ga"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing-ref/v20190709" prefix="ga-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/geometrie-ref/v20190901" prefix="g-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/vrijetekst/v20190901" prefix="vt"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/vrijetekst-ref/v20190901" prefix="vt-ref"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/tekst/" prefix="tekst"/>
    <sch:ns uri="http://www.overheid.nl/2017/lvbb" prefix="lvbb"/>

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

    <sch:pattern id="TPOD_2060">
        <sch:rule context="//tekst:Artikel">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="message" value="foo:checkFouteArtikelLidCombinatieTPOD_2060(.)"/>
            <sch:let name="CONDITION" value="string-length($message) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD2050:
                    <sch:value-of select="$message"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <xsl:function name="foo:checkFouteArtikelLidCombinatieTPOD_2060">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="artikelWiD" select="string($context/@wId)"/>
        <xsl:variable name="wIds">
            <xsl:for-each select="$xmlDocuments//r:Regeltekst/@wId">
                <xsl:value-of select="concat('.', string(.), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name='newline'><xsl:text>&#10;</xsl:text></xsl:variable>
        <xsl:variable name="results">
            <xsl:for-each select="$context/tekst:Lid">
                <xsl:variable name="lidWiD" select="string(./@wId)"/>
                <xsl:variable name="rlidWiD" select="contains($wIds, concat('.', $lidWiD, '.'))"/>
                <xsl:variable name="rartikelWiD"
                    select="contains($wIds, concat('.', $artikelWiD, '.'))"/>
                <xsl:if
                    test="contains($wIds, concat('.', $lidWiD, '.')) and contains($wIds, concat('.', $artikelWiD, '.'))">
                    <xsl:value-of
                        select="concat('artikel-wId: ', $artikelWiD, ' --&gt; lid-wId: ', $lidWiD, ', ', $newline)"  disable-output-escaping="no"
                    />
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="message">
            <xsl:if test="string-length($results) > 0">
                <xsl:value-of
                    select="
                    concat('Als een verwijzing naar een Lid is gemaakt mag er geen verwijzing meer gemaakt worden naar het artikel dat boven dit Lid hangt.',$newline,'Betreft: ',
                    $results)"  disable-output-escaping="no"/>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$message"/>
    </xsl:function>

</sch:schema>
