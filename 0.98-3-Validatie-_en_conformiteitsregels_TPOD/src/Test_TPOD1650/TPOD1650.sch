<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:ow-dc="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
    xmlns:rol="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    >
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901" prefix="rol"/>
    
    <!-- ====================================== GENERIC ============================================================================= -->
    <xsl:variable name="xmlDocuments" select="collection('.?select=*.xml')"/>
    <xsl:variable name="gmlDocuments" select="collection('.?select=*.gml')"/>
    <xsl:variable name="SOORT_REGELING" select="$xmlDocuments//stop:AanleveringBesluit/stop:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>
    
    <xsl:variable name="AMvB" select="'/join/id/stop/regelingtype_001'"/>
    <xsl:variable name="MR" select="'/join/id/stop/regelingtype_002'"/>
    <xsl:variable name="OP" select="'/join/id/stop/regelingtype_003'"/>
    <xsl:variable name="OV" select="'/join/id/stop/regelingtype_004'"/>
    <xsl:variable name="WV" select="'/join/id/stop/regelingtype_005'"/>
    <xsl:variable name="OVI_PB" select="''"/>
    
    <xsl:variable name="APPLICABLE" select=""/>
    <!-- ============================================================================================================================ -->    
    
    <sch:pattern id="TPOD1650">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Omgevingswaarde">
            <sch:assert
                test="
                (rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde or rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde) and
                not(rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde and rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde)"
                > H:TPOD1650: <sch:value-of select="rol:identificatie"/>: Het attribuut 'normwaarde' moet bestaan uit één van de twee mogelijke
                attributen; 'kwalitatieveWaarde' óf 'kwantitatieveWaarde'. </sch:assert>
        </sch:rule>
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Omgevingsnorm">
            <sch:assert
                test="
                (rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde or rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde) and
                not(rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde and rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde)"
                > H:TPOD1650: <sch:value-of select="rol:identificatie"/>: Het attribuut 'normwaarde' moet bestaan uit één van de twee mogelijke
                attributen; 'kwalitatieveWaarde' óf 'kwantitatieveWaarde'. </sch:assert>
        </sch:rule>
    </sch:pattern>

</sch:schema>