<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
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
    
    <sch:pattern id="TPOD1910">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen/sl:objectType">
            <xsl:variable name="APPLICABLE" select="true()"/>
            <xsl:variable name="objects">
                <xsl:for-each select="../../../sl:stand/ow-dc:owObject/*"> 
                    <xsl:value-of select="concat('.',local-name(),'.')"/>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="CONDITION" select="contains($objects, concat('.',text(),'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                H:TPOD1910: De objecttypen in
                ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen dienen overeen te komen met
                de daadwerkelijke objecten in het betreffende Ow-bestand. Het objecttype waarom het
                gaat staan nu genoemd: <sch:value-of select="text()"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>
