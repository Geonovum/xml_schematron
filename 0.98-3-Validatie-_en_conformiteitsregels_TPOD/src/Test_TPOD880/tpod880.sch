<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/" xmlns:foo="http://whatever">

    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>

    <!-- ====================================== GENERIC ============================================================================= -->
    <xsl:variable name="xmlDocuments" select="collection('.?select=*.xml')"/>
    <xsl:variable name="gmlDocuments" select="collection('.?select=*.gml')"/>
    <xsl:variable name="SOORT_REGELING"
        select="$xmlDocuments//stop:AanleveringBesluit/stop:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>

    <xsl:variable name="AMvB" select="'/join/id/stop/regelingtype_001'"/>
    <xsl:variable name="MR" select="'/join/id/stop/regelingtype_002'"/>
    <xsl:variable name="OP" select="'/join/id/stop/regelingtype_003'"/>
    <xsl:variable name="OV" select="'/join/id/stop/regelingtype_004'"/>
    <xsl:variable name="WV" select="'/join/id/stop/regelingtype_005'"/>
    <xsl:variable name="OVI_PB" select="''"/>

    <!-- ============================================================================================================================ -->

    <sch:pattern id="TPOD880">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen/sl:objectType">
            <xsl:variable name="APPLICABLE"
                select="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <xsl:variable name="objects">
                <xsl:for-each select="../../../sl:stand/ow-dc:owObject/*">
                    <xsl:value-of select="concat('.', local-name(), '.')"/>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="CONDITION" select="contains($objects, concat('.', text(), '.'))"/>
            <xsl:variable name="ASSERT" select="($APPLICABLE and $CONDITION) or not($APPLICABLE)"/>
            <sch:assert test="$ASSERT"> H:TPOD1910: De
                objecttypen in ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen dienen
                overeen te komen met de daadwerkelijke objecten in het betreffende Ow-bestand. Het
                objecttype waarom het gaat staan nu genoemd: <xsl:value-of select="text()"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>


</sch:schema>
