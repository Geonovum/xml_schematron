<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels-ref/v20190901" prefix="r-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
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

    <sch:pattern id="TPOD1670">
        <sch:rule
            context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/r:RegelVoorIedereen">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="(r:activiteitaanduiding) or (not(r:activiteitaanduiding) and not(r:activiteitregelkwalificatie))"/>
            <sch:assert
                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"
                > H:TPOD1670: behorend bij ArtikelOfLid <sch:value-of
                    select="r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>:
                Activiteitregelkwalificatie is alleen te gebruiken wanneer het object ‘Regel voor
                iedereen’ is geannoteerd met Activiteit. </sch:assert>
        </sch:rule>
    </sch:pattern>

</sch:schema>
