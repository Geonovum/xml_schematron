<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lvbb="http://www.overheid.nl/2017/lvbb"
    xmlns:geo="http://www.geostandaarden.nl/basisgeometrie/v20190901"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:foo="http://whatever">
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="owo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="ow"/>
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="http://xml.juniper.net/junos/commit-scripts/1.0" prefix="jcs"/>
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
    
    <sch:pattern id="TPOD_0940">
        <sch:rule
            context="/geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie/geo:geometrie">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="crs" value="foo:crsTPOD_0940(.)"/>
            <sch:let name="crsses" value="foo:crssesTPOD_0940($crs, .)"/>
            <sch:let name="CONDITION" value="string-length($crsses) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                H:TP0D940: Een geometrie moet zijn opgebouwd middels één coordinate reference system (crs): 
                EPSG:28992 (=RD new) of EPSG:4258 (=ETRS89). Id=<sch:value-of select="parent::*/geo:id"/> bevat een combinatie van beiden. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:crsTPOD_0940">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="crs">
            <xsl:for-each select="$context/descendant-or-self::*/@srsName">
                <xsl:if test="position() = 1">
                    <xsl:value-of select="."/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$crs"/>
    </xsl:function>
    
    <xsl:function name="foo:crssesTPOD_0940">
        <xsl:param name="crs"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="crsses">
            <xsl:for-each select="$context/descendant-or-self::*/@srsName">
                <xsl:if test="not($crs = .)">
                    <xsl:value-of select="concat(., ', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$crsses"/>
    </xsl:function>

</sch:schema>
