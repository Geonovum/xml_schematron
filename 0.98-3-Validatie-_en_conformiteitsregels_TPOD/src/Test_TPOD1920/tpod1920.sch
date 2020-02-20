<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301" prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>

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
    
    <sch:pattern id="TPOD1920">
        <sch:rule context="/Modules/RegelingVersie/Bestand">
            <xsl:variable name="APPLICABLE" select="true()"/>
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
            <xsl:variable name="CONDITION" select="string-length($notfoundFileOrObjectType)=0"/>
            <xsl:variable name="ASSERT" select="($APPLICABLE and $CONDITION) or not($APPLICABLE)"/>
            <sch:assert
                test="$ASSERT"
                > H:TPOD1920: De objecttypen in manifest-ow dienen overeen te komen met de objecttypen in het betreffende Ow-bestand.
                De objecttypen waarom het gaat staan nu genoemd: <sch:value-of select="$notfoundFileOrObjectType"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>


</sch:schema>
