<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing/v20190709" prefix="ga"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels-ref/v20190901" prefix="r-ref"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    
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

    <sch:pattern id="TPOD1850">
        <sch:rule context="//r:Regeltekst">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="fouten" value="foo:CheckFouteConstructiesTPOD_1850(.)"/>
            <sch:let name="CONDITION" value="string-length($fouten)=0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                H:TPOD1850: Alle Juridische regels binnen één Regeltekst moeten van hetzelfde type zijn, respectievelijk; Regel voor iedereen, Instructieregel of Omgevingswaarderegel. 
                Het Regeltekst waarom het gaat: <sch:value-of select="$fouten"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:CheckFouteConstructiesTPOD_1850">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="regeltekstId" select="$context/r:identificatie/text()"/>
        <xsl:variable name="ct" select="count($xmlDocuments//r:artikelOfLid/r-ref:RegeltekstRef[@xlink:href eq $regeltekstId])"/>
        <xsl:variable name="cr" select="count($xmlDocuments//r:RegelVoorIedereen/r:artikelOfLid/r-ref:RegeltekstRef[@xlink:href eq $regeltekstId])"/>
        <xsl:variable name="ci" select="count($xmlDocuments//r:Instructieregel/r:artikelOfLid/r-ref:RegeltekstRef[@xlink:href eq $regeltekstId])"/>
        <xsl:variable name="co" select="count($xmlDocuments//r:Omgevingswaarderegel/r:artikelOfLid/r-ref:RegeltekstRef[@xlink:href eq $regeltekstId])"/>
        <xsl:if test="not($ct=$cr or $ct=$ci or $ct=$co)">
            <xsl:value-of select="$regeltekstId"/>
        </xsl:if>                
    </xsl:function>

</sch:schema>
