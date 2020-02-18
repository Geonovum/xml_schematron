<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>

    <xsl:variable name="xmlDocuments" select="collection('.?select=*.xml')"/>

    <sch:pattern id="TPOD1910">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen/sl:objectType">
            <xsl:variable name="objects">
                <xsl:for-each select="../../../sl:stand/ow-dc:owObject/*"> 
                    <xsl:value-of select="concat('.',local-name(),'.')"/>
                </xsl:for-each>
            </xsl:variable>
            <sch:assert test="contains($objects, concat('.',text(),'.'))">
                H:TPOD1910: De objecttypen in
                ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen dienen overeen te komen met
                de daadwerkelijke objecten in het betreffende Ow-bestand. Het objecttype waarom het
                gaat staan nu genoemd: <sch:value-of select="text()"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>


</sch:schema>
