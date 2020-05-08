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
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/geo/" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/1.0" prefix="basisgeo"/>
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
        <sch:rule context="//basisgeo:geometrie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="fout" value="foo:aantalTPOD_0930(.)"/>
            <sch:let name="CONDITION" value="string-length($fout) = 0"/>
            <sch:let name="ASSERT" value="($APPLICABLE and $CONDITION) or not($APPLICABLE)"/>
            <sch:assert test="$ASSERT"><sch:value-of select="$fout"/></sch:assert>
        </sch:rule>
    </sch:pattern>

    <xsl:function name="foo:aantalTPOD_0930">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="fout">
            <xsl:for-each select="$context/*">
                <xsl:variable name="srsName" select="string(./@srsName)"/>
                <xsl:choose>
                    <xsl:when test="tokenize(string(./@srsName), ':')[last()] = '28992'">
                        <xsl:variable name="fouteCoord" select="foo:fouteCoordTPOD_0930(., 3)"/>
                        <xsl:value-of
                            select="concat(' TP0D0930: EPSG:28992 (=RD new), coördinaten in meters, maximaal 3 decimalen. gml:id=',./@gml:id,', coördinaten: ',
                            concat(substring(substring($fouteCoord, 1, string-length($fouteCoord) - 2), 0, 50), '.....'))"/>
                    </xsl:when>
                    <xsl:when test="tokenize(string(./@srsName), ':')[last()] = '4258'">
                        <xsl:variable name="fouteCoord" select="foo:fouteCoordTPOD_0930(., 8)"/>
                        <xsl:value-of
                            select="
                            concat(' TP0D0930: EPSG:4258 (=ETRS89) coördinaten graden, maximaal 8 decimalen. gml:id=',./@gml:id,', coördinaten: ',
                            concat(substring(substring($fouteCoord, 1, string-length($fouteCoord) - 2), 0, 50), '.....'))"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$fout"/>
    </xsl:function>

    <xsl:function name="foo:fouteCoordTPOD_0930">
        <xsl:param name="context" as="node()"/>
        <xsl:param name="aantal" as="xs:integer"/>
        <xsl:variable name="fouteCoord">
            <xsl:for-each select="$context/descendant::gml:posList">
                <xsl:variable name="coordinaten" select="tokenize(normalize-space(text()), ' ')"/>
                <xsl:for-each select="$coordinaten">
                    <xsl:if test="string-length(substring-after(., '.')) &gt; $aantal">
                        <xsl:value-of select="concat(., ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$fouteCoord"/>
    </xsl:function>

</sch:schema>
