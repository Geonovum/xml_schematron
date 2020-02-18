<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing/v20190709" prefix="ga"/>

    <sch:pattern id="TPOD1830">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/ga:Gebiedsaanwijzing/ga:type">
            <sch:assert test="not(text()='functie')">
                H:TPOD1830: Binnen het object ‘Gebiedsaanwijzing’ is de waarde ‘functie’ van attribuut ‘type’
                (datatype TypeGebiedsaanwijzing) niet toegestaan. Het object waarom het
                gaat: <sch:value-of select="../ga:identificatie/text()"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>


</sch:schema>
