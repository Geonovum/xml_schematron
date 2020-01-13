<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/">
    
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
        
    <sch:pattern id="TPOD930">
        <sch:rule context="/stop:AanleveringGIO/stop:InformatieObjectVersie/stop:InformatieObjectMetadata/stop:heeftBestanden"></sch:rule>
    </sch:pattern>
</sch:schema>