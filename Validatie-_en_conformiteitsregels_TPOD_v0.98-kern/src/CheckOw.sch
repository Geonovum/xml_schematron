<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
    xmlns:r="http://www.geostandaarden.nl/imow/regels/v20190901"
    xmlns:owo="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:ow="http://www.geostandaarden.nl/imow/owobject/v20190709"
    xmlns:rol="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901"
    xmlns:rol-ref="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709"
    xmlns:xlink="http://www.w3.org/1999/xlink">

    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="owo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="ow"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901" prefix="rol"/>

    <!--    <sch:phase id="critical">
        <sch:active pattern="Regeltekstnummers_behorend_bij_RegeltekstObject"/>
    </sch:phase>
-->
    <!--    <sch:let name="Besluit" value=""/>-->


    <sch:pattern id="Regeltekstnummers_behorend_bij_RegeltekstObject">
        <sch:rule context="/owo:owBestand/sl:standBestand/sl:stand/owo:owObject/*">
            <sch:let name="regeltekstId" value="@ow:regeltekstId"/>
            <sch:let name="itemname" value="./name()"/>
            <xsl:variable name="regeltekstIds">
                <xsl:for-each
                    select="//sl:standBestand/sl:stand/owo:owObject/r:Regeltekst/r:identificatie">
                    <xsl:value-of select="."/>
                </xsl:for-each>
            </xsl:variable>
            <sch:assert test="contains($regeltekstIds, $regeltekstId)"> ZH::OW:T:Regeltekstnummer
                    <sch:value-of select="$regeltekstId"/> in <sch:value-of select="$itemname"/>
                heeft geen bijbehorend regeltekst-object </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern id="bovenliggendeActiviteitCheck">
        <sch:rule context="/owo:owBestand/sl:standBestand">
            <xsl:variable name="activiteitenLijst">
                <xsl:for-each select="sl:stand/owo:owObject/rol:Activiteit">
                    <xsl:value-of select="rol:identificatie"/>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="offendingIds">
                <xsl:for-each select="sl:stand/owo:owObject/rol:Activiteit">
                    <xsl:variable name="bovenLiggend"
                        select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                    <xsl:variable name="identificatie" select="rol:identificatie"/>
                    <xsl:if test="contains($activiteitenLijst, $bovenLiggend)">
                        <xsl:variable name="i1" select="$identificatie"/>
                        <xsl:for-each select="../../../sl:stand/owo:owObject/rol:Activiteit">
                            <xsl:if
                                test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $i1">
                                <xsl:variable name="i2" select="rol:identificatie"/>
                                <xsl:if test="$identificatie=$i2">
                                    <xsl:value-of select="concat($i2, ', ')"/>
                                </xsl:if>
                                <xsl:for-each select="../../../sl:stand/owo:owObject/rol:Activiteit">
                                    <xsl:if
                                        test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $i2">
                                        <xsl:variable name="i3" select="rol:identificatie"/>
                                        <xsl:if test="$identificatie=$i3">
                                            <xsl:value-of select="concat($i3, ', ')"/>
                                        </xsl:if>
                                        <xsl:for-each
                                            select="../../../sl:stand/owo:owObject/rol:Activiteit">
                                            <xsl:if
                                                test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $i3">
                                                <xsl:variable name="i4" select="rol:identificatie"/>
                                                <xsl:if test="$identificatie=$i4">
                                                    <xsl:value-of select="concat($i4, ', ')"/>
                                                </xsl:if>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <sch:assert test="string-length($offendingIds)=0">Activiteit-ids: <sch:value-of select="$offendingIds"/>: ZH:TP0D930: Een bovenliggende activiteit mag
                      niet naar een activiteit verwijzen die lager in de
              hiërarchie ligt.</sch:assert>
        </sch:rule>
    </sch:pattern>

</sch:schema>
