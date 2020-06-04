<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">


    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="ow"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels-ref/v20190901" prefix="r-ref"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/locatie/v20190901" prefix="l"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/locatie-ref/v20190901" prefix="l-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901" prefix="rol"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709" prefix="rol-ref"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing/v20190709" prefix="ga"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing-ref/v20190709" prefix="ga-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/geometrie-ref/v20190901" prefix="g-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/vrijetekst/v20190901" prefix="vt"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/vrijetekst-ref/v20190901" prefix="vt-ref"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/tekst/" prefix="tekst"/>
    <sch:ns uri="http://www.overheid.nl/2017/lvbb" prefix="lvbb"/>

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

    <!-- ============================================================================================================================ -->

    <sch:pattern id="TPOD_2070">
        <sch:rule context="//rol:Activiteit">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="fouten" value="foo:regeltekstIdVanActiviteitNaarObjectTPOD_2070(.)"/>
            <sch:let name="CONDITION" value="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> TPOD2070:
                    <sch:value-of select="$fouten"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>


    <xsl:function name="foo:regeltekstIdVanActiviteitNaarObjectTPOD_2070">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="regelId" select="$context/@ow:regeltekstId"/>
        <xsl:if test="$context/@ow:regeltekstId">
            <xsl:variable name="collection">
                <xsl:for-each
                    select="$xmlDocuments//(r:RegelVoorIedereen | rol:Activiteit | l:Gebiedengroep | l:Puntengroep | l:Lijnengroep | l:Gebied | l:Punt | l:Lijn)">
                    <xsl:copy-of select="."/>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="node_list" select="$collection/element()"/>
            <xsl:variable name="actId" select="$context/rol:identificatie/text()"/>
            <xsl:variable name="messages"
                select="foo:recursieveVanActiviteitNaarObjectTPOD_2070($node_list, $actId, $regelId, $context)"/>
            <xsl:value-of select="$messages"/>
        </xsl:if>
    </xsl:function>

    <xsl:function name="foo:recursieveVanActiviteitNaarObjectTPOD_2070">
        <xsl:param name="node_list" as="node()*"/>
        <xsl:param name="actId"/>
        <xsl:param name="regelId"/>
        <xsl:param name="context"/>
        <xsl:variable name="fouteVerwijzingen">
            <!-- zoek naar voor  RegelVoorIedereen van waar vanuit activiteit naar wordt verwezen en vergelijk de terugverwijzing -->
            <xsl:for-each select="$context//@ow:regeltekstId">
                <!-- vind de juridische regels van waaruit van activiteit (regeltekstId) naar wordt verwezen: die heet dan remoteNode  -->
                <xsl:variable name="remoteRegelsVoorIedereen"
                    select="$node_list[self::*[string(./r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href) = string($regelId)]]"/>
                <xsl:choose>
                    <!-- Als gevonden? -->
                    <xsl:when test="$remoteRegelsVoorIedereen">
                        <xsl:variable name="remoteRegelId"
                            select="$remoteRegelsVoorIedereen/@ow:regeltekstId"/>
                        <xsl:if
                            test="not($remoteRegelsVoorIedereen[@ow:regeltekstId = string($regelId)]//rol-ref:ActiviteitRef[@xlink:href = $actId])">
                            <xsl:value-of
                                select="
                                    concat('Vanuit Activiteit: ',
                                    $actId,
                                    ' wordt verwezen naar RegelVoorIedereen via RegeltekstId: ',
                                    string($regelId),
                                    ', echter heeft deze geen terug-verwijzing naar deze Activiteit. ')"
                            />
                        </xsl:if>
                    </xsl:when>
                    <!-- Anders niet gevonden -->
                    <xsl:otherwise>
                        <xsl:value-of
                            select="
                                concat('Vanuit Activiteit: ',
                                $actId,
                                ' wordt verwezen naar RegelVoorIedereen: ',
                                string($regelId),
                                ', deze is niet aangetroffen. ')"
                        />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$fouteVerwijzingen"/>
    </xsl:function>
</sch:schema>
