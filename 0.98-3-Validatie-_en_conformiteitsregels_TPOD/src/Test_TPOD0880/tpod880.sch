<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:tekst="https://standaarden.overheid.nl/stop/imop/tekst/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/" xmlns:foo="http://whatever">

    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/tekst/" prefix="tekst"/>

    <!-- ====================================== GENERIC ============================================================================= -->
    <xsl:variable name="xmlDocuments" select="collection('.?select=*.xml')"/>
    <xsl:variable name="gmlDocuments" select="collection('.?select=*.gml')"/>
    <xsl:variable name="SOORT_REGELING"
        select="$xmlDocuments//stop:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>

    <xsl:variable name="AMvB" select="'/join/id/stop/regelingtype_001'"/>
    <xsl:variable name="MR" select="'/join/id/stop/regelingtype_002'"/>
    <xsl:variable name="OP" select="'/join/id/stop/regelingtype_003'"/>
    <xsl:variable name="OV" select="'/join/id/stop/regelingtype_004'"/>
    <xsl:variable name="WV" select="'/join/id/stop/regelingtype_005'"/>
    <xsl:variable name="OVI_PB" select="''"/>

    <!-- ============================================================================================================================ -->

    <sch:pattern id="TPOD880">
        <sch:rule context="//tekst:Hoofdstuk/tekst:Kop[string(tekst:Nummer) = '1']">
            <xsl:variable name="APPLICABLE"
                select="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <xsl:variable name="CONDITION"
                select="(lower-case(tekst:Label/text()) = 'hoofdstuk') and (lower-case(tekst:Opschrift/text()) = 'algemene bepaling')"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> H:TPOD880: Een
                OW-besluit moet minimaal één hoofdstuk 1 bevatten met het opschrift Algemene
                bepalingen."/> </sch:assert>
        </sch:rule>
        <sch:rule context="//tekst:Lichaam">
            <xsl:variable name="APPLICABLE"
                select="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <xsl:variable name="nummer1">
                <xsl:choose>
                    <xsl:when test="tekst:Hoofdstuk/tekst:Kop">
                        <xsl:value-of select="0"/>
                        <xsl:for-each select="tekst:Hoofdstuk/tekst:Kop">
                            <xsl:if test="string(tekst:Nummer) = '1'">
                                <xsl:value-of select="tekst:Nummer"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="-1"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="CONDITION" select="$nummer1=1 or $nummer1=-1"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> H:TPOD880: Een
                OW-besluit moet minimaal één hoofdstuk 1 bevatten met het opschrift Algemene
                bepalingen.."/> </sch:assert>
        </sch:rule>
    </sch:pattern>


</sch:schema>
