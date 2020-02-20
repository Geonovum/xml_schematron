<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lvbb="http://www.overheid.nl/2017/lvbb"
    xmlns:geo="http://www.geostandaarden.nl/basisgeometrie/v20190901"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:foo="http://whatever"
    >
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="owo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="ow"/>
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="http://xml.juniper.net/junos/commit-scripts/1.0" prefix="jcs"/>
    
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
    
    <xsl:function name="foo:posListForCoordinateCheck">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context">
            <xsl:for-each select="descendant::gml:posList">
                <xsl:variable name="coordinaten" select="tokenize(normalize-space(text()), ' ')"
                    as="xs:string*"/>
                <xsl:for-each select="$coordinaten">
                    <xsl:element name="pos">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:function>

    <sch:pattern id="TPOD930">
        <sch:rule context="//geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie[tokenize(geo:geometrie/*/@srsName, ':')[last()] eq '28992']">
            <xsl:variable name="APPLICABLE" select="true()"/>
            <xsl:variable name="fouteCoord">
                    <xsl:for-each select="foo:posListForCoordinateCheck(.)">
                        <xsl:if test="string-length(substring-after(string(.), '.')) &gt; 3">
                            <xsl:value-of select="concat(text(), ', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>
            <xsl:variable name="CONDITION" select="string-length($fouteCoord) = 0"/>
            <xsl:variable name="ASSERT" select="($APPLICABLE and $CONDITION) or not($APPLICABLE)"/>
            <sch:assert test="$ASSERT"> ZH:TP0D930: Indien gebruik wordt
                    gemaakt van EPSG:28992 (=RD new) dan moeten coördinaten in eenheden van meters
                    worden opgegeven waarbij de waarde maximaal 3 decimalen achter de komma mag
                    bevatten. Id=<sch:value-of select="geo:id"/>. De coordinaten waarom het gaat
                    staan nu genoemd: <sch:value-of select="$fouteCoord"/></sch:assert>
        </sch:rule>
        <sch:rule
            context="//geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie[tokenize(geo:geometrie/*/@srsName, ':')[last()] eq '4258']">
            <xsl:variable name="fouteCoord">
                <xsl:for-each select="foo:posListForCoordinateCheck(.)">
                    <xsl:if test="string-length(substring-after(string(.), '.')) &gt; 8">
                        <xsl:value-of select="concat(text(), ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="CONDITION" select=""/>
            <xsl:variable name="ASSERT" select="($APPLICABLE and $CONDITION) or not($APPLICABLE)"/>
            <sch:assert test="string-length($fouteCoord) = 0"> ZH:TP0D930: Indien gebruik wordt
                gemaakt van EPSG:4258 (=ETRS89) dan moeten coördinaten in eenheden van meters worden
                opgegeven waarbij de waarde maximaal 8 decimalen achter de komma mag bevatten.
                    Id=<sch:value-of select="geo:id"/>. De coordinaten waarom het gaat staan nu
                genoemd: <sch:value-of select="$fouteCoord"/></sch:assert>
        </sch:rule>
    </sch:pattern>

</sch:schema>
