<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301" prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
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
    
    <sch:pattern id="TPOD1920">
        <sch:rule context="/Modules/RegelingVersie/Bestand">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="naam" value="naam"/>
            <sch:let name="notfoundFileOrObjectType">
                <xsl:for-each select="objecttype">
                    <sch:let name="objecttype" value="text()"/>
                    <xsl:choose>
                        <xsl:when test=".='Geometrie'">
                            <xsl:if test="not(document($naam)//geo:FeatureCollectionGeometrie)">
                                <xsl:value-of select="concat($naam, ': ', ., ', ')"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <sch:if test="not(document($naam)//ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen[sl:objectType=$objecttype])">
                                <xsl:value-of select="concat($naam, ': ', ., ', ')"/>
                            </sch:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </sch:let>
            <sch:let name="CONDITION" value="string-length($notfoundFileOrObjectType)=0"/>
            <sch:assert
                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"
                > H:TPOD1920: De objecttypen in manifest-ow dienen overeen te komen met de objecttypen in het betreffende Ow-bestand.
                De objecttypen waarom het gaat staan nu genoemd: <sch:value-of select="$notfoundFileOrObjectType"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>


</sch:schema>
