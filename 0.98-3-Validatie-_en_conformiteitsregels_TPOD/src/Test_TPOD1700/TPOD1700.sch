<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:lvbb="http://www.overheid.nl/2017/lvbb"
    >
    
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
    
    
    <sch:pattern id="TPOD1700">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
            <xsl:variable name="APPLICABLE"
                select="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <xsl:variable name="activiteitenLijst">
                <xsl:for-each
                    select="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
                    <xsl:value-of select="rol:identificatie"/>
                </xsl:for-each>
            </xsl:variable>
            
            <xsl:variable name="circulaireActivititeiten">
                <xsl:variable name="bovenLiggend"
                    select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                <xsl:variable name="identificatie" select="rol:identificatie"/>
                <xsl:if test="contains($activiteitenLijst, $bovenLiggend)">
                    <xsl:value-of
                        select="foo:circulaireActiviteiten($identificatie, $identificatie, /)"/>
                </xsl:if>
            </xsl:variable>
            <xsl:variable name="activiteitenTrajectNaarFunctioneleStructuur">
                <xsl:variable name="identificatie" select="rol:identificatie"/>
                <xsl:variable name="lokaalBovenliggend"
                    select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                <xsl:if test="not(contains($circulaireActivititeiten, $identificatie))">
                    <xsl:choose>
                        <xsl:when test="not(contains($activiteitenLijst, $lokaalBovenliggend))">
                            <xsl:value-of select="concat($identificatie, ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="foo:activiteitenPad($identificatie, $lokaalBovenliggend, $activiteitenLijst, / )"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:variable>
            <xsl:variable name="CONDITION" select="string-length($activiteitenTrajectNaarFunctioneleStructuur) > 0"/>
            <sch:report test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"
                >REPORT: ZH:TPOD1700: Activiteit-ids: <sch:value-of
                    select="$activiteitenTrajectNaarFunctioneleStructuur"/>: Voor elke hiërarchie
                van nieuwe activiteiten geldt dat de hoogste activiteit in de hiërarchie een
                bovenliggende activiteit moet hebben die reeds bestaat in de functionele structuur.
                DIT LAATSTE WORDT NU NOG NIET GETEST </sch:report>
        </sch:rule>
    
    </sch:pattern>
    
    <xsl:function name="foo:activiteitenPad">
        <xsl:param name="identificatie" as="xs:string"/>
        <xsl:param name="bovenliggend" as="xs:string"/>
        <xsl:param name="activiteitenLijst" as="xs:string*"/>
        <xsl:param name="context" as="node()"/>
        <xsl:for-each
            select="$context/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
            <xsl:if test="rol:identificatie = $bovenliggend">
                <xsl:variable name="lokaalBovenliggend"
                    select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                <xsl:choose>
                    <xsl:when test="not(contains($activiteitenLijst, $lokaalBovenliggend))">
                        <xsl:value-of select="concat($identificatie, ', ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of
                            select="foo:activiteitenPad($identificatie, $lokaalBovenliggend, $activiteitenLijst, /)"
                        />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="foo:circulaireActiviteiten">
        <xsl:param name="identificatie" as="xs:string"/>
        <xsl:param name="bovenliggend" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:for-each
            select="$context/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
            <xsl:if
                test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $bovenliggend">
                <xsl:variable name="lokaalBovenliggend" select="rol:identificatie"/>
                <xsl:choose>
                    <xsl:when test="$identificatie = $lokaalBovenliggend">
                        <xsl:value-of select="concat($lokaalBovenliggend, ', ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of
                            select="foo:circulaireActiviteiten($identificatie, $lokaalBovenliggend, /)"
                        />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
</sch:schema>