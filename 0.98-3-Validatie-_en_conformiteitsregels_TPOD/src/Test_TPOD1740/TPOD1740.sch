<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:lvbb="http://www.overheid.nl/2017/lvbb"
    >
    
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901" prefix="rol"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709" prefix="rol-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    
    
    
    <sch:pattern id="TPOD1700_TPOD1710_TPOD1730">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
            <xsl:variable name="activiteitenLijst">
                <xsl:for-each
                    select="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
                    <xsl:value-of select="rol:identificatie"/>
                </xsl:for-each>
            </xsl:variable>
            
            <!-- TPOD1740  -->
            <sch:report test="not(contains($activiteitenLijst, rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href))"> REPORT: H:TPOD1740: <sch:value-of
                select="rol:identificatie"
            />:  Betreft verwijzing: <sch:value-of select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>: Bovenliggende 
                activiteiten moeten bestaan indien er naar verwezen wordt. DIT LAATSTE WORDT NU NOG
                NIET GETEST</sch:report>
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