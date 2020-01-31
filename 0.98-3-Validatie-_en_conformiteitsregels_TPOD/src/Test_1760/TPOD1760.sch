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

    <xsl:function name="foo:manifest">
        <xsl:variable name="manifestBestand">
            <xsl:for-each select="collection('.')">
                <xsl:if test="lvbb:manifest">
                    <manifest copy-namespaces="no" xmlns="">
                        <xsl:for-each select="//lvbb:manifest/lvbb:bestand">
                            <bestand copy-namespaces="no" xmlns="">
                                <xsl:element name="bestandsNaam">
                                    <xsl:value-of select="lvbb:bestandsnaam"/>
                                </xsl:element>
                                <xsl:element name="contentType">
                                    <xsl:value-of select="lvbb:contentType"/>
                                </xsl:element>
                            </bestand>
                        </xsl:for-each>
                    </manifest>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$manifestBestand"/>
    </xsl:function>

    <xsl:function name="foo:substring-before-last">
        <xsl:param name="input"/>
        <xsl:param name="substr"/>
        <xsl:if test="$substr and contains($input, $substr)">
            <xsl:variable name="temp" select="substring-after($input, $substr)"/>
            <xsl:value-of select="substring-before($input, $substr)"/>
            <xsl:if test="contains($temp, $substr)">
                <xsl:value-of select="$substr"/>
                <xsl:value-of select="foo:substring-before-last($temp, $substr)"> </xsl:value-of>
            </xsl:if>
        </xsl:if>
    </xsl:function>

    <xsl:function name="foo:substring-after-last">
        <xsl:param name="input"/>
        <xsl:param name="substr"/>

        <!-- Extract the string which comes after the first occurence -->
        <xsl:variable name="temp" select="substring-after($input, $substr)"/>

        <xsl:choose>
            <!-- If it still contains the search string the recursively process -->
            <xsl:when test="$substr and contains($temp, $substr)">
                <xsl:value-of select="foo:substring-after-last($temp, $substr)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$temp"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:variable name="base-uri" select="foo:substring-before-last(base-uri(.), '/')"/>

    <xsl:function name="foo:manifest-ow">
        <xsl:message>
            <xsl:value-of select="$base-uri"/>
        </xsl:message>
        <xsl:variable name="manifest-ow">
            <xsl:for-each select="collection('.')">
                <xsl:if test="Modules">
                    <manifest-ow copy-namespaces="no" xmlns="">
                        <xsl:for-each select="//Modules/RegelingVersie/Bestand">
                            <Bestand copy-namespaces="no" xmlns="">
                                <xsl:element name="naam">
                                    <xsl:value-of
                                        select="concat(string-join($base-uri), string('/'), string(naam))"/>
                                </xsl:element>
                                <xsl:for-each select="objecttype">
                                    <xsl:element name="objecttype">
                                        <xsl:value-of select="."/>
                                    </xsl:element>
                                </xsl:for-each>
                            </Bestand>
                        </xsl:for-each>
                    </manifest-ow>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$manifest-ow"/>
    </xsl:function>

    <xsl:function name="foo:featureMembers">
        <xsl:variable name="featureMembers">
            <xsl:for-each select="foo:manifest()/manifest/bestand">
                <xsl:if test="contains(contentType, 'gml+xml')">
                    <xsl:if test="document(bestandsNaam)//geo:FeatureCollectionGeometrie">
                        <xsl:for-each
                            select="document(bestandsNaam)//geo:FeatureCollectionGeometrie/geo:featureMember">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$featureMembers"/>
    </xsl:function>

    <xsl:function name="foo:gebieden">
        <xsl:variable name="gebieden">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Gebied'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/l:Gebied">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$gebieden"/>
    </xsl:function>

    <xsl:variable name="regelTeksten">
        <xsl:variable name="documents"
            select="document('manifest-ow.xml')//Modules/RegelingVersie/Bestand/naam"/>
        <xsl:for-each select="$documents">
            <xsl:for-each select="document(.)//sl:standBestand/sl:stand/ow-dc:owObject/r:Regeltekst">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="gebiedenGroepen">
        <xsl:variable name="documents"
            select="document('manifest-ow.xml')//Modules/RegelingVersie/Bestand/naam"/>
        <xsl:for-each select="$documents">
            <xsl:for-each
                select="document(.)//sl:standBestand/sl:stand/ow-dc:owObject/l:Gebiedengroep">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:variable>

    <sch:pattern id="TPOD1760">
        <sch:rule
            context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/ga:Gebiedsaanwijzing">
            <sch:assert
                test="string-length(foo:isGebiedaanwijzingvanTypegebied(., foo:featureMembers())) = 0"
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
                    <xsl:for-each select="$gebiedenGroepen">
                        <xsl:if
                            test="$gebiedenGroepen/l:identificatie = $context/ga:locatieaanduiding/l-ref:LocatieRef/@xlink:href">
                            <xsl:value-of
                                select="foo:isGebiedvanTypegebied(l:groepselement/l-ref:GebiedRef/@xlink:href, $featureMembers)"
                            />
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>
                        <xsl:value-of
                            select="$context/ga:locatieaanduiding/l-ref:LocatieRef/@xlink:href"/>
                    </xsl:message>
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
        <xsl:for-each select="foo:gebieden()">
            <xsl:if test="l:geometrie/g-ref:GeometrieRef/@xlink:href = $id">
                <xsl:value-of select="foo:isGeometrievanTypegebied($id, $featureMembers)"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>

    <xsl:function name="foo:isGeometrievanTypegebied">
        <xsl:param name="geoId" as="xs:string"/>
        <xsl:param name="featureMembers" as="node()*"/>
        <xsl:for-each select="$featureMembers/geo:Geometrie/geo:id">
            <xsl:if test=". eq $geoId">
                <xsl:if test="not(../geo:geometrie/gml:MultiSurface)">
                    <xsl:value-of select="false()"/>
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>


</sch:schema>
