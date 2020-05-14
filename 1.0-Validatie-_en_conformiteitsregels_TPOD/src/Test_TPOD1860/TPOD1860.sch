<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:ow-dc="http://www.geostandaarden.nl/imow/bestanden/deelbestand"
    xmlns:ow="http://www.geostandaarden.nl/imow/owobject"
    xmlns:da="http://www.geostandaarden.nl/imow/datatypenalgemeen"
    xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek"
    xmlns:ga="http://www.geostandaarden.nl/imow/gebiedsaanwijzing"
    xmlns:k="http://www.geostandaarden.nl/imow/kaart"
    xmlns:l="http://www.geostandaarden.nl/imow/locatie"
    xmlns:p="http://www.geostandaarden.nl/imow/pons"
    xmlns:r="http://www.geostandaarden.nl/imow/regels"
    xmlns:rol="http://www.geostandaarden.nl/imow/regelsoplocatie"
    xmlns:vt="http://www.geostandaarden.nl/imow/vrijetekst"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:tekst="https://standaarden.overheid.nl/stop/imop/tekst/"
    xmlns:aanlevering="https://standaarden.overheid.nl/lvbb/stop/aanlevering/"
    
    xmlns:basisgeo="http://www.geostandaarden.nl/basisgeometrie/1.0"
    xmlns:gio="https://standaarden.overheid.nl/stop/imop/gio/"
    xmlns:gml="http://www.opengis.net/gml/3.2"
    xmlns:geo="https://standaarden.overheid.nl/stop/imop/geo/"
    
    xmlns:lvbb="http://www.overheid.nl/2017/lvbb"
    xmlns:stop="http://www.overheid.nl/2017/stop"
    xmlns:tns="http://www.logius.nl/digikoppeling/gb/2010/10"
    
    xmlns:ow-manifest="http://www.geostandaarden.nl/bestanden-ow/manifest-ow"
    
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject" prefix="ow"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/datatypenalgemeen" prefix="da"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek" prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing" prefix="ga"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/kaart" prefix="k"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/locatie" prefix="l"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/pons" prefix="p"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie" prefix="rol"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/vrijetekst" prefix="vt"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/tekst/" prefix="tekst"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/aanlevering/" prefix="aanlevering"/>
    
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/1.0" prefix="basisgeo"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/gio/" prefix="gio"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/geo/" prefix="geo"/>
    
    <sch:ns uri="http://www.overheid.nl/2017/lvbb" prefix="lvbb"/>
    <sch:ns uri="http://www.overheid.nl/2017/stop" prefix="stop"/>
    <sch:ns uri="http://www.logius.nl/digikoppeling/gb/2010/10" prefix="tns"/>
    
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/manifest-ow" prefix="ow-manifest"/>
    
    <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
    
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

    <sch:pattern id="TPOD_1860">
        <sch:rule context="//r:Regeltekst">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="CONDITION"
                value="not(r:gerelateerdeRegeltekst/r-ref:RegeltekstRef/@xlink:href eq r:identificatie)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1860: Betreft <sch:value-of select="name()"/>:
                <sch:value-of select="r:identificatie"/>: Iedere verwijzing naar een ander
                OwObject moet een bestaand (ander) OwObject zijn. (gerelateerdeRegeltekst verwijst
                naar zichzelf) </sch:assert>
        </sch:rule>
        <sch:rule context="//rol:Activiteit">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION"
                value="not(rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef/@xlink:href eq rol:identificatie)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1860: Betreft <sch:value-of select="name()"/>:
                <sch:value-of select="rol:identificatie"/>: Iedere verwijzing naar een ander
                OwObject moet een bestaand (ander) OwObject zijn. (gerelateerdeActiviteit verwijst
                naar zichzelf) </sch:assert>
        </sch:rule>
        <sch:rule context="//r:artikelOfLid/r-ref:RegeltekstRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//r:Regeltekst/r:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>,
                <sch:value-of select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject
                moet een bestaand (ander) OwObject zijn. (r:Regeltekst/r:identificatie niet aangetroffen) </sch:assert>
        </sch:rule>
        <sch:rule context="//@rkow:regeltekstId">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//r:Regeltekst/r:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',.,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1860: Betreft <sch:value-of select="name()"/>:
                <sch:value-of select="."/>: Iedere verwijzing naar een ander OwObject
                moet een bestaand (ander) OwObject zijn. (r:Regeltekst/r:identificatie niet aangetroffen) </sch:assert>
        </sch:rule>
        <sch:rule context="//r:RegelVoorIedereen/r:activiteitaanduiding/rol-ref:ActiviteitRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Activiteit/rol:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>,
                <sch:value-of select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject
                moet een bestaand (ander) OwObject zijn. (rol:Activiteit/rol:identificatie niet aangetroffen)</sch:assert>
        </sch:rule>
        <sch:rule context="//r:omgevingsnormaanduiding/rol-ref:OmgevingsnormRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Omgevingsnorm/rol:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>,
                <sch:value-of select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject
                moet een bestaand (ander) OwObject zijn. (rol:Omgevingsnorm/rol:identificatie niet aangetroffen) </sch:assert>
        </sch:rule>
        <sch:rule context="//r:gebiedsaanwijzing/ga-ref:GebiedsaanwijzingRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//ga:Gebiedsaanwijzing/ga:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>,
                <sch:value-of select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject
                moet een bestaand (ander) OwObject zijn. (ga:Gebiedsaanwijzing/ga:identificatie niet aangetroffen) </sch:assert>
        </sch:rule>
        <sch:rule context="//rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Activiteit/rol:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../rol:identificatie"/>, <sch:value-of
                    select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject moet een
                bestaand (ander) OwObject zijn. (rol:Activiteit/rol:identificatie niet aangetroffen) </sch:assert>
        </sch:rule>
        <sch:rule
            context="//l-ref:LocatieRef | l-ref:GebiedRef | l-ref:GebiedengroepRef | l-ref:PuntRef | l-ref:PuntengroepRef | l-ref:LijnengroepRef | l-ref:LijnRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers" value="foo:getLocationIdentifiersTPOD_1860()"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../*:identificatie"/>, <sch:value-of
                    select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject moet een
                bestaand (ander) OwObject zijn. (verwijzing vanuit l:ref niet aangetroffen) </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:getLocationIdentifiersTPOD_1860">
        <xsl:variable name="identifiers">
            <xsl:for-each
                select="$xmlDocuments//(l:Gebied | l:Gebiedengroep | l:Punt | l:Puntengroep | l:Lijn | l:Lijnengroep)/l:identificatie">
                <xsl:value-of select="concat('.',text(),'.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <xsl:function name="foo:getIdentifiersTPOD_1860">
        <xsl:param name="xpath" as="node()*"/>
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xpath">
                <xsl:value-of select="concat('.',text(),'.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>

</sch:schema>
