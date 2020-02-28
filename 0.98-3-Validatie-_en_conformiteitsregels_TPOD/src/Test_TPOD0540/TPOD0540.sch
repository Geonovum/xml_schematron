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
    <sch:let name="SOORT_REGELING" value="$xmlDocuments//stop:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>
    
    <sch:let name="AMvB" value="'/join/id/stop/regelingtype_001'"/>
    <sch:let name="MR" value="'/join/id/stop/regelingtype_002'"/>
    <sch:let name="OP" value="'/join/id/stop/regelingtype_003'"/>
    <sch:let name="OV" value="'/join/id/stop/regelingtype_004'"/>
    <sch:let name="WV" value="'/join/id/stop/regelingtype_005'"/>
    <sch:let name="OVI_PB" value="''"/>
    <!-- ============================================================================================================================ -->

    <sch:pattern id="TDOP_0540">
        <sch:rule context="//tekst:Lichaam/tekst:Hoofdstuk">
            <xsl:variable name="APPLICABLE"
                select="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <xsl:variable name="hoofdstuk" select="string(tekst:Kop/tekst:Nummer)"/>
            <xsl:variable name="fouten">
                <xsl:for-each select="tekst:Afdeling">
                    <xsl:if test="ends-with(tekst:Kop/tekst:Nummer, '.')">
                        <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="tekst:Titel">
                    <xsl:variable name="titel" select="string(tekst:Kop/tekst:Nummer)"/>
                    <xsl:for-each select="tekst:Afdeling">
                        <xsl:if test="ends-with(tekst:Kop/tekst:Nummer, '.')">
                            <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="CONDITION" select="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TDOP_0540: Achter het cijfer van een afdelingnummer mag geen punt worden opgenomen. (betreft hoofdstukken, afdeling):  <xsl:value-of select="$hoofdstuk"/>: <xsl:value-of select="substring($fouten,1,string-length($fouten)-2)"/></sch:assert>
        </sch:rule>
    </sch:pattern>

</sch:schema>
