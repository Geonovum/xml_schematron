<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
    xmlns:r="http://www.geostandaarden.nl/imow/regels/v20190901"
    xmlns:owo="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:ow="http://www.geostandaarden.nl/imow/owobject/v20190709"
    xmlns:geo="http://www.geostandaarden.nl/basisgeometrie/v20190901"
    xmlns:gml="http://www.opengis.net/gml/3.2"
    xmlns:jcs="http://xml.juniper.net/junos/commit-scripts/1.0"
    >
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="owo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="ow"/>
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:ns uri="http://xml.juniper.net/junos/commit-scripts/1.0" prefix="jcs"/>

    <sch:pattern id="Controleren_decimalenGML">
        <sch:rule context="*//geo:geometrie/posListArray[@geometrie eq '28992']/pos">
            <sch:let name="id" value="parent::*/@id"/>
            <sch:let name="waarde" value="string(.)"/>
            <sch:assert test="string-length(substring-after(string(.),'.')) &lt; 4">waarde=<sch:value-of select="string(.)"/>, id=<sch:value-of select="$id"/>, bestand=<sch:value-of select="parent::*/@bestand"/>:ZH:TP0D930:Indien
                gebruik wordt gemaakt van EPSG:28992 (=RD new) dan moeten coördinaten in eenheden van meters worden opgegeven waarbij de waarde
                maximaal drie decimalen achter de komma mag bevatten.:OP/OW:T</sch:assert>
        </sch:rule>

        <sch:rule context="*//geo:geometrie/posListArray[@geometrie eq '4258']/pos">
            <sch:let name="id" value="parent::*/@id"/>
            <sch:let name="waarde" value="string(.)"/>
            <sch:assert test="string-length(substring-after(string(.),'.')) &lt; 9">waarde=<sch:value-of select="string(.)"/>, id=<sch:value-of select="$id"/>, bestand=<sch:value-of select="parent::*/@bestand"/>:ZH:TP0D930: Indien gebruik wordt gemaakt van EPSG:4258 (=ETRS89) dan moeten coördinaten in eenheden van decimale graden worden opgegeven waarbij de
                waarde maximaal acht decimalen achter de komma mag bevatten.:OP/OW:T</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="Controleren_aantal_CRS">    
        <sch:rule context="*//geo:geometrie">
            <sch:let name="noCrs" value="count(descendant-or-self::*/@srsName)"></sch:let>
            <sch:assert test="$noCrs=1">Aantal=<sch:value-of select="$noCrs"/>, id=<sch:value-of select="parent::*/geo:id"/>, bestand=<sch:value-of select="posListArray/@bestand"/>:ZH:TP0D930: Een geometrie moet zijn opgebouwd middels één coordinate reference
                system (crs): EPSG:28992 (=RD new) of EPSG:4258 (=ETRS89).:OP/OW:T</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
