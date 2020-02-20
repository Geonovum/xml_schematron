<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
    xmlns:r="http://www.geostandaarden.nl/imow/regels/v20190901"
    xmlns:ow-dc="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:ow="http://www.geostandaarden.nl/imow/owobject/v20190709"
    xmlns:rol="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901"
    xmlns:rol-ref="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="http://whatever"
    xmlns:ga="http://www.geostandaarden.nl/imow/gebiedsaanwijzing/v20190709"
    xmlns:l="http://www.geostandaarden.nl/imow/locatie/v20190901"
    xmlns:r-ref="http://www.geostandaarden.nl/imow/regels-ref/v20190901"
    xmlns:g-ref="http://www.geostandaarden.nl/imow/geometrie-ref/v20190901"
    xmlns:l-ref="http://www.geostandaarden.nl/imow/locatie-ref/v20190901"
    xmlns:lvbb="http://www.overheid.nl/2017/lvbb"
    xmlns:geo="http://www.geostandaarden.nl/basisgeometrie/v20190901"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:gml="http://www.opengis.net/gml/3.2">

    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="ow"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901" prefix="rol"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709" prefix="rol-ref"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing/v20190709" prefix="ga"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/locatie/v20190901" prefix="l"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels-ref/v20190901" prefix="r-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/geometrie-ref/v20190901" prefix="g-ref"/>
    <sch:ns uri="http://www.overheid.nl/2017/lvbb" prefix="lvbb"/>
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>

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


    <!-- TPOD1760 -->
    <sch:pattern id="TPOD1760">
        <sch:rule
            context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/ga:Gebiedsaanwijzing">
            <xsl:variable name="APPLICABLE"
                select="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <xsl:variable name="CONDITION" select="foo:isGebiedaanwijzingvanTypegebied(., $gmlDocuments/geo:FeatureCollectionGeometrie/geo:featureMember)[1] = ''"/>
            <xsl:variable name="ASSERT" select="($APPLICABLE and $CONDITION) or not($APPLICABLE)"/>
            <sch:assert
                test="$ASSERT"
                > H:TPOD1760: Betreft <sch:value-of select="ga:identificatie"/>: Een
                gebiedsaanwijzing moet een gebied of gebiedengroep zijn (en mag geen punt,
                puntengroep, lijn of lijnengroep zijn). </sch:assert>
        </sch:rule>
    </sch:pattern>

    <xsl:function name="foo:isGebiedaanwijzingvanTypegebied">
        <xsl:param name="context" as="node()"/>
        <xsl:param name="featureMembers" as="node()*"/>
        <xsl:for-each select="$context/ga:locatieaanduiding/l-ref:LocatieRef">
            <xsl:choose>
                <xsl:when test="contains(@xlink:href, 'gebiedengroep')">
                    <xsl:variable name="gebiedengroepen"
                        select="$xmlDocuments//ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/l:Gebiedengroep"/>
                    <xsl:message>
                        <xsl:value-of select="$gebiedengroepen"/>
                    </xsl:message>
                    <xsl:for-each select="$gebiedengroepen">
                        <xsl:message>
                            <xsl:value-of select="position()"/>
                        </xsl:message>
                        <xsl:message>
                            <xsl:value-of select="current()"/>
                        </xsl:message>
                        <xsl:if
                            test="current()/l:identificatie = $context/ga:locatieaanduiding/l-ref:LocatieRef/@xlink:href">
                            <xsl:for-each select="current()/l:groepselement/l-ref:GebiedRef">
                                <xsl:value-of
                                    select="foo:isGebiedvanTypegebied(@xlink:href, $featureMembers)"
                                />
                            </xsl:for-each>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="foo:isGebiedvanTypegebied($context/ga:locatieaanduiding/l-ref:LocatieRef/@xlink:href, $featureMembers)"
                    />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>

    <xsl:function name="foo:isGebiedvanTypegebied">
        <xsl:param name="id" as="xs:string"/>
        <xsl:param name="featureMembers" as="node()*"/>
        <xsl:variable name="gebieden"
            select="$xmlDocuments/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/l:Gebied"/>
        <xsl:for-each select="$gebieden">
            <xsl:if test="current()/l:identificatie = $id">
                <xsl:value-of
                    select="foo:isGeometrievanTypegebied(current()/l:geometrie/g-ref:GeometrieRef/@xlink:href, $featureMembers)"
                />
            </xsl:if>
        </xsl:for-each>
    </xsl:function>

    <xsl:function name="foo:isGeometrievanTypegebied">
        <xsl:param name="geoId" as="xs:string"/>
        <xsl:param name="featureMembers" as="node()*"/>
        <xsl:variable name="result">
            <xsl:for-each select="$featureMembers/geo:featureMember/geo:Geometrie">
                <xsl:if test="geo:id eq $geoId">
                    <xsl:if test="not(geo:geometrie/gml:MultiSurface)">
                        <xsl:value-of select="$geoId"/>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$result"/>
    </xsl:function>


</sch:schema>
