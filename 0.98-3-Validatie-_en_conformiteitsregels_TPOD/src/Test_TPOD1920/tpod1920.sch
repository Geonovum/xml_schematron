<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301" prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>

    <xsl:variable name="xmlDocuments" select="collection('.?select=*.xml')"/>
    <xsl:variable name="gmlDocuments" select="collection('.?select=*.gml')"/>

    <sch:pattern id="TPOD1920">
        <sch:rule context="/Modules/RegelingVersie/Bestand">
            <xsl:variable name="naam" select="naam"/>
            <xsl:variable name="notfoundFileOrObjectType">
                <xsl:for-each select="objecttype">
                    <xsl:variable name="objecttype" select="text()"/>
<!--                    <xsl:message select="$naam"/>
                    <xsl:message select="$objecttype"/>
                    <xsl:message select="document($naam)//ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen[sl:objectType=$objecttype]"/>
-->                    <xsl:choose>
                        <xsl:when test=".='Geometrie'">
                            <xsl:if test="not(document($naam)//geo:FeatureCollectionGeometrie)">
                                <xsl:value-of select="concat($naam, ': ', ., ', ')"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:if test="not(document($naam)//ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen[sl:objectType=$objecttype])">
                                <xsl:value-of select="concat($naam, ': ', ., ', ')"/>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:variable>
            <sch:assert
                test="string-length($notfoundFileOrObjectType)=0"
                > H:TPOD1920: De objecttypen in manifest-ow dienen overeen te komen met de objecttypen in het betreffende Ow-bestand.
                De objecttypen waarom het gaat staan nu genoemd: <sch:value-of select="$notfoundFileOrObjectType"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>


</sch:schema>