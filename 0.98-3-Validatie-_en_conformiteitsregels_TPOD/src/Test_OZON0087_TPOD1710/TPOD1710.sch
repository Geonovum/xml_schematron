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
            <!-- TPOD1710  -->
            <!-- Er wordt uitgegaan van een maximale diepte van Ow-Activiteiten-hierarchie binnen een besluit context van 6 lagen (in werkelijkheid komen er
            in een OW-set maar enkele lagen van hierarchie voor voordat er naar een functionele structuur wordt verwezen).
            
            Waarom niet in een functie?
            Dit kan eventueel ook binnen een recursieve functie worden gedaan, maar dan moet er worden gecontroleerd op circulaire structuren, 
            dat veroorzaakt extra code, binnen schematron een ingewikkeld algoritme, de functie kan in latere optimalisatie worden geschreven.
            -->
            <!-- Uiteindelijk bevatten de offendingIds activiteiten die circulair over andere activiteiten naar zichzelf verwijzen -->
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
                <!-- hier worden de activiteiten uitgefilterd waarvan de bovenliggende activiteiten in de functionele structuur zitten -->
                <xsl:if test="contains($activiteitenLijst, $bovenLiggend)">
                    <xsl:value-of
                        select="foo:circulaireActiviteiten($identificatie, $identificatie, /)"/>
                </xsl:if>
            </xsl:variable>
            
            <!-- TPOD1710  -->
            <sch:assert test="string-length($circulaireActivititeiten) = 0">ZH:TP0D1710:
                Activiteit-ids: <sch:value-of select="$circulaireActivititeiten"/>: Een
                bovenliggende activiteit mag niet naar een activiteit verwijzen die lager in de
                hiërarchie ligt.</sch:assert>
        </sch:rule>
    
    </sch:pattern>
    
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