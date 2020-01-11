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
    >
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="owo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="ow"/>
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:ns uri="http://xml.juniper.net/junos/commit-scripts/1.0" prefix="jcs"/>

    <sch:pattern id="Controleren_decimalen">
        
        <sch:rule context="/geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie/geo:geometrie">
            <sch:let name="geometrie" value="tokenize(*/@srsName, ':')[last()]"/>
            <xsl:variable name="s" select="*//gml:posList/text()"/>
            <xsl:variable name="coordinaten" select="tokenize(normalize-space($s),' ')" as="xs:string*"/>
            <sch:report test="true()"><sch:value-of select="$coordinaten"/></sch:report>
            <sch:report test="true()"><sch:value-of select="$coordinaten[last()]"/></sch:report>
            <xsl:variable name="offendingCoordinates">
                <xsl:for-each select="$coordinaten">
                    <xsl:variable name="cell" select="current()"/>
                    <sch:report test="true()"><sch:value-of select="$coordinaten[position()]"/></sch:report>
                    <sch:report test="true()"><sch:value-of select="$cell"/></sch:report>
                    <xsl:variable name="cells" select="tokenize($cell,'.')"/>    
<!--                    <xsl:if test="substring($cell, )>7">
                        <xsl:value-of select="concat($cell,' ')"/>
                    </xsl:if>
-->                </xsl:for-each>    
            </xsl:variable>
            <sch:report test="true()"><sch:value-of select="$offendingCoordinates"/></sch:report>
            
        </sch:rule>
    </sch:pattern>
</sch:schema>
