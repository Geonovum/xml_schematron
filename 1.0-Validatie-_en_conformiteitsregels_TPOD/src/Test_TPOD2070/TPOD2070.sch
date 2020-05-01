<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="ow"/>
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

    <sch:pattern id="TPOD_2070">
        <sch:rule context="//rol:Activiteit/@ow:regeltekstId">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION" value="foo:checkOwRegeltekstIdverwijzingTPOD_2070(.)=true()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2070: Alleen v0.98 | Als de activiteit een bepaalde regeltekstID heeft dan moet deze overeenkomen met de ID die je via de Activiteit --> RegelVoorIedereen --> Regeltekst vindt.: 
                ActiviteitId: <sch:value-of select="../rol:identificatie/text()"/>, ow:regeltekstId: <sch:value-of select="string(.)"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>


    <xsl:function name="foo:checkOwRegeltekstIdverwijzingTPOD_2070">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="regelId" select="string($context)"/>
        <xsl:variable name="activiteitId" select="$context/../rol:identificatie/text()"/>
        <xsl:variable name="foundRegelTekst">
            <xsl:if test="not(string($regelId) = '')">
                <xsl:for-each select="$xmlDocuments//r:RegelVoorIedereen">
                    <xsl:if test="
                        string(r:activiteitaanduiding/rol-ref:ActiviteitRef/@xlink:href)=$activiteitId 
                        and 
                        string(r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href)=$regelId
                        ">
                        <xsl:value-of select="$activiteitId"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:if>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$foundRegelTekst=$activiteitId">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

</sch:schema>