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
    <sch:let name="SOORT_REGELING"
        value="$xmlDocuments//stop:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>

    <sch:let name="AMvB" value="'/join/id/stop/regelingtype_001'"/>
    <sch:let name="MR" value="'/join/id/stop/regelingtype_002'"/>
    <sch:let name="OP" value="'/join/id/stop/regelingtype_003'"/>
    <sch:let name="OV" value="'/join/id/stop/regelingtype_004'"/>
    <sch:let name="WV" value="'/join/id/stop/regelingtype_005'"/>
    <sch:let name="OVI_PB" value="''"/>

    <!-- ============TPOD_0930================================================================================================================ -->

    <sch:pattern id="TPOD_0930">
        <sch:rule
            context="//geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie[tokenize(geo:geometrie/*/@srsName, ':')[last()] eq '28992']">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="fouteCoord" value="foo:fouteCoordTPOD_0930(3,.)"/>
            <sch:let name="CONDITION" value="string-length($fouteCoord) = 0"/>
            <sch:let name="ASSERT" value="($APPLICABLE and $CONDITION) or not($APPLICABLE)"/>
            <sch:assert test="$ASSERT"> 
                ZH:TP0D930: Indien gebruik wordt gemaakt van EPSG:28992 (=RD
                new) dan moeten coördinaten in eenheden van meters worden opgegeven waarbij de
                waarde maximaal 3 decimalen achter de komma mag bevatten. Id=<sch:value-of
                    select="geo:id"/>. De coordinaten waarom het gaat staan nu genoemd:
                <sch:value-of select="concat(substring(substring($fouteCoord,1,string-length($fouteCoord)-2),0, 30),'.....')"/></sch:assert>
        </sch:rule>
        <sch:rule
            context="//geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie[tokenize(geo:geometrie/*/@srsName, ':')[last()] eq '4258']">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="fouteCoord" value="foo:fouteCoordTPOD_0930(8,.)"/>
            <sch:let name="CONDITION" value="string-length($fouteCoord) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> ZH:TP0D930: Indien
                gebruik wordt gemaakt van EPSG:4258 (=ETRS89) dan moeten coördinaten in eenheden van
                meters worden opgegeven waarbij de waarde maximaal 8 decimalen achter de komma mag
                bevatten. Id=<sch:value-of select="geo:id"/>. De coordinaten waarom het gaat staan
                nu genoemd: <sch:value-of select="concat(substring(substring($fouteCoord,1,string-length($fouteCoord)-2),0, 30),'.....')"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:fouteCoordTPOD_0930">
        <xsl:param name="aantal"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="fouteCoord">
            <xsl:for-each select="foo:posListForCoordinateCheckTPOD_0930($context)">
                <xsl:if test="string-length(substring-after(string(.), '.')) &gt; $aantal">
                    <xsl:value-of select="concat(text(), ', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$fouteCoord"/>
    </xsl:function>

    <xsl:function name="foo:posListForCoordinateCheckTPOD_0930">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context">
            <xsl:for-each select="descendant::gml:posList">
                <xsl:variable name="coordinaten" select="tokenize(normalize-space(text()), ' ')" as="xs:string*"/>
                <xsl:for-each select="$coordinaten">
                    <xsl:element name="pos">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:function>
    
</sch:schema>
