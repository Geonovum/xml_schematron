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
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
    
    <!-- ====================================== GENERIC ============================================================================= -->
    <sch:let name="xmlDocuments" value="collection('.?select=*.xml')"/>
    <sch:let name="gmlDocuments" value="collection('.?select=*.gml')"/>
    <sch:let name="SOORT_REGELING" value="$xmlDocuments//stop:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>
    
    <sch:let name="AMvB" value="'/join/id/stop/regelingtype_001'"/>
    <sch:let name="MR" value="'/join/id/stop/regelingtype_002'"/>
    <sch:let name="OP" value="'/join/id/stop/regelingtype_003'"/>
    <sch:let name="OV" value="'/join/id/stop/regelingtype_004'"/>
    <sch:let name="WV" value="'/join/id/stop/regelingtype_005'"/>
    <sch:let name="OVI_PB" value="''"/>
    
    <!-- ============================================================================================================================ -->    
    
    <sch:pattern id="TDOP_1950">
        <sch:rule
            context="//l:Lijnengroep/l:groepselement">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="notFound">
                <xsl:for-each select="l-ref:LijnRef">
                    <sch:let name="identifiers"
                        value="foo:getIdentifiers($xmlDocuments//l:Lijn/l:identificatie)"/>
                    <sch:if test="not(contains($identifiers, @xlink:href))">
                        <xsl:value-of select="concat(@xlink:href, ', ')"/>
                    </sch:if>
                </xsl:for-each>
            </sch:let>
            <sch:let name="CONDITION" value="string-length($notFound) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> TDOP_1950: Betreft <sch:value-of
                select="../../name()"/>: <sch:value-of select="../l:identificatie"/>,
                <sch:value-of select="$notFound"/>: Iedere verwijzing naar een OwObject
                in een Lijnengroep moet een bestaand (ander) OwObject van het type Lijn zijn. </sch:assert>
        </sch:rule>
    </sch:pattern>

    <xsl:function name="foo:getIdentifiers">
        <xsl:param name="xpath" as="node()*"/>
        <sch:let name="identifiers">
            <xsl:for-each select="$xpath">
                <xsl:value-of select="text()"/>
            </xsl:for-each>
        </sch:let>
        <sch:value-of select="$identifiers"/>
    </xsl:function>

</sch:schema>
