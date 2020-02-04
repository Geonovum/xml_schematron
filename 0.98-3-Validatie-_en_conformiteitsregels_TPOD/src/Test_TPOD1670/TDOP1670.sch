<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    >
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels-ref/v20190901" prefix="r-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    
    <xsl:variable name="xmlDocuments" select="collection('.?select=*.xml')"/>
    <xsl:variable name="gmlDocuments" select="collection('.?select=*.gml')"/>
    
    <sch:pattern id="TPOD1670">
        <sch:rule
            context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/r:RegelVoorIedereen">
            <sch:assert
                test="(r:activiteitaanduiding) or (not(r:activiteitaanduiding) and not(r:activiteitregelkwalificatie))"
                > H:TPOD1670: behorend bij ArtikelOfLid <sch:value-of select="r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>: Activiteitregelkwalificatie is alleen te gebruiken wanneer het object
                ‘Regel voor iedereen’ is geannoteerd met Activiteit. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>