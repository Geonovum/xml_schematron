<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0"
    xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
    xmlns:r="http://www.geostandaarden.nl/imow/regels/v20190901"
    xmlns:owo="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:ow="http://www.geostandaarden.nl/imow/owobject/v20190709"
    xmlns:rol="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901"
    xmlns:rol-ref="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709"
    xmlns:lvbb="http://www.overheid.nl/2017/lvbb"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/" xmlns:foo="http://whatever">

    <xsl:output encoding="UTF-8"/>

    <xsl:template match="/">
        <xsl:variable name="GML">
            <geo:FeatureCollectionGeometrie xmlns:gml="http://www.opengis.net/gml/3.2"
                xmlns:geo="http://www.geostandaarden.nl/basisgeometrie/v20190901"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="https://standaarden.overheid.nl/stop/imop/geo/ https://raw.githubusercontent.com/Geonovum/xml_op_xsd_0.98.3-kern/master/stop/Basisgeometrie.xsd"
                gml:id="main" schemaversie="0.98.3-kern">
                <xsl:variable name="xmlDocumenten"
                    select="document('../manifest.xml')//lvbb:manifest/lvbb:bestand/lvbb:bestandsnaam"/>
                <xsl:for-each select="$xmlDocumenten">
                    <xsl:variable name="filename" select="."/>
                    <xsl:if test="document($filename)//geo:FeatureCollectionGeometrie">
                        <xsl:for-each
                            select="document($filename)//geo:FeatureCollectionGeometrie/geo:featureMember">
                            <xsl:element name="geo:featureMember">
                                <xsl:element name="geo:Geometrie">
                                    <xsl:copy-of select="*//geo:id"/>
                                    <xsl:element name="geo:geometrie">
                                        <xsl:for-each select="*//geo:geometrie/*">
                                            <xsl:for-each select="descendant::gml:posList">
                                                <xsl:variable name="geometries"
                                                  select="ancestor::*/@srsName"/>
                                                <xsl:variable name="ids"
                                                  select="ancestor::*/@gml:id" as="xs:string*"/>
                                                <xsl:variable name="geometrie"
                                                  select="tokenize($geometries[1], ':')[last()]"/>
                                                <xsl:element name="posListArray">
                                                  <xsl:attribute name="geometrie"
                                                  select="$geometrie"/>
                                                  <xsl:attribute name="id" select="$ids[last()]"/>
                                                  <xsl:attribute name="bestand" select="$filename"/>
                                                  <xsl:variable name="coordinaten"
                                                  select="tokenize(normalize-space(text()), ' ')"
                                                  as="xs:string*"/>
                                                  <xsl:for-each select="$coordinaten">
                                                  <xsl:element name="pos">
                                                  <xsl:value-of select="."/>
                                                  </xsl:element>
                                                  </xsl:for-each>
                                                </xsl:element>
                                            </xsl:for-each>
                                            <xsl:copy-of select="."/>
                                        </xsl:for-each>
                                    </xsl:element>
                                </xsl:element>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </geo:FeatureCollectionGeometrie>
        </xsl:variable>
        <xsl:result-document href="../GMLTotaal.xml">
            <xsl:copy-of select="$GML"/>
        </xsl:result-document>
        <xsl:variable name="GIO">
            <AanleveringGIO xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:gml="http://www.opengis.net/gml/3.2"
                xmlns="https://standaarden.overheid.nl/lvbb/stop/"
                xsi:schemaLocation="https://standaarden.overheid.nl/lvbb/stop/ https://raw.githubusercontent.com/Geonovum/xml_op_xsd_0.98.3-kern/master/lvbb/LVBB-stop.xsd"
                schemaversie="0.98.3-kern">
                <xsl:variable name="xmlDocumenten"
                    select="document('../manifest.xml')//lvbb:manifest/lvbb:bestand/lvbb:bestandsnaam"/>
                <xsl:for-each select="$xmlDocumenten">
                    <xsl:variable name="filename" select="."/>
                    <xsl:if test="document($filename)//stop:AanleveringGIO">
                        <xsl:copy-of
                            select="document($filename)//stop:AanleveringGIO/stop:InformatieObjectVersie"
                        />
                    </xsl:if>
                </xsl:for-each>
            </AanleveringGIO>
        </xsl:variable>
        <xsl:result-document href="../GIOTotaal.xml">
            <xsl:copy-of select="$GIO"/>
        </xsl:result-document>
        <xsl:variable name="owBestand">
            <owBestand xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
                xmlns:rol="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901"
                xmlns:l-ref="http://www.geostandaarden.nl/imow/locatie-ref/v20190901"
                xmlns:rol-ref="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709"
                xmlns:ow="http://www.geostandaarden.nl/imow/owobject/v20190709"
                xmlns:owo="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
                xmlns:ga-ref="http://www.geostandaarden.nl/imow/gebiedsaanwijzing-ref/v20190709"
                xmlns:rkow="http://www.geostandaarden.nl/imow/regeltekstkoppelingow/v20190709"
                xmlns:r="http://www.geostandaarden.nl/imow/regels/v20190901"
                xmlns:r-ref="http://www.geostandaarden.nl/imow/regels-ref/v20190901"
                xmlns:p="http://www.geostandaarden.nl/imow/pons/v20190901"
                xmlns="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
                xsi:schemaLocation="http://www.geostandaarden.nl/imow/0.98.1 https://raw.githubusercontent.com/Geonovum/xml_ow_xsd_0.98.1-kern/master/xsd/bestanden-ow/deelbestand-ow/v20190901/IMOW_Deelbestand_v0_9_8_2.xsd">
                <xsl:element name="sl:standBestand">
                    <xsl:variable name="documents"
                        select="document('../manifest-ow.xml')//Modules/RegelingVersie/Bestand/naam"/>
                    <xsl:element name="sl:dataset">
                        <xsl:value-of select="document($documents[1])//sl:standBestand/sl:dataset"/>
                    </xsl:element>
                    <xsl:element name="sl:inhoud">
                        <xsl:element name="sl:gebied">
                            <xsl:value-of
                                select="document($documents[1])//sl:standBestand/sl:inhoud/sl:gebied"
                            />
                        </xsl:element>
                        <xsl:element name="sl:leveringsId">
                            <xsl:value-of
                                select="document($documents[1])//sl:standBestand/sl:inhoud/sl:leveringsId"
                            />
                        </xsl:element>
                        <xsl:element name="sl:objectTypen">
                            <xsl:for-each select="$documents">
                                <xsl:variable name="filename" select="."/>
                                <xsl:variable name="objectTypes"
                                    select="document($filename)//sl:standBestand/sl:inhoud/sl:objectTypen/sl:objectType"/>
                                <xsl:for-each select="distinct-values($objectTypes)">
                                    <xsl:element name="sl:objectType">
                                        <xsl:value-of select="."/>
                                    </xsl:element>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:element>
