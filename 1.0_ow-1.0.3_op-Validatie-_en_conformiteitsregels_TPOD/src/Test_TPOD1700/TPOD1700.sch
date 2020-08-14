<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:ow-dc="http://www.geostandaarden.nl/imow/bestanden/deelbestand"
    xmlns:ow="http://www.geostandaarden.nl/imow/owobject"
    xmlns:da="http://www.geostandaarden.nl/imow/datatypenalgemeen"
    xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek"
    xmlns:ga="http://www.geostandaarden.nl/imow/gebiedsaanwijzing"
    xmlns:k="http://www.geostandaarden.nl/imow/kaart"
    xmlns:l="http://www.geostandaarden.nl/imow/locatie"
    xmlns:p="http://www.geostandaarden.nl/imow/pons"
    xmlns:r="http://www.geostandaarden.nl/imow/regels"
    xmlns:rol="http://www.geostandaarden.nl/imow/regelsoplocatie"
    xmlns:vt="http://www.geostandaarden.nl/imow/vrijetekst"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:tekst="https://standaarden.overheid.nl/stop/imop/tekst/"
    xmlns:stop="https://standaarden.overheid.nl/stop/imop/stop/"
    xmlns:aanlevering="https://standaarden.overheid.nl/lvbb/stop/aanlevering/"
    xmlns:basisgeo="http://www.geostandaarden.nl/basisgeometrie/1.0"
    xmlns:gio="https://standaarden.overheid.nl/stop/imop/gio/"
    xmlns:gml="http://www.opengis.net/gml/3.2"
    xmlns:geo="https://standaarden.overheid.nl/stop/imop/geo/"
    xmlns:lvbb="http://www.overheid.nl/2017/lvbb"
    xmlns:tns="http://www.logius.nl/digikoppeling/gb/2010/10"
    xmlns:ow-manifest="http://www.geostandaarden.nl/bestanden-ow/manifest-ow"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject" prefix="ow"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/datatypenalgemeen" prefix="da"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek" prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing" prefix="ga"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/kaart" prefix="k"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/locatie" prefix="l"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/pons" prefix="p"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie" prefix="rol"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/vrijetekst" prefix="vt"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>

    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/tekst/" prefix="tekst"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/aanlevering/" prefix="aanlevering"/>

    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/1.0" prefix="basisgeo"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/gio/" prefix="gio"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/geo/" prefix="geo"/>

    <sch:ns uri="http://www.overheid.nl/2017/lvbb" prefix="lvbb"/>
    <sch:ns uri="http://www.overheid.nl/2017/stop" prefix="stop"/>
    <sch:ns uri="http://www.logius.nl/digikoppeling/gb/2010/10" prefix="tns"/>

    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/manifest-ow" prefix="ow-manifest"/>

    <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>

    <!-- ====================================== GENERIC ============================================================================= -->
    <sch:let name="xmlDocuments" value="collection('.?select=*.xml')"/>
    <sch:let name="gmlDocuments" value="collection('.?select=*.gml')"/>
    <sch:let name="SOORT_REGELING"
        value="$xmlDocuments//aanlevering:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>

    <sch:let name="AMvB" value="'/join/id/stop/regelingtype_001'"/>
    <sch:let name="MR" value="'/join/id/stop/regelingtype_002'"/>
    <sch:let name="OP" value="'/join/id/stop/regelingtype_003'"/>
    <sch:let name="OV" value="'/join/id/stop/regelingtype_004'"/>
    <sch:let name="WV" value="'/join/id/stop/regelingtype_005'"/>
    <sch:let name="OVI_PB" value="''"/>

    <!-- ============================================================================================================================ -->

    <sch:pattern id="TPOD_1700">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="activiteitenLijst" value="foo:activiteitenLijstTPOD_1700()"/>
            <sch:let name="bovenLiggend"
                value="string(rol:bovenliggendeActiviteit/rol:ActiviteitRef/@xlink:href)"/>
            <sch:let name="identificatie" value="rol:identificatie/text()"/>
            <sch:let name="result" value="foo:run1700($identificatie, $bovenLiggend, $activiteitenLijst)"/>
            <sch:let name="CONDITION" value="not(contains($result, ','))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1700: Activiteit-ids: <sch:value-of select="$result" />: 
                Voor elke hiërarchie van nieuwe activiteiten geldt dat de hoogste activiteit in
                de hiërarchie een bovenliggende activiteit moet hebben die reeds bestaat in de
                functionele structuur. DIT LAATSTE WORDT NU NOG NIET GETEST!</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:run1700">
        <xsl:param name="identificatie"/>
        <xsl:param name="bovenLiggendForContains"/>
        <xsl:param name="activiteitenLijstForContains"/>
        <xsl:variable name="result" select="foo:isLokaal1700($bovenLiggendForContains, $activiteitenLijstForContains, '')"/>
        <xsl:value-of select="$result"/>
    </xsl:function>
    
    <xsl:function name="foo:isLokaal1700">
        <xsl:param name="bovenLiggendForContains"/>
        <xsl:param name="activiteitenLijstForContains"/>
        <xsl:param name="circulaireActiviteitenLijstForContains"/>
        <xsl:choose>
            <xsl:when test="contains($activiteitenLijstForContains, $bovenLiggendForContains)">
                <!-- Is lokaal, testen ciculaire en evt toevoegen aan circulaire en dan recursive -->
                <xsl:choose>
                    <xsl:when test="contains($circulaireActiviteitenLijstForContains, $bovenLiggendForContains)">
                        <!-- fout, mag niet al een keer zijn voorgekomen -->
                        <xsl:value-of select="concat($circulaireActiviteitenLijstForContains,',',$bovenLiggendForContains)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each
                            select="$xmlDocuments/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
                            <xsl:if test="rol:identificatie/text() = $bovenLiggendForContains">
                                <!-- nieuwe bovenliggend toevoegen aan circulaire en dan recursive -->
                                <xsl:value-of 
                                    select="foo:isLokaal1700(
                                        string(rol:bovenliggendeActiviteit/rol:ActiviteitRef/@xlink:href), 
                                        $activiteitenLijstForContains, 
                                        concat($circulaireActiviteitenLijstForContains,',',$bovenLiggendForContains)
                                    )"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <!-- is niet lokaal, lege string -->
            <xsl:otherwise>
                <xsl:value-of select="$bovenLiggendForContains"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="foo:activiteitenLijstTPOD_1700">
        <xsl:variable name="activiteitenLijst">
            <xsl:for-each
                select="$xmlDocuments/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
                <xsl:value-of select="rol:identificatie"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$activiteitenLijst"/>
    </xsl:function>

</sch:schema>
