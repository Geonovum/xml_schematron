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

    <!-- ====================================== GENERIC ============================================================================= -->
    <xsl:variable name="xmlDocuments" select="collection('.?select=*.xml')"/>
    <xsl:variable name="gmlDocuments" select="collection('.?select=*.gml')"/>
    <xsl:variable name="SOORT_REGELING" select="$xmlDocuments//stop:AanleveringBesluit/stop:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>
    
    <xsl:variable name="AMvB" select="'/join/id/stop/regelingtype_001'"/>
    <xsl:variable name="MR" select="'/join/id/stop/regelingtype_002'"/>
    <xsl:variable name="OP" select="'/join/id/stop/regelingtype_003'"/>
    <xsl:variable name="OV" select="'/join/id/stop/regelingtype_004'"/>
    <xsl:variable name="WV" select="'/join/id/stop/regelingtype_005'"/>
    <xsl:variable name="OVI_PB" select="''"/>
    
    <!-- ============================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1990">
        <sch:rule context="/">
            <xsl:variable name="APPLICABLE" select="true()"/>
            <xsl:variable name="geoLocationGeoReferenceIdentifiers"
                select="foo:getLocationGeoReferenceIdentifiers()"/>
            <xsl:variable name="nietGerefereerdeGeometrieen">
                <xsl:for-each select="$gmlDocuments//geo:Geometrie">
                    <xsl:if
                        test="not(contains($geoLocationGeoReferenceIdentifiers, concat('.', string(geo:id/text()), '.')))">
                        <xsl:value-of select="concat(string(geo:id/text()), ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="CONDITION" select="string-length($nietGerefereerdeGeometrieen) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1990: Ieder OwObject, behalve Activiteit heeft minstens een OwObject dat ernaar verwijst.:
                    <xsl:value-of select="$nietGerefereerdeGeometrieen"/>
            </sch:assert>
        </sch:rule>

        <sch:rule context="//r:Regeltekst/r:identificatie">
            <xsl:variable name="APPLICABLE" select="true()"/>
            <xsl:variable name="regeltekstReferenties"
                select="foo:getReferences(//r-ref:RegeltekstRef)"/>
            <xsl:variable name="nietGerefereerdeReferenties">
                <xsl:if
                    test="not(contains($regeltekstReferenties, concat('.', text(), '.')))">
                    <xsl:value-of select="concat(string(text()), ', ')"/>
                </xsl:if>
            </xsl:variable>
            <xsl:variable name="CONDITION" select="string-length($nietGerefereerdeReferenties) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1990: Ieder OwObject, behalve Activiteit heeft minstens een OwObject dat ernaar verwijst.:
                <xsl:value-of select="$nietGerefereerdeReferenties"/>
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="//(vt:FormeleDivisie|vt:Hoofdlijn)/vt:identificatie">
            <xsl:variable name="APPLICABLE" select="true()"/>
            <xsl:variable name="formeleDivisieReferenties"
                select="foo:getReferences(//(vt-ref:FormeleDivisieRef|vt-ref:HoofdlijnRef))"/>
            <xsl:variable name="nietGerefereerdeReferenties">
                <xsl:if
                    test="not(contains($formeleDivisieReferenties, concat('.', text(), '.')))">
                    <xsl:value-of select="concat(string(text()), ', ')"/>
                </xsl:if>
            </xsl:variable>
            <xsl:variable name="CONDITION" select="string-length($nietGerefereerdeReferenties) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1990: Ieder OwObject, behalve Activiteit heeft minstens een OwObject dat ernaar verwijst.:
                <xsl:value-of select="$nietGerefereerdeReferenties"/>
            </sch:assert>
        </sch:rule>

        <sch:rule context="//l:identificatie">
            <xsl:variable name="APPLICABLE" select="true()"/>
            <xsl:variable name="locatieReferenties"
            select="foo:getLocationReferenceIdentifiers()"/>
        <xsl:variable name="nietGerefereerdeReferenties">
            <xsl:if
                test="not(contains($locatieReferenties, concat('.', text(), '.')))">
                <xsl:value-of select="concat(string(text()), ', ')"/>
            </xsl:if>
        </xsl:variable>
            <xsl:variable name="CONDITION" select="string-length($nietGerefereerdeReferenties) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1990: Ieder OwObject, behalve Activiteit heeft minstens een OwObject dat ernaar verwijst.:
            <xsl:value-of select="$nietGerefereerdeReferenties"/>
        </sch:assert>
    </sch:rule>
    
    </sch:pattern>

    <xsl:function name="foo:getReferences">
        <xsl:param name="xpath" as="node()*"/>
        <xsl:variable name="references">
            <xsl:for-each select="$xmlDocuments//$xpath">
                <xsl:value-of select="concat('.', string(@xlink:href), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$references"/>
    </xsl:function>

    <xsl:function name="foo:getLocationGeoReferenceIdentifiers">
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xmlDocuments//g-ref:GeometrieRef">
                <xsl:value-of select="concat('.', string(@xlink:href), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <xsl:function name="foo:getLocationReferenceIdentifiers">
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xmlDocuments//(l-ref:LocatieRef|l-ref:GebiedRef|l-ref:LijnRef|l-ref:PuntRef|l-ref:GebiedengroepRef|l-ref:PuntengroepRef|l-ref:LijnengroepRef)">
                <xsl:value-of select="concat('.', string(@xlink:href), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
</sch:schema>