<!--                    <xsl:variable name="activiteitenLijst">
                        <xsl:for-each select="$documents">
                            <xsl:variable name="filename" select="."/>
                            <xsl:for-each
                                select="document($filename)//sl:standBestand/sl:stand/owo:owObject/rol:Activiteit">
                                <xsl:element name="activiteit">
                                    <xsl:value-of select="rol:identificatie"/>
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:element name="activiteitenLijst">
                        <xsl:for-each select="$documents">
                            <xsl:variable name="filename" select="."/>
                            <xsl:for-each
                                select="document($filename)//sl:standBestand/sl:stand/owo:owObject/rol:Activiteit">
                                <xsl:variable name="bovenLiggend"
                                    select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                                <xsl:variable name="identificatie" select="rol:identificatie"/>
                                <xsl:if test="contains($activiteitenLijst, $bovenLiggend)">
                                    <xsl:element name="activiteit">
                                        <xsl:attribute name="bovenLiggend" select="$bovenLiggend"/>
                                        <xsl:attribute name="id" select="$identificatie"/>
                                        <xsl:variable name="i1" select="$identificatie"/>
                                        <xsl:for-each
                                            select="document($filename)//sl:standBestand/sl:stand/owo:owObject/rol:Activiteit">
                                            <xsl:if
                                                test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $i1">
                                                <xsl:variable name="i2" select="rol:identificatie"/>
                                                <xsl:choose>
                                                    <xsl:when test="$identificatie = $i2">
                                                        <xsl:element name="ERROR"><xsl:value-of select="$i2"/></xsl:element>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:element name="onderLiggend">
                                                            <xsl:value-of select="$i2"/>
                                                        </xsl:element>
                                                        <xsl:for-each
                                                            select="document($filename)//sl:standBestand/sl:stand/owo:owObject/rol:Activiteit">
                                                            <xsl:if
                                                                test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $i2">
                                                                <xsl:variable name="i3" select="rol:identificatie"/>
                                                                <xsl:choose>
                                                                    <xsl:when test="$identificatie = $i3">
                                                                        <xsl:element name="ERROR">
                                                                            <xsl:value-of select="$i3"/>
                                                                        </xsl:element>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:element name="onderLiggend">
                                                                            <xsl:value-of select="$i3"/>
                                                                        </xsl:element>
                                                                        <xsl:for-each
                                                                            select="document($filename)//sl:standBestand/sl:stand/owo:owObject/rol:Activiteit">
                                                                            <xsl:if
                                                                                test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $i3">
                                                                                <xsl:variable name="i4" select="rol:identificatie"/>
                                                                                <xsl:choose>
                                                                                    <xsl:when test="$identificatie = $i4">
                                                                                        <xsl:element name="ERROR">
                                                                                            <xsl:value-of select="$i4"/>
                                                                                        </xsl:element>
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
                                                                                        <xsl:element name="onderLiggend">
                                                                                            <xsl:value-of select="$i4"/>
                                                                                        </xsl:element>
                                                                                    </xsl:otherwise>
                                                                                </xsl:choose>
                                                                            </xsl:if>
                                                                        </xsl:for-each>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </xsl:element>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:element>
-->                    <xsl:for-each select="$documents">
                        <xsl:variable name="filename" select="."/>
                        <xsl:for-each select="document($filename)//sl:standBestand/sl:stand">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:element>
            </owBestand>
        </xsl:variable>
        <xsl:result-document href="../OwTotaal.xml">
            <xsl:copy-of select="$owBestand"/>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>
