<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
    xmlns:r="http://www.geostandaarden.nl/imow/regels/v20190901"
    xmlns:owo="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:ow="http://www.geostandaarden.nl/imow/owobject/v20190709"
    xmlns:man="http://www.overheid.nl/2017/lvbb"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    >
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="owo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="ow"/>
    <sch:ns uri="http://www.overheid.nl/2017/lvbb" prefix="man"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>

    <!--    <sch:phase id="critical">
        <sch:active pattern="Regeltekstnummers_behorend_bij_RegeltekstObject"/>
    </sch:phase>
-->
<!--    <sch:let name="Besluit" value=""/>-->

    <sch:pattern id="TPOD930">
        <!-- find all gio's -->
        <sch:rule context="/">
            <xsl:variable name="xmlDocumenten" select="document('manifest.xml')//man:manifest/man:bestand/man:bestandsnaam"/>
            <xsl:for-each select="$xmlDocumenten">
                <sch:assert test="1=0">
                    <sch:value-of select="string('test')" />
                </sch:assert>
            </xsl:for-each>
            <xsl:for-each select="$xmlDocumenten">
                <!--<xsl:variable name="filename" select="."/>
                <xsl:variable name="gioDoc" select="document($filename)//stop:AanleveringGIO" />
                <sch:assert test="1=0">
                    <xsl:value-of select="string('.')" />
                </sch:assert>
                                <xsl:if test="$gioDoc">
                    <sch:assert test="1=0">
                        <xsl:value-of select="$gioDoc" />
                    </sch:assert>
                </xsl:if>
-->            </xsl:for-each>
        </sch:rule>

    </sch:pattern>


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
</sch:schema>
