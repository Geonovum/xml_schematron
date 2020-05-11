<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:tekst="https://standaarden.overheid.nl/stop/imop/tekst/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/" xmlns:foo="http://whatever">

    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/locatie/v20190901" prefix="l"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/datatypenalgemeen/v20190709" prefix="da"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    
    
    
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

    <sch:pattern id="TPOD_1310">
        <sch:rule context="//l:Gebied/l:hoogte[string(da:eenheid) ne 'http://standaarden.omgevingswet.overheid.nl/eenheid/id/concept/Meter_Eenheid']">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1310: De grootheid waarin de hoogte wordt uitgedrukt; in het geval van hoogte dient altijd de eenheid meter gekozen te worden. 
                Dit is niet zo in Gebied: <sch:value-of select="../l:identificatie"/> </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
