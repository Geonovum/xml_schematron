<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
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

    <xsl:variable name="xmlDocuments" select="collection('.?select=*.xml')"/>
    <xsl:variable name="gmlDocuments" select="collection('.?select=*.gml')"/>

    <sch:pattern id="TDOP_1860">
        <sch:rule context="//r:Regeltekst">
            <sch:assert
                test="not(r:gerelateerdeRegeltekst/r-ref:RegeltekstRef/@xlink:href eq r:identificatie)"
                > H:TPOD1860: Betreft <sch:value-of select="name()"/>: <sch:value-of
                    select="r:identificatie"/>: Iedere verwijzing naar een ander OwObject moet een
                bestaand (ander) OwObject zijn. (gerelateerdeRegeltekst verwijst naar zichzelf)
            </sch:assert>
        </sch:rule>
        <sch:rule context="//rol:Activiteit">
            <sch:assert
                test="not(rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef/@xlink:href eq rol:identificatie)"
                > H:TPOD1860: Betreft <sch:value-of select="name()"/>: <sch:value-of
                    select="rol:identificatie"/>: Iedere verwijzing naar een ander OwObject moet een
                bestaand (ander) OwObject zijn. (gerelateerdeActiviteit verwijst naar zichzelf)
            </sch:assert>
        </sch:rule>
        <sch:rule
            context="//r:artikelOfLid/r-ref:RegeltekstRef">
            <xsl:variable name="identifiers"
                select="foo:getIdentifiers($xmlDocuments//r:Regeltekst/r:identificatie)"/>
            <sch:assert test="contains($identifiers, @xlink:href)"> H:TPOD1860: Betreft
                    <sch:value-of select="../../name()"/>: <sch:value-of
                    select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>, <sch:value-of
                    select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject moet een
                bestaand (ander) OwObject zijn. </sch:assert>
        </sch:rule>
        <sch:rule
            context="//r:RegelVoorIedereen/r:activiteitaanduiding/rol-ref:ActiviteitRef">
            <xsl:variable name="identifiers"
                select="foo:getIdentifiers($xmlDocuments//rol:Activiteit/rol:identificatie)"/>
            <sch:assert test="contains($identifiers, @xlink:href)"> H:TPOD1860: Betreft
                    <sch:value-of select="../../name()"/>: <sch:value-of
                    select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>, <sch:value-of
                    select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject moet een
                bestaand (ander) OwObject zijn. </sch:assert>
        </sch:rule>
        <sch:rule
            context="//r:omgevingsnormaanduiding/rol-ref:OmgevingsnormRef">
            <xsl:variable name="identifiers"
                select="foo:getIdentifiers($xmlDocuments//rol:Omgevingsnorm/rol:identificatie)"/>
            <sch:assert test="contains($identifiers, @xlink:href)"> H:TPOD1860: Betreft
                    <sch:value-of select="../../name()"/>: <sch:value-of
                    select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>, <sch:value-of
                    select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject moet een
                bestaand (ander) OwObject zijn. </sch:assert>
        </sch:rule>
        <sch:rule
            context="//r:gebiedsaanwijzing/ga-ref:GebiedsaanwijzingRef">
            <xsl:variable name="identifiers"
                select="foo:getIdentifiers($xmlDocuments//ga:Gebiedsaanwijzing/ga:identificatie)"/>
            <sch:assert test="contains($identifiers, @xlink:href)"> H:TPOD1860: Betreft
                    <sch:value-of select="../../name()"/>: <sch:value-of
                    select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>, <sch:value-of
                    select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject moet een
                bestaand (ander) OwObject zijn. </sch:assert>
        </sch:rule>
        <sch:rule
            context="//l-ref:LocatieRef | l-ref:GebiedRef | l-ref:GebiedengroepRef | l-ref:PuntRef | l-ref:PuntengroepRef | l-ref:LijnengroepRef | l-ref:LijnRef">
            <xsl:variable name="identifiers" select="foo:getLocationIdentifiers()"/>
            <sch:assert test="contains($identifiers, @xlink:href)"> H:TPOD1860: Betreft
                    <sch:value-of select="../../name()"/>: <sch:value-of
                    select="../../rol:identificatie"/>, <sch:value-of select="@xlink:href"/>: Iedere
                verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.
            </sch:assert>
        </sch:rule>
        <sch:rule
            context="//rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef">
            <xsl:variable name="identifiers"
                select="foo:getIdentifiers($xmlDocuments//rol:Activiteit/rol:identificatie)"/>
            <sch:assert test="contains($identifiers, @xlink:href)"> H:TPOD1860: Betreft
                    <sch:value-of select="../../name()"/>: <sch:value-of
                    select="../../rol:identificatie"/>, <sch:value-of select="@xlink:href"/>: Iedere
                verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.
            </sch:assert>
        </sch:rule>
        <sch:rule
            context="//rol:normwaarde/rol:Normwaarde/rol:locatieaanduiding/l-ref:LocatieRef | l-ref:GebiedRef | l-ref:GebiedengroepRef | l-ref:PuntRef | l-ref:PuntengroepRef | l-ref:LijnengroepRef | l-ref:LijnRef">
            <xsl:variable name="identifiers" select="foo:getLocationIdentifiers()"/>
            <sch:assert test="contains($identifiers, @xlink:href)"> H:TPOD1860: Betreft
                    <sch:value-of select="../../../../name()"/>: <sch:value-of
                    select="../../../../rol:identificatie"/>, <sch:value-of select="@xlink:href"/>:
                Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <xsl:function name="foo:getLocationIdentifiers">
        <xsl:variable name="identifiers">
            <xsl:for-each
                select="$xmlDocuments//(l:Gebied|l:Gebiedengroep|l:Punt|l:Puntengroep|l:Lijn|l:Lijnengroep)/l:identificatie">
                <xsl:value-of select="text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>

    <xsl:function name="foo:getIdentifiers">
        <xsl:param name="xpath" as="node()*"/>
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xpath">
                <xsl:value-of select="text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>

</sch:schema>
