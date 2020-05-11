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
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/tekst/" prefix="tekst"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
    
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

    <sch:pattern id="TPOD_0990">
        <sch:rule context="//tekst:Kop[string(tekst:Opschrift) = 'Begripsbepalingen']">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="fouten" value="foo:inleidendezinBegripsBepalingTPOD0980(..)"/>
            <sch:let name="CONDITION"
                value="string-length($fouten)=0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0990: Het artikel Begripsbepalingen dan wel de bijlage met begripsbepalingen moet met beginnen met een introducerende zin. 
                Dit is niet zo in: <sch:value-of select="$fouten"/> </sch:assert>
        </sch:rule>
    </sch:pattern>

    <xsl:function name="foo:inleidendezinBegripsBepalingTPOD0980">
        <xsl:param name="context" as="node()"/>
        <xsl:if test="not(name($context/tekst:Inhoud/*[1])='Al')">
            <xsl:value-of select="concat($context/tekst:Kop/tekst:Label/text(),' ',$context/tekst:Kop/tekst:Nummer/text(),' ', $context/tekst:Kop/tekst:Opschrift/text())"/>
        </xsl:if>
    </xsl:function>
    
</sch:schema>
