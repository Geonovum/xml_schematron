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

    <sch:pattern id="TPOD_0741">
        <sch:rule context="//tekst:Hoofdstuk">
            <sch:let name="APPLICABLE" value="$SOORT_REGELING = $OV"/>
            <sch:let name="hoofdstuk" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="bevatLetters" value="foo:bevatGeletterdeNummersTPOD_0741($hoofdstuk, .)"/>
            <sch:let name="CONDITION_1" value="string-length($bevatLetters) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_1) or not($APPLICABLE)"> 
                TPOD_0741: De nummering van Artikelen bevat letters en kan niet middels schematron op geldigheid
                worden gecheckt. Dit moet handmatig gebeuren. 
                (betreft hoofdstuk: <sch:value-of select="$hoofdstuk"/>, artikelen: <sch:value-of select="substring($bevatLetters, 1, string-length($bevatLetters) - 2)"/>)</sch:assert>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0741($hoofdstuk, $bevatLetters, .)"/>
            <sch:let name="CONDITION_2" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_2) or not($APPLICABLE)"> 
                TPOD_0741: De nummering van Artikelen begint met het nummer van het Hoofdstuk waarin het Artikel
                voorkomt, gevolgd door een punt, daarna oplopende nummering van de Artikelen in Arabische cijfers inclusief indien nodig een letter. 
                (betreft hoofdstuk:<sch:value-of select="$hoofdstuk"/>, artikelen: <sch:value-of select="substring($volgorde, 1, string-length($volgorde) - 2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0480">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context/../tekst:Titel">
            <xsl:if test="$context/@eId=@eId and not(substring-after(string(tekst:Kop/tekst:Nummer),concat(../tekst:Kop/tekst:Nummer,'.'))=string(position()))">
                <xsl:value-of select="@eId"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>

    <xsl:function name="foo:bevatGeletterdeNummersTPOD_0741">
        <xsl:param name="hoofdstuk" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="bevatLetters">
            <xsl:for-each select="$context/descendant::tekst:Artikel">
                <xsl:variable name="artikelNummer" select="string(tekst:Kop/tekst:Nummer)"/>
                <xsl:variable name="nummers" select="tokenize($artikelNummer, '\.')"/>
                <xsl:if test="count($nummers) = 2">
                    <xsl:variable name="nummer" select="$nummers[2]"/>
                    <xsl:if test="matches($nummer, '\d{1,2}[a-z]{1,2}')">
                        <xsl:value-of select="concat($hoofdstuk, '.', $nummer, ', ')"/>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$bevatLetters"/>
    </xsl:function>

    <xsl:function name="foo:volgordeTPOD_0741">
        <xsl:param name="hoofdstuk" as="xs:string"/>
        <xsl:param name="bevatLetters"/>
        <xsl:param name="context" as="node()"/>
        <xsl:if test="string-length($bevatLetters) = 0">
            <xsl:variable name="volgorde">
                <xsl:for-each select="$context/descendant::tekst:Artikel">
                    <xsl:variable name="pos" select="position()"/>
                    <xsl:variable name="artikelNummer" select="string(tekst:Kop/tekst:Nummer)"/>
                    <xsl:choose>
                        <xsl:when test="contains($artikelNummer, '.')">
                            <xsl:variable name="nummers" select="tokenize($artikelNummer, '\.')"/>
                            <xsl:if test="count($nummers) = 2">
                                <xsl:variable name="nummer" select="$nummers[2]"/>
                                <xsl:choose>
                                    <xsl:when
                                        test="(matches($nummer, '\d{1,2}')) or (matches($nummer, '\d{1,2}[a-z]{1}'))">
                                        <xsl:choose>
                                            <xsl:when test="matches($nummer, '\d{1,2}[a-z]{1}')">
                                                <xsl:if
                                                  test="not(string(tokenize($nummer, '[a-z]{1}')[1]) = string($pos))">
                                                  <xsl:value-of
                                                  select="concat($hoofdstuk, '.', $nummer, ', ')"/>
                                                </xsl:if>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:if test="not($nummer = string($pos))">
                                                  <xsl:value-of
                                                  select="concat($hoofdstuk, '.', $nummer, ', ')"/>
                                                </xsl:if>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of
                                            select="concat($hoofdstuk, '.', $nummer, ', ')"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                            <xsl:if test="count($nummers) > 2">
                                <xsl:value-of select="concat($artikelNummer, ', ')"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat($artikelNummer, ', ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="$volgorde"/>
        </xsl:if>
    </xsl:function>

</sch:schema>
