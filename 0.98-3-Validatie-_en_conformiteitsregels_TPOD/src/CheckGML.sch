<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
    xmlns:r="http://www.geostandaarden.nl/imow/regels/v20190901"
    xmlns:owo="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:ow="http://www.geostandaarden.nl/imow/owobject/v20190709"
    xmlns:geo="http://www.geostandaarden.nl/basisgeometrie/v20190901"
    xmlns:gml="http://www.opengis.net/gml/3.2"
    xmlns:jcs="http://xml.juniper.net/junos/commit-scripts/1.0"
    xmlns:foo="http://whatever"
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

    <xsl:variable name="posListForCoordinateCheck">
        <xsl:for-each select="/geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie">
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
    </xsl:variable>
    
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

    <sch:pattern id="TPOD930_TPOD940">
        <sch:rule context="/geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie[tokenize(geo:geometrie/*/@srsName, ':')[last()] eq '28992']">
            <xsl:variable name="fouteCoord">
                <xsl:for-each select="foo:posListForCoordinateCheck(.)">
                    <xsl:if test="string-length(substring-after(string(.), '.')) &gt; 3">
                        <xsl:value-of select="concat(text(), ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <sch:assert test="string-length($fouteCoord) = 0"> ZH:TP0D930: Indien gebruik wordt gemaakt
                van EPSG:28992 (=RD new) dan moeten coördinaten in eenheden van meters worden
                opgegeven waarbij de waarde maximaal 3 decimalen achter de komma mag
                bevatten.  Id=<sch:value-of select="geo:id"/>. De coordinaten waarom het gaat staan nu genoemd: <sch:value-of select="$fouteCoord"/></sch:assert>
        </sch:rule>
        <sch:rule context="/geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie[tokenize(geo:geometrie/*/@srsName, ':')[last()] eq '4258']">
            <xsl:variable name="fouteCoord">
                <xsl:for-each select="foo:posListForCoordinateCheck(.)">
                    <xsl:if test="string-length(substring-after(string(.), '.')) &gt; 8">
                        <xsl:value-of select="concat(text(), ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <sch:assert test="string-length($fouteCoord) = 0"> ZH:TP0D930: Indien gebruik wordt gemaakt
                van EPSG:4258 (=ETRS89) dan moeten coördinaten in eenheden van meters worden
                opgegeven waarbij de waarde maximaal 8 decimalen achter de komma mag
                bevatten.  Id=<sch:value-of select="geo:id"/>. De coordinaten waarom het gaat staan nu genoemd: <sch:value-of select="$fouteCoord"/></sch:assert>
        </sch:rule>
        <sch:rule
            context="/geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie/geo:geometrie">
            <xsl:variable name="crs">
                <xsl:for-each select="descendant-or-self::*/@srsName">
                    <xsl:if test="position()=1">
                        <xsl:value-of select="."/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="crsses">
                <xsl:for-each select="descendant-or-self::*/@srsName">
                    <xsl:if test="not($crs=.)">
                        <xsl:value-of select="concat(., ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <sch:assert test="string-length($crsses) = 0">ZH:TP0D940: Een geometrie moet zijn opgebouwd middels één
                coordinate reference system (crs): EPSG:28992 (=RD new) of EPSG:4258
                (=ETRS89). Id=<sch:value-of select="parent::*/geo:id"/>: </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern id="TPOD940">
    </sch:pattern>
</sch:schema>
