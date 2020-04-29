<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:lvbb="http://www.overheid.nl/2017/lvbb">

    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901" prefix="rol"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709" prefix="rol-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
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

    <sch:pattern id="TPOD_1740">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="activiteitenLijst" value="foo:activiteitenLijstTPOD_1740()"/>

            <!-- TPOD1740  -->
            <sch:let name="CONDITION" value="not(contains($activiteitenLijst, rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href))"/>
            <sch:report
                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                REPORT: H:TPOD1740: <sch:value-of select="rol:identificatie"/>: Betreft
                verwijzing: <sch:value-of
                    select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>:
                Bovenliggende activiteiten moeten bestaan indien er naar verwezen wordt. DIT LAATSTE
                WORDT NU NOG NIET GETEST</sch:report>
        </sch:rule>

    </sch:pattern>
    
    <xsl:function name="foo:activiteitenLijstTPOD_1740">
        <xsl:variable name="activiteitenLijst">
            <xsl:for-each
                select="$xmlDocuments/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
                <xsl:value-of select="rol:identificatie/text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$activiteitenLijst"/>
    </xsl:function>
</sch:schema>
