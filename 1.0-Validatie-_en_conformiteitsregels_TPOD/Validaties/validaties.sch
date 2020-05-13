<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
    xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="ow"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="rkow"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels-ref/v20190901" prefix="r-ref"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/locatie/v20190901" prefix="l"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/locatie-ref/v20190901" prefix="l-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901" prefix="rol"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709" prefix="rol-ref"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing/v20190709" prefix="ga"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing-ref/v20190709" prefix="ga-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/datatypenalgemeen/v20190709" prefix="da"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/geometrie-ref/v20190901" prefix="g-ref"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/geo/" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/1.0" prefix="basisgeo"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/vrijetekst/v20190901" prefix="vt"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/vrijetekst-ref/v20190901" prefix="vt-ref"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
    <sch:ns uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
    <sch:ns uri="https://standaarden.overheid.nl/stop/imop/tekst/" prefix="tekst"/>
    <sch:ns uri="http://www.overheid.nl/2017/lvbb" prefix="lvbb"/>
    
    
    <!-- ====================================== GENERIC ============================================================================= -->
    <sch:let name="xmlDocuments" value="collection('.?select=*.xml;recurse=yes')"/>
    <sch:let name="gmlDocuments" value="collection('.?select=*.gml;recurse=yes')"/>
    <sch:let name="SOORT_REGELING" value="$xmlDocuments//stop:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>
    
    <sch:let name="AMvB" value="'/join/id/stop/regelingtype_001'"/>
    <sch:let name="MR" value="'/join/id/stop/regelingtype_002'"/>
    <sch:let name="OP" value="'/join/id/stop/regelingtype_003'"/>
    <sch:let name="OV" value="'/join/id/stop/regelingtype_004'"/>
    <sch:let name="WV" value="'/join/id/stop/regelingtype_005'"/>
    <sch:let name="OVI" value="''"/>
    <sch:let name="PB" value="''"/>
    
    <!-- ============TPOD_0410================================================================================================================ -->
    
    <sch:pattern id="TPOD_0410">
        <sch:rule context="//tekst:Hoofdstuk/tekst:Kop[lower-case(tekst:Label) ne 'hoofdstuk']">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0410: Een Hoofdstuk moet worden geduid met de label Hoofdstuk. 
                (betreft hoofdstuk: <sch:value-of select="tekst:Nummer"/>, label: <sch:value-of select="tekst:Label"/>) </sch:assert> 
        </sch:rule>
    </sch:pattern>
        
    <!-- ============TPOD_0420=============================================================================================================== -->
    
    <sch:pattern id="TPOD_0420">
        <sch:rule context="//tekst:Lichaam">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0420(.)">
            </sch:let>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0420: Hoofdstukken moeten oplopend worden genummerd in Arabische cijfers 
                (betreft hoofdstukken:  <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0420">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Hoofdstuk">
                <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=string(position()))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0460================================================================================================================ -->
    
    <sch:pattern id="TPOD_0460">
        <sch:rule context="//tekst:Titel/tekst:Kop[lower-case(tekst:Label) ne 'titel']">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0410: Een Titel moet worden geduid met de label Titel. Betreft label: 
                <sch:value-of select="tekst:Nummer"/>:<sch:value-of select="tekst:Label"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0470================================================================================================================ -->
    
    <sch:pattern id="TPOD_0470">
        <sch:rule context="//tekst:Lichaam/tekst:Hoofdstuk">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="hoofdstuk" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="fouten" value="foo:foutenTPOD_0470($hoofdstuk, .)"/>
            
            <sch:let name="CONDITION" value="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0470: De nummering van Titels moet beginnen met het nummer van het Hoofdstuk waarin de Titel voorkomt. 
                (betreft hoofdstuk: <sch:value-of select="$hoofdstuk"/>, titels: <sch:value-of select="substring($fouten,1,string-length($fouten)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:foutenTPOD_0470">
        <xsl:param name="hoofdstuk" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Titel">
                <xsl:if test="not(starts-with(tekst:Kop/tekst:Nummer, concat($hoofdstuk, '.')))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ===========TPOD_0480================================================================================================================= -->
    
    <sch:pattern id="TPOD_0480">
        <sch:rule context="//tekst:Lichaam/tekst:Hoofdstuk">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="hoofdstuk" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0480($hoofdstuk, .)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0480: Titels moeten oplopend worden genummerd in Arabische cijfers. 
                (betreft hoofdstuk: <sch:value-of select="$hoofdstuk"/>, titels: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0480">
        <xsl:param name="hoofdstuk" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Titel">
                <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=concat($hoofdstuk, '.', string(position())))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0490================================================================================================================ -->
    
    <sch:pattern id="TPOD_0490">
        <sch:rule context="//tekst:Lichaam/tekst:Hoofdstuk">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="hoofdstuk" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="fouten" value="foo:foutenTPOD_0490( .)"/>
            <sch:let name="CONDITION" value="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0490: Achter het cijfer van een titelnummer mag geen punt worden opgenomen. 
                (betreft hoofdstuk: <sch:value-of select="$hoofdstuk"/>, titels: <sch:value-of select="substring($fouten,1,string-length($fouten)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:foutenTPOD_0490">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Titel">
                <xsl:if test="ends-with(tekst:Kop/tekst:Nummer, '.')">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ===========TPOD_0510================================================================================================================= -->
    
    <sch:pattern id="TPOD_0510">
        <sch:rule context="//tekst:Afdeling/tekst:Kop[lower-case(tekst:Label) ne 'afdeling']">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0510: Een Afdeling moet worden geduid met de label Afdeling. 
                Betreft afdeling: <sch:value-of select="tekst:Nummer"/>, label:<sch:value-of select="tekst:Label"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0520================================================================================================================ -->
    
    <sch:pattern id="TPOD_0520">
        <sch:rule context="//tekst:Hoofdstuk/tekst:Titel">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="hoofdstuk" value="string(../tekst:Kop/tekst:Nummer)"/>
            <sch:let name="titel" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0520($titel, .)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0520: Als tussen Hoofdstuk en Afdeling Titel voorkomt dan moet de nummering van Afdelingen beginnen met het samengestelde nummer van de Titel waarin de Afdeling voorkomt, gevolgd door een punt. 
                (betreft hoofdstuk: <xsl:value-of select="$hoofdstuk"/>, titel: <sch:value-of select="$titel"/>, afdelingen: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0520">
        <xsl:param name="titel" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Afdeling">
                <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=concat($titel, '.', string(position())))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0530================================================================================================================ -->
    
    <sch:pattern id="TPOD_0530">
        <sch:rule context="//tekst:Lichaam/tekst:Hoofdstuk">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="hoofdstuk" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0530($hoofdstuk, .)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0530: Afdelingen moeten oplopend worden genummerd in Arabische cijfers. 
                (betreft hoofdstukken: <sch:value-of select="$hoofdstuk"/>, afdelingen: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>

    <xsl:function name="foo:volgordeTPOD_0530">
        <xsl:param name="hoofdstuk" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Afdeling">
                <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=concat($hoofdstuk, '.', string(position())))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="$context/tekst:Titel">
                <xsl:variable name="titel" select="string(tekst:Kop/tekst:Nummer)"/>
                <xsl:for-each select="tekst:Afdeling">
                    <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=concat($titel, '.', string(position())))">
                        <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ===========TPOD_0540================================================================================================================= -->
    
    <sch:pattern id="TPOD_0540">
        <sch:rule context="//tekst:Lichaam/tekst:Hoofdstuk">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="hoofdstuk" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="fouten" value="foo:foutenTPOD_0540(.)">
            </sch:let>
            <sch:let name="CONDITION" value="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0540: Achter het cijfer van een afdelingnummer mag geen punt worden opgenomen. 
                (betreft hoofdstuk: <sch:value-of select="$hoofdstuk"/>, afdelingen: <sch:value-of select="substring($fouten,1,string-length($fouten)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:foutenTPOD_0540">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Afdeling">
                <xsl:if test="ends-with(tekst:Kop/tekst:Nummer, '.')">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="$context/tekst:Titel">
                <sch:let name="titel" value="string(tekst:Kop/tekst:Nummer)"/>
                <xsl:for-each select="tekst:Afdeling">
                    <xsl:if test="ends-with(tekst:Kop/tekst:Nummer, '.')">
                        <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0560================================================================================================================ -->
    
    <sch:pattern id="TPOD_0560">
        <sch:rule context="//tekst:Lichaam/tekst:Hoofdstuk">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="hoofdstuk" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="fouten" value="foo:foutenTPOD_0560($hoofdstuk, .)"/>
            <sch:let name="CONDITION" value="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0560: Als tussen Hoofdstuk en Afdeling geen Titel voorkomt dan moet de nummering van
                Afdelingen beginnen met het nummer van het Hoofdstuk waarin de Afdeling voorkomt, gevolgd door een punt. 
                (betreft hoofdstuk: <sch:value-of select="$hoofdstuk"/>, afdelingen: <sch:value-of select="substring($fouten, 1, string-length($fouten) - 2)"/>) </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:foutenTPOD_0560">
        <xsl:param name="hoofdstuk"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Afdeling">
                <xsl:if test="not(starts-with(tekst:Kop/tekst:Nummer, concat($hoofdstuk, '.')))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer), ', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ===========TPOD_0570================================================================================================================= -->
    
    <sch:pattern id="TPOD_0570">
        <sch:rule context="//tekst:Paragraaf/tekst:Kop[(lower-case(tekst:Label) ne '§') and (lower-case(tekst:Label) ne 'paragraaf')]">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0570: Een Paragraaf moet worden geduid met de label Paragraaf of het paragraaf-teken. 
                (betreft nummer: <sch:value-of select="tekst:Nummer"/>, label: <sch:value-of select="tekst:Label"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0580=============================================================================================================== -->
    
    <sch:pattern id="TPOD_0580">
        <sch:rule context="//tekst:Hoofdstuk/tekst:Afdeling">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="afdeling" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0580($afdeling, .)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0580: De nummering van Paragrafen begint met het samengestelde nummer van de Afdeling waarin de Paragraaf voorkomt, gevolgd door een punt. 
                (betreft afdeling: <xsl:value-of select="$afdeling"/>, paragrafen: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0580">
        <xsl:param name="afdeling" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Paragraaf">
                <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=concat($afdeling, '.', string(position())))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0590================================================================================================================ -->
    
    <sch:pattern id="TPOD_0590">
        <sch:rule context="//tekst:Hoofdstuk/tekst:Afdeling">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="afdeling" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0590($afdeling, .)"/>
            
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0590: Paragrafen moeten oplopend worden genummerd in Arabische cijfers.
                (betreft hoofdstuk: <sch:value-of select="../tekst:Kop/tekst:Nummer"/>, afdeling: <sch:value-of select="tekst:Kop/tekst:Nummer"/>, paragrafen:  <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0590">
        <xsl:param name="afdeling"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Paragraaf">
                <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=concat($afdeling, '.', string(position())))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0600================================================================================================================ -->
    
    <sch:pattern id="TPOD_0600">
        <sch:rule context="//tekst:Hoofdstuk/tekst:Afdeling">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="afdeling" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="fouten" value="foo:foutenTPOD_0600(.)">
            </sch:let>
            <sch:let name="CONDITION" value="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0600: Achter het cijfer van een paragraafnummer mag geen punt worden opgenomen.  
                (betreft hoofdstuk: <sch:value-of select="../tekst:Kop/tekst:Nummer"/>, afdeling: <sch:value-of select="tekst:Kop/tekst:Nummer"/>, paragrafen: <sch:value-of select="substring($fouten,1,string-length($fouten)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:foutenTPOD_0600">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Paragraaf">
                <xsl:if test="ends-with(tekst:Kop/tekst:Nummer, '.')">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0620================================================================================================================ -->
    
    <sch:pattern id="TPOD_0620">
        <sch:rule context="//tekst:Paragraaf/tekst:Subparagraaf/tekst:Kop[lower-case(tekst:Label) ne 'subparagraaf']">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0620: Een Subparagraaf moet worden geduid met de label Subparagraaf. 
                (Betreft subparagraaf-nummer: <sch:value-of select="tekst:Nummer"/> en label: <sch:value-of select="tekst:Label"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0630================================================================================================================ -->
    
    <sch:pattern id="TPOD_0630">
        <sch:rule context="//tekst:Afdeling/tekst:Paragraaf">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="paragraaf" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0630($paragraaf, .)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0630: De nummering van Subparagrafen begint met het samengestelde nummer van de Paragraaf waarin de Subparagraaf voorkomt, gevolgd door een punt. 
                (betreft paragraaf: <xsl:value-of select="$paragraaf"/>, subparagrafen: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0630">
        <xsl:param name="paragraaf" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Subparagraaf">
                <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=concat($paragraaf, '.', string(position())))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0640================================================================================================================ -->
    
    <sch:pattern id="TPOD_0640">
        <sch:rule context="//tekst:Afdeling/tekst:Paragraaf">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="paragraaf" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0640($paragraaf, .)"/>
            
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0640: Subparagrafen moeten oplopend worden genummerd in Arabische cijfers 
                (betreft paragraaf: <xsl:value-of select="$paragraaf"/>, subparagrafen: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0640">
        <xsl:param name="paragraaf"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Subparagraaf">
                <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=concat($paragraaf, '.', string(position())))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0650================================================================================================================ -->
    
    <sch:pattern id="TPOD_0650">
        <sch:rule context="//tekst:Afdeling/tekst:Paragraaf">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="paragraaf" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="fouten" value="foo:foutenTPOD_0650(.)">
            </sch:let>
            <sch:let name="CONDITION" value="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0650: Achter het cijfer van een subparagraafnummer mag geen punt worden opgenomen. 
                (betreft paragraaf: <sch:value-of select="$paragraaf"/>, subparagrafen: <sch:value-of select="substring($fouten,1,string-length($fouten)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:foutenTPOD_0650">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Subparagraaf">
                <xsl:if test="ends-with(tekst:Kop/tekst:Nummer, '.')">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0670================================================================================================================ -->
    
    <sch:pattern id="TPOD_0670">
        <sch:rule context="//tekst:Subparagraaf/tekst:Subsubparagraaf/tekst:Kop[lower-case(tekst:Label) ne 'subsubparagraaf']">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0670: Een Subsubparagraaf moet worden geduid met de label Subsubparagraaf. 
                (betreft subsubparagraaf-nummer: <sch:value-of select="tekst:Nummer"/>, label: <sch:value-of select="tekst:Label"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0680================================================================================================================ -->
    
    <sch:pattern id="TPOD_0680">
        <sch:rule context="//tekst:Paragraaf/tekst:Subparagraaf">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="subparagraaf" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0680($subparagraaf, .)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0680: De nummering van Subsubparagrafen begint met het samengestelde nummer van de Subparagraaf waarin de Subsubparagraaf voorkomt, gevolgd door een punt. 
                (betreft subparagraaf: <xsl:value-of select="$subparagraaf"/>, subsubparagrafen: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0680">
        <xsl:param name="subparagraaf" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Subsubparagraaf">
                <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=concat($subparagraaf, '.', string(position())))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0690================================================================================================================ -->
    
    <sch:pattern id="TPOD_0690">
        <sch:rule context="//tekst:Paragraaf/tekst:Subparagraaf">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="subparagraaf" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0690($subparagraaf, .)"/>
            
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0690: Subsubparagrafen moeten oplopend worden genummerd in Arabische cijfers 
                (betreft subparagraaf: <xsl:value-of select="$subparagraaf"/>,subsubparagrafen: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)  
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0690">
        <xsl:param name="subparagraaf"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Subsubparagraaf">
                <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=concat($subparagraaf, '.', string(position())))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0700================================================================================================================ -->
    
    <sch:pattern id="TPOD_0700">
        <sch:rule context="//tekst:Paragraaf/tekst:Subparagraaf">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="subparagraaf" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="fouten" value="foo:foutenTPOD_0700(.)">
            </sch:let>
            <sch:let name="CONDITION" value="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0700: Achter het laatste cijfer van een Subsubparagraafnummer mag geen punt worden opgenomen. 
                (betreft subparagraaf: <xsl:value-of select="$subparagraaf"/>,subsubparagrafen: <sch:value-of select="substring($fouten,1,string-length($fouten)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:foutenTPOD_0700">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Subsubparagraaf">
                <xsl:if test="ends-with(tekst:Kop/tekst:Nummer, '.')">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0720================================================================================================================ -->
    
    <sch:pattern id="TPOD_0720">
        <sch:rule context="//tekst:Artikel/tekst:Kop[lower-case(tekst:Label) ne 'artikel']">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0720: Een Artikel moet worden geduid met de label Artikel. 
                (betreft artikel: <sch:value-of select="tekst:Nummer"/>, label:<sch:value-of select="tekst:Label"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0730================================================================================================================ -->
    
    <sch:pattern id="TPOD_0730">
        <sch:rule context="//tekst:Hoofdstuk">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="hoofdstuk" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0730($hoofdstuk, .)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0730: De nummering van Artikelen begint met het nummer van het Hoofdstuk waarin het Artikel voorkomt, gevolgd door een punt.
                (betreft hoofdstuk: <xsl:value-of select="$hoofdstuk"/>, artikels: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
        
    <xsl:function name="foo:volgordeTPOD_0730">
        <xsl:param name="hoofdstuk" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/descendant::tekst:Artikel">
                <xsl:if test="not(foo:substring-before-lastTPOD_0730(tekst:Kop/tekst:Nummer,'.')=$hoofdstuk)">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <xsl:function name="foo:substring-before-lastTPOD_0730" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="delim" as="xs:string"/>
        <xsl:sequence select="
            if (matches($arg, foo:escape-for-regexTPOD_0730($delim)))
            then replace($arg,
            concat('^(.*)', foo:escape-for-regexTPOD_0730($delim),'.*'),
            '$1')
            else ''
            "/>
    </xsl:function>
    
    <xsl:function name="foo:escape-for-regexTPOD_0730" as="xs:string">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:sequence select="
            replace($arg,
            '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
            "/>
    </xsl:function>
    
    <!-- ============TPOD_0740================================================================================================================ -->
    
    <sch:pattern id="TPOD_0740">
        <sch:rule context="//tekst:Hoofdstuk">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $WV"/>
            <sch:let name="hoofdstuk" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0740($hoofdstuk, .)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0740: Artikelnummers moeten oplopend worden genummerd in Arabische cijfers 
                (betreft hoofdstuk: <sch:value-of select="$hoofdstuk"/>, artikelen: <sch:value-of select="substring($volgorde, 1, string-length($volgorde) - 2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0740">
        <xsl:param name="hoofdstuk"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/descendant::tekst:Artikel">
                <xsl:if
                    test="not(string(tekst:Kop/tekst:Nummer) = concat($hoofdstuk, '.', string(position())))">
                    <xsl:value-of select="concat(string(tekst:Kop/tekst:Nummer), ', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0741================================================================================================================ -->
    
    <sch:pattern id="TPOD_0741">
        <sch:rule context="//tekst:Hoofdstuk">
            <sch:let name="APPLICABLE" value="$SOORT_REGELING = $OV"/>
            <sch:let name="hoofdstuk" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="bevatLetters" value="foo:bevatGeletterdeNummersTPOD_0741($hoofdstuk, .)"/>
            <sch:let name="CONDITION_1" value="string-length($bevatLetters) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_1) or not($APPLICABLE)"> 
                TPOD_0741: De nummering van Artikelen bevat letters en kan niet middels schematron op geldigheid
                worden gecheckt. Dit moet handmatig gebeuren. 
                (betreft hoofdstuk: <xsl:value-of select="$hoofdstuk"/>, artikelen: <sch:value-of select="substring($bevatLetters, 1, string-length($bevatLetters) - 2)"/>)</sch:assert>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0741($hoofdstuk, $bevatLetters, .)"/>
            <sch:let name="CONDITION_2" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_2) or not($APPLICABLE)"> 
                TPOD_0741: De nummering van Artikelen begint met het nummer van het Hoofdstuk waarin het Artikel
                voorkomt, gevolgd door een punt, daarna oplopende nummering van de Artikelen in Arabische cijfers inclusief indien nodig een letter. 
                (betreft hoofdstuk:<xsl:value-of select="$hoofdstuk"/>, artikelen: <sch:value-of select="substring($volgorde, 1, string-length($volgorde) - 2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
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
    
    <!-- ============TPOD_0750================================================================================================================ -->
    
    <sch:pattern id="TPOD_0750">
        <sch:rule context="//tekst:Artikel">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="artikel" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="CONDITION" value="not(ends-with($artikel, '.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0750: Achter het laatste cijfer van een Artikelnummer mag geen punt worden opgenomen. 
                (betreft artikel: <sch:value-of select="$artikel"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0780================================================================================================================ -->
    
    <sch:pattern id="TPOD_0780">
        <sch:rule context="//tekst:Artikel">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $WV"/>
            <sch:let name="artikel" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0780(.)"/>
            
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0780: Leden moeten per artikel oplopend genummerd worden in Arabische cijfers
                (en indien nodig, een letter). 
                (betreft artikel: <sch:value-of select="$artikel"/>, leden: <sch:value-of
                    select="substring($volgorde, 1, string-length($volgorde) - 2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0780">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Lid">
                <xsl:if test="not(string(tekst:LidNummer)=concat(string(position()), '.'))">
                    <xsl:value-of select="concat(string(tekst:LidNummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0781================================================================================================================ -->
    
    <sch:pattern id="TPOD_0781">
        <sch:rule context="//tekst:Artikel">
            <sch:let name="APPLICABLE" value="$SOORT_REGELING = $OV"/>
            <sch:let name="artikel" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="bevatLetters" value="foo:bevatGeletterdeNummersTPOD_0781(.)"/>
            <sch:let name="CONDITION_1" value="string-length($bevatLetters) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_1) or not($APPLICABLE)"> TPOD_0781: De
                nummering van Leden bevat letters en kan niet middels schematron op geldigheid
                worden gecheckt. Dit moet handmatig gebeuren. 
                (betreft artikel: <sch:value-of select="$artikel"/>, leden: <sch:value-of
                    select="substring($bevatLetters, 1, string-length($bevatLetters) - 2)"
                />)</sch:assert> 
            <sch:let name="volgorde" value="foo:volgordeTPOD_0781($bevatLetters,.)"/>
            <sch:let name="CONDITION_2" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_2) or not($APPLICABLE)"> TPOD_0781: Leden
                moeten per artikel oplopend genummerd worden in Arabische cijfers (en indien nodig,
                een letter). 
                (betreft artikel: <sch:value-of select="$artikel"/>, leden: <sch:value-of
                    select="substring($volgorde, 1, string-length($volgorde) - 2)"
                />)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:bevatGeletterdeNummersTPOD_0781">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="bevatLetters">
            <xsl:for-each select="$context/tekst:Lid">
                <xsl:if test="matches(tekst:LidNummer, '\d{1,2}[a-z]{1,2}\.')">
                    <xsl:value-of select="concat(string(tekst:LidNummer), ', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$bevatLetters"/>
    </xsl:function>
    
    <xsl:function name="foo:volgordeTPOD_0781">
        <xsl:param name="bevatLetters"/>
        <xsl:param name="context" as="node()"/>
        <xsl:if test="string-length($bevatLetters) = 0">
            <xsl:variable name="volgorde">
                <xsl:for-each select="$context/tekst:Lid">
                    <xsl:variable name="pos" select="position()"/>
                    <xsl:choose>
                        <xsl:when
                            test="(matches(tekst:LidNummer, '\d{1,2}\.')) or (matches(tekst:LidNummer, '\d{1,2}[a-z]{1}\.'))">
                            <xsl:if test="matches(tekst:LidNummer, '\d{1,2}\.')">
                                <xsl:if
                                    test="not(string(tekst:LidNummer) = concat(string($pos), '.'))">
                                    <xsl:value-of select="concat(string(tekst:LidNummer), ', ')"/>
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="matches(tekst:LidNummer, '\d{1,2}[a-z]{1}\.')">
                                <xsl:if
                                    test="not(string(tokenize(tekst:LidNummer, '[a-z]{1}')[1]) = string($pos)) and not(ends-with(tekst:LidNummer, '.'))">
                                    <xsl:value-of select="concat(string(tekst:LidNummer), ', ')"/>
                                </xsl:if>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat(string(tekst:LidNummer), ', ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="$volgorde"/>
        </xsl:if>
    </xsl:function>
    
    <!-- ============TPOD_0790================================================================================================================ -->
    
    <sch:pattern id="TPOD_0790">
        <sch:rule context="//tekst:Artikel">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="artikel" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0790(.)"/>
            
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0790: Het eerste lid van ieder artikel krijgt het nummer 1. 
                (betreft artikel: <sch:value-of select="$artikel"/>, lid: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0790">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Lid">
                <xsl:if test="position() = 1">
                    <xsl:choose>
                        <xsl:when
                            test="(matches(tekst:LidNummer, '\d{1,2}\.')) or (matches(tekst:LidNummer, '\d{1,2}[az]{1}\.'))">
                            <xsl:if test="matches(tekst:LidNummer, '\d{1,2}\.')">
                                <xsl:if
                                    test="not(string(tekst:LidNummer) = '1.')">
                                    <xsl:value-of select="concat(string(tekst:LidNummer), ', ')"/>
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="matches(tekst:LidNummer, '\d{1,2}[az]{1}\.')">
                                <xsl:variable name="first" select="tokenize(tekst:LidNummer, '[az]{1}')[1]"/>
                                <xsl:if
                                    test="not(string($first) = string(1))">
                                    <xsl:value-of select="concat(string(tekst:LidNummer), ', ')"/>
                                </xsl:if>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat(string(tekst:LidNummer), ', ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0800================================================================================================================ -->
    
    <sch:pattern id="TPOD_0800">
        <sch:rule context="//tekst:Artikel">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="artikel" value="string(tekst:Kop/tekst:Nummer)"/>
            <sch:let name="fouten" value="foo:foutenTPOD_0800(.)">
            </sch:let>
            <sch:let name="CONDITION" value="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0800: Achter het lidnummer moet een punt worden opgenomen. 
                (betreft artikel: <sch:value-of select="$artikel"/>, lidnummers: <sch:value-of select="substring($fouten,1,string-length($fouten)-2)"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:foutenTPOD_0800">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Lid">
                <xsl:if test="not(ends-with(tekst:LidNummer, '.'))">
                    <xsl:value-of select="concat(string(tekst:LidNummer),', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$volgorde"/>
    </xsl:function>
    
    <!-- ============TPOD_0810================================================================================================================ -->
    
    <sch:pattern id="TPOD_0810">
        <sch:rule context="//tekst:Lijst">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="name(*[1])='Lijstaanhef'"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0810: Een Lijst wordt altijd voorafgegaan door een inleidende tekst, oftewel de Lijstaanhef.
                Betreft: Lijst met wId: <sch:value-of select="string(./@wId)"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0820================================================================================================================ -->
    
    <sch:pattern id="TPOD_0820">
        <sch:rule context="//tekst:Lijst">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="ancestorsFout" value="foo:lijstAncestorsTPOD_0820(.)">
            </sch:let>
            <sch:let name="CONDITION" value="string-length($ancestorsFout) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0820: <sch:value-of select="$ancestorsFout"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:lijstAncestorsTPOD_0820">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="fout">
            <xsl:variable name="ancestors" select="count($context/ancestor-or-self::tekst:Lijst)"/>
            <xsl:if test="$ancestors > 3">
                <xsl:variable name="lid" select="$context/ancestor::tekst:Lid"/>
                <xsl:variable name="bijlage" select="$context/ancestor::tekst:Bijlage"/>
                <xsl:choose>
                    <xsl:when test="$lid">
                        <xsl:value-of select="concat('In artikel ',$lid/ancestor::tekst:Artikel/tekst:Kop/tekst:Nummer,', lid ',$lid/tekst:LidNummer/text(),' is een lijst met ',string($ancestors), ' niveaus, niet meer dan 3 is toegestaan.')"/>
                    </xsl:when>
                    <xsl:when test="$bijlage">
                        <xsl:value-of select="concat('In bijlage ',$context/ancestor::tekst:Bijlage/tekst:Kop/tekst:Nummer,' is een lijst met ',string($ancestors), ' niveaus, niet meer dan 3 is toegestaan.')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat('In artikel ',$context/ancestor::tekst:Artikel/tekst:Kop/tekst:Nummer,' is een lijst met ',string($ancestors), ' niveaus, niet meer dan 3 is toegestaan.')"/>    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$fout"/>
    </xsl:function>
    
    <!-- ============TPOD_0830_0831================================================================================================================ -->
    
    <sch:pattern id="TPOD_0830_0831">
        <sch:rule context="//tekst:Lijst">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $WV"/>
            <sch:let name="ancestorsFout" value="foo:checkEersteNiveauLijstLettersTPOD_0830(.)"> </sch:let>
            <sch:let name="CONDITION" value="string-length($ancestorsFout) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> TPOD_0830/0831:
                <sch:value-of select="$ancestorsFout"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkEersteNiveauLijstLettersTPOD_0830">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="fout">
            <xsl:variable name="ancestors" select="count($context/ancestor-or-self::tekst:Lijst)"/>
            <xsl:if test="$ancestors = 1">
                <xsl:variable name="found">
                    <xsl:for-each select="$context/tekst:Li">
                        <xsl:if test="not(matches(tekst:LiNummer, '[a-z]{1}\.')) and not(matches(tekst:LiNummer, '[a-z]{1}'))">
                            <xsl:value-of select="concat(tekst:LiNummer, ', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:if test="string-length($found)>0">
                    <xsl:variable name="lid" select="$context/ancestor::tekst:Lid"/>
                    <xsl:variable name="bijlage" select="$context/ancestor::tekst:Bijlage"/>
                    <xsl:choose>
                        <xsl:when test="$lid">
                            <xsl:value-of
                                select="concat('In lijst (op het eerste niveau) in artikel ', $lid/ancestor::tekst:Artikel/tekst:Kop/tekst:Nummer, ', lid ', $lid/tekst:LidNummer/text(), ' moeten onderdelen op het eerste niveau worden aangegeven met letters. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:when>
                        <xsl:when test="$bijlage">
                            <xsl:value-of
                                select="concat('In lijst (op het eerste niveau) in bijlage ', $context/ancestor::tekst:Bijlage/tekst:Kop/tekst:Nummer, ' moeten onderdelen op het eerste niveau worden aangegeven met letters. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="concat('In lijst (op het eerste niveau) in artikel ', $context/ancestor::tekst:Artikel/tekst:Kop/tekst:Nummer, ' moeten onderdelen op het eerste niveau worden aangegeven met letters. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$fout"/>
    </xsl:function>
    
    <!-- ============================================================================================================================ -->
    
    <sch:pattern id="TPOD_0840_0841">
        <sch:rule context="//tekst:Lijst">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $WV"/>
            <sch:let name="ancestorsFout" value="foo:checkEersteNiveauLijstLettersTPOD_0840(.)"> </sch:let>
            <sch:let name="CONDITION" value="string-length($ancestorsFout) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> TPOD_0840/0841:
                <sch:value-of select="$ancestorsFout"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkEersteNiveauLijstLettersTPOD_0840">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="fout">
            <xsl:variable name="ancestors" select="count($context/ancestor-or-self::tekst:Lijst)"/>
            <xsl:if test="$ancestors = 2">
                <xsl:variable name="found">
                    <xsl:for-each select="$context/tekst:Li">
                        <xsl:if test="not(matches(tekst:LiNummer, '[0-9]{1,2}\.')) and not(matches(tekst:LiNummer, '[0-9]{1,2}'))">
                            <xsl:value-of select="concat(tekst:LiNummer, ', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:if test="string-length($found)>0">
                    <xsl:variable name="lid" select="$context/ancestor::tekst:Lid"/>
                    <xsl:variable name="bijlage" select="$context/ancestor::tekst:Bijlage"/>
                    <xsl:choose>
                        <xsl:when test="$lid">
                            <xsl:value-of
                                select="concat('In lijst (op het tweede niveau) in artikel ', $lid/ancestor::tekst:Artikel/tekst:Kop/tekst:Nummer, ', lid ', $lid/tekst:LidNummer/text(), ' moeten onderdelen worden aangegeven met cijfers. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:when>
                        <xsl:when test="$bijlage">
                            <xsl:value-of
                                select="concat('In lijst (op het tweede niveau) in bijlage ', $context/ancestor::tekst:Bijlage/tekst:Kop/tekst:Nummer, ' moeten onderdelen worden aangegeven met cijfers. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="concat('In lijst (op het tweede niveau) in artikel ', $context/ancestor::tekst:Artikel/tekst:Kop/tekst:Nummer, ' moeten onderdelen worden aangegeven met cijfers. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$fout"/>
    </xsl:function>
    
    <!-- ============TPOD_0850_0851================================================================================================================ -->
    
    <sch:pattern id="TPOD_0850_0851">
        <sch:rule context="//tekst:Lijst">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $WV"/>
            <sch:let name="ancestorsFout" value="foo:checkDerdeNiveauLijstCijfersTPOD_0850(.)"> </sch:let>
            <sch:let name="CONDITION" value="string-length($ancestorsFout) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> TPOD_0850/0851:
                <sch:value-of select="$ancestorsFout"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkDerdeNiveauLijstCijfersTPOD_0850">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="fout">
            <xsl:variable name="ancestors" select="count($context/ancestor-or-self::tekst:Lijst)"/>
            <xsl:if test="$ancestors = 3">
                <xsl:variable name="found">
                    <xsl:for-each select="$context/tekst:Li">
                        <xsl:if test="not(matches(tekst:LiNummer, '[0-9]{1,2}\.')) and not(matches(tekst:LiNummer, '[0-9]{1,2}'))">
                            <xsl:value-of select="concat(tekst:LiNummer, ', ')"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:if test="string-length($found)>0">
                    <xsl:variable name="lid" select="$context/ancestor::tekst:Lid"/>
                    <xsl:variable name="bijlage" select="$context/ancestor::tekst:Bijlage"/>
                    <xsl:choose>
                        <xsl:when test="$lid">
                            <xsl:value-of
                                select="concat('In lijst (op het derde niveau) in artikel ', $lid/ancestor::tekst:Artikel/tekst:Kop/tekst:Nummer, ', lid ', $lid/tekst:LidNummer/text(), ' moeten onderdelen worden aangegeven met cijfers. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:when>
                        <xsl:when test="$bijlage">
                            <xsl:value-of
                                select="concat('In lijst (op het derde niveau) in bijlage ', $context/ancestor::tekst:Bijlage/tekst:Kop/tekst:Nummer, ' moeten onderdelen worden aangegeven met cijfers. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="concat('In lijst (op het derde niveau) in artikel ', $context/ancestor::tekst:Artikel/tekst:Kop/tekst:Nummer, ' moeten onderdelen worden aangegeven met cijfers. (', substring($found,1,string-length($found)-2), ')')"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$fout"/>
    </xsl:function>
    
    <!-- ============TPOD_0880================================================================================================================ -->
    
    <sch:pattern id="TPOD880">
        <sch:rule context="//tekst:Hoofdstuk/tekst:Kop[string(tekst:Nummer) = '1']">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION"
                value="(lower-case(tekst:Label/text()) = 'hoofdstuk') and (lower-case(tekst:Opschrift/text()) = 'algemene bepalingen')"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD880: Een OW-besluit moet minimaal één hoofdstuk 1 bevatten met het opschrift Algemene bepalingen.
                (opschrift is hier: "<sch:value-of select="tekst:Opschrift/text()"/>")
            </sch:assert>
        </sch:rule>
        <sch:rule context="//tekst:Lichaam">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="hoofdstuk1" value="foo:hoofdstuk1TPOD_0880(.)" />
            <sch:let name="CONDITION" value="$hoofdstuk1=1 or $hoofdstuk1=-1"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD880: Een OW-besluit moet minimaal één hoofdstuk 1 bevatten met het opschrift Algemene bepalingen. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:hoofdstuk1TPOD_0880">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="hoofdstuk1">
            <xsl:choose>
                <xsl:when test="$context/tekst:Hoofdstuk/tekst:Kop">
                    <xsl:value-of select="0"/>
                    <xsl:for-each select="$context/tekst:Hoofdstuk/tekst:Kop">
                        <xsl:if test="string(tekst:Nummer) = '1'">
                            <xsl:value-of select="tekst:Nummer"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="-1"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$hoofdstuk1"/>
    </xsl:function>
    
    <!-- ============TPOD_0930================================================================================================================ -->
    
    <sch:pattern id="TPOD_0930">
        <sch:rule context="//basisgeo:geometrie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="fout" value="foo:aantalTPOD_0930(.)"/>
            <sch:let name="CONDITION" value="string-length($fout) = 0"/>
            <sch:let name="ASSERT" value="($APPLICABLE and $CONDITION) or not($APPLICABLE)"/>
            <sch:assert test="$ASSERT"><sch:value-of select="$fout"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:aantalTPOD_0930">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="fout">
            <xsl:for-each select="$context/*">
                <xsl:variable name="srsName" select="string(./@srsName)"/>
                <xsl:choose>
                    <xsl:when test="tokenize(string(./@srsName), ':')[last()] = '28992'">
                        <xsl:variable name="fouteCoord" select="foo:fouteCoordTPOD_0930(., 3)"/>
                        <xsl:value-of
                            select="concat(' TP0D0930: EPSG:28992 (=RD new), coördinaten in meters, maximaal 3 decimalen. gml:id=',./@gml:id,', coördinaten: ',
                            concat(substring(substring($fouteCoord, 1, string-length($fouteCoord) - 2), 0, 50), '.....'))"/>
                    </xsl:when>
                    <xsl:when test="tokenize(string(./@srsName), ':')[last()] = '4258'">
                        <xsl:variable name="fouteCoord" select="foo:fouteCoordTPOD_0930(., 8)"/>
                        <xsl:value-of
                            select="
                            concat(' TP0D0930: EPSG:4258 (=ETRS89) coördinaten in graden, maximaal 8 decimalen. gml:id=',./@gml:id,', coördinaten: ',
                            concat(substring(substring($fouteCoord, 1, string-length($fouteCoord) - 2), 0, 50), '.....'))"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$fout"/>
    </xsl:function>
    
    <xsl:function name="foo:fouteCoordTPOD_0930">
        <xsl:param name="context" as="node()"/>
        <xsl:param name="aantal" as="xs:integer"/>
        <xsl:variable name="fouteCoord">
            <xsl:for-each select="$context/descendant::gml:posList">
                <xsl:variable name="coordinaten" select="tokenize(normalize-space(text()), ' ')"/>
                <xsl:for-each select="$coordinaten">
                    <xsl:if test="string-length(substring-after(., '.')) &gt; $aantal">
                        <xsl:value-of select="concat(., ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$fouteCoord"/>
    </xsl:function>
    
    
    <!-- ============TPOD_0940================================================================================================================ -->    
    
    <sch:pattern id="TPOD_0940">
        <sch:rule
            context="/geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie/geo:geometrie">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="crs" value="foo:crsTPOD_0940(.)"/>
            <sch:let name="crsses" value="foo:crssesTPOD_0940($crs, .)"/>
            <sch:let name="CONDITION" value="string-length($crsses) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                TPOD940: Een geometrie moet zijn
                opgebouwd middels één coordinate reference system (crs): EPSG:28992 (=RD new) of
                EPSG:4258 (=ETRS89). Id=<sch:value-of select="parent::*/geo:id"/>: </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:crsTPOD_0940">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="crs">
            <xsl:for-each select="$context/descendant-or-self::*/@srsName">
                <xsl:if test="position() = 1">
                    <xsl:value-of select="."/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$crs"/>
    </xsl:function>
    
    <xsl:function name="foo:crssesTPOD_0940">
        <xsl:param name="crs"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="crsses">
            <xsl:for-each select="$context/descendant-or-self::*/@srsName">
                <xsl:if test="not($crs = .)">
                    <xsl:value-of select="concat(., ', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$crsses"/>
    </xsl:function>
    
    <!-- ============TPOD_0980======================================================================================================= -->
    
    <sch:pattern id="TPOD_0980">
        <sch:rule context="//tekst:Hoofdstuk[tekst:Kop/tekst:Nummer/text() eq '1']">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="string-length(foo:opschriftTPOD0980(.)) > 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> TPOD_0980: Een
                OW-besluit moet minimaal één hoofdstuk 1 bevatten met artikel met opschrift
                Begripsbepaling. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:opschriftTPOD0980">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context/descendant::tekst:Artikel">
            <xsl:if test="lower-case(tekst:Kop/tekst:Opschrift/text()) = 'begripsbepalingen'">
                <xsl:value-of select="tekst:Kop/tekst:Opschrift/text()"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_1000================================================================================================================ -->
    
    <sch:pattern id="TPOD_1000">
        <sch:rule context="//tekst:Begrip">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="items"
                value="foo:checkBegripTPOD1000(.)"/>
            <sch:let name="CONDITION"
                value="string-length($items)=0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1000_1050: Een Begrip moet bestaan uit één term en één definitie. 
                Begrip met wId: <sch:value-of select="string(@wId)"/> bevat geen <sch:value-of select="$items"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkBegripTPOD1000">
        <xsl:param name="context" as="node()"/>
        <xsl:choose>
            <xsl:when  test="not($context/tekst:Term) and not($context/tekst:Definitie)">
                <xsl:value-of select="'Term en Definitie'"/>
            </xsl:when>
            <xsl:when  test="not($context/tekst:Term)">
                <xsl:value-of select="'Term'"/>
            </xsl:when>
            <xsl:when  test="not($context/tekst:Definitie)">
                <xsl:value-of select="'Definitie'"/>
            </xsl:when>
        </xsl:choose>
        
    </xsl:function>
        
    <!-- ============TPOD_1010================================================================================================================ -->
    
    <sch:pattern id="TPOD_1010">
        <sch:rule context="//tekst:Begrippenlijst">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="items"
                value="foo:checkBegripTPOD1010(.)"/>
            <sch:let name="CONDITION"
                value="string-length($items)=0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1010_1060: Een Begriplijst moet gesorteerd zijn, 
                de Begrippenlijst met wId: "<sch:value-of select="$items"/>" is dat niet</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkBegripTPOD1010">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="list">
            <xsl:for-each select="$context/tekst:Begrip">
                <xsl:value-of select="tekst:Term"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="sortedList">
            <xsl:for-each select="$context/tekst:Begrip">
                <xsl:sort select="tekst:Term"/>
                <xsl:value-of select="tekst:Term"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="not($sortedList=$list)">
            <xsl:value-of select="string($context/@wId)"/>            
        </xsl:if>
    </xsl:function>
    
    <!-- ============TPOD_1020-1070================================================================================================================ -->
    
    <sch:pattern id="TPOD_1020-1070">
        <sch:rule context="//tekst:Begrippenlijst[tekst:Begrip/tekst:LiNummer]">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="CONDITION"
                value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1020-1070: Begrippen mogen niet worden genummerd, 
                de Begrippenlijst met wId: "<sch:value-of select="@wId"/>" is dat wel</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1310================================================================================================================ -->
    
    <sch:pattern id="TPOD_1310">
        <sch:rule context="//l:Gebied/l:hoogte[string(da:eenheid) ne 'http://standaarden.omgevingswet.overheid.nl/eenheid/id/concept/Meter_Eenheid']">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1310: De grootheid waarin de hoogte wordt uitgedrukt; in het geval van hoogte dient altijd de eenheid meter gekozen te worden. 
                Dit is niet zo in Gebied: <sch:value-of select="../l:identificatie"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1440================================================================================================================ -->
    
    <sch:pattern id="TPOD_1440">
        <sch:rule context="//ga:Gebiedsaanwijzing[string(ga:type) eq 'http://standaarden.omgevingswet.overheid.nl/typegebiedsaanwijzing/id/concept/Beperkingengebied']">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="foo:zoekJuridischeRegelTerugTPOD_1440(.)='RegelVoorIedereen'"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1440: Als het type gebiedsaanwijzing gelijk is aan beperkingengebied, dan mag deze alleen gerelateerd zijn aan een RegelVoorIedereen.
                Dit is niet zo voor Gebiedsaanwijzing: <sch:value-of select="ga:identificatie"/> </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:zoekJuridischeRegelTerugTPOD_1440">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$xmlDocuments//ow-dc:owObject/*">
            <xsl:if test="string(r:gebiedsaanwijzing/ga-ref:GebiedsaanwijzingRef/@xlink:href)=$context/ga:identificatie/text()">
                <xsl:if test="not(local-name(.)='RegelVoorIedereen')">
                    <xsl:value-of select="local-name(.)"/>
                </xsl:if>
            </xsl:if>    
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_1650================================================================================================================ -->
    
    <sch:pattern id="TPOD_1650">
        <sch:rule
            context="//(rol:Omgevingswaarde|rol:Omgevingsnorm)/rol:normwaarde/rol:Normwaarde">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="
                (rol:kwantitatieveWaarde or rol:kwalitatieveWaarde or rol:waardeInRegeltekst) 
                and
                not((rol:kwantitatieveWaarde and rol:kwalitatieveWaarde)
                or
                (rol:waardeInRegeltekst and rol:kwalitatieveWaarde)
                or
                (rol:kwantitatieveWaarde and rol:waardeInRegeltekst)
                or
                (rol:kwantitatieveWaarde and rol:waardeInRegeltekst and rol:kwalitatieveWaarde))
                "/>
            <sch:assert
                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1650: <sch:value-of select="../../rol:identificatie"/>: Het attribuut 'normwaarde'
                moet bestaan uit één van de drie mogelijke attributen; 'kwalitatieveWaarde' óf
                'kwantitatieveWaarde' óf waardeInRegeltekst. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1660================================================================================================================ -->
    
    <sch:pattern id="TPOD_1660">
        <sch:rule context="//ga:Gebiedsaanwijzing[string(ga:type) eq 'http://standaarden.omgevingswet.overheid.nl/typegebiedsaanwijzing/id/concept/Functie']">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION" value="foo:zoekJuridischeRegelTerugTPOD_1660(.)='RegelVoorIedereen'"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1440: Als het type gebiedsaanwijzing gelijk is aan beperkingengebied, dan mag deze alleen gerelateerd zijn aan een RegelVoorIedereen.
                Dit is niet zo voor Gebiedsaanwijzing: <sch:value-of select="ga:identificatie"/> </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:zoekJuridischeRegelTerugTPOD_1660">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$xmlDocuments//ow-dc:owObject/*">
            <xsl:if test="string(r:gebiedsaanwijzing/ga-ref:GebiedsaanwijzingRef/@xlink:href)=$context/ga:identificatie/text()">
                <xsl:if test="not(local-name(.)='RegelVoorIedereen')">
                    <xsl:value-of select="local-name(.)"/>
                </xsl:if>
            </xsl:if>    
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_1700================================================================================================================ -->
    
    <sch:pattern id="TPOD_1700">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="activiteitenLijst" value="foo:activiteitenLijstTPOD_1700()"/>
            <sch:let name="bovenLiggend"
                value="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
            <sch:let name="identificatie" value="rol:identificatie"/>
            <sch:let name="circulaireActivititeiten" value="foo:circulaireActiviteitenAanzetTPOD_1700($activiteitenLijst, $bovenLiggend, $identificatie, $identificatie)"/>
            <sch:let name="identificatie" value="rol:identificatie"/>
            <sch:let name="lokaalBovenliggend"
                value="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
            <sch:let name="activiteitenTrajectNaarFunctioneleStructuur" value="foo:activiteitenTrajectNaarFunctioneleStructuurTPOD_1700($circulaireActivititeiten, $activiteitenLijst, $identificatie, $lokaalBovenliggend)"/>
            <sch:let name="CONDITION"
                value="string-length($activiteitenTrajectNaarFunctioneleStructuur) > 0"/>
            <sch:report test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                REPORT: H:TPOD1700:
                Activiteit-ids: <sch:value-of select="substring($activiteitenTrajectNaarFunctioneleStructuur,1,string-length($activiteitenTrajectNaarFunctioneleStructuur)-2)"/>: 
                Voor elke hiërarchie van nieuwe activiteiten geldt dat de hoogste activiteit in
                de hiërarchie een bovenliggende activiteit moet hebben die reeds bestaat in de
                functionele structuur. DIT LAATSTE WORDT NU NOG NIET GETEST!</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:activiteitenTrajectNaarFunctioneleStructuurTPOD_1700">
        <xsl:param name="circulaireActivititeiten"/>
        <xsl:param name="activiteitenLijst"/>
        <xsl:param name="identificatie" as="xs:string"/>
        <xsl:param name="lokaalBovenliggend" as="xs:string"/>
        <xsl:variable name="activiteitenTrajectNaarFunctioneleStructuur">
            <xsl:if test="not(contains($circulaireActivititeiten, $identificatie))">
                <xsl:choose>
                    <xsl:when test="not(contains($activiteitenLijst, $lokaalBovenliggend))">
                        <xsl:value-of select="concat($identificatie, ', ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of
                            select="foo:activiteitenPadTPOD_1700($identificatie, $lokaalBovenliggend, $activiteitenLijst)"
                        />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$activiteitenTrajectNaarFunctioneleStructuur"/>
    </xsl:function>
    
    <xsl:function name="foo:circulaireActiviteitenAanzetTPOD_1700">
        <xsl:param name="activiteitenLijstForContains"/>
        <xsl:param name="bovenLiggendForContains" as="xs:string"/>
        <xsl:param name="identificatie" as="xs:string"/>
        <xsl:param name="bovenLiggend" as="xs:string"/>
        <xsl:variable name="circulaireActiviteitenAanzet">
            <xsl:if test="contains($activiteitenLijstForContains, $bovenLiggendForContains)">
                <xsl:value-of
                    select="foo:circulaireActiviteitenTPOD_1700($identificatie, $bovenLiggend)"
                />
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$circulaireActiviteitenAanzet"/>
    </xsl:function>
    
    <xsl:function name="foo:circulaireActiviteitenTPOD_1700">
        <xsl:param name="identificatie" as="xs:string"/>
        <xsl:param name="bovenLiggend" as="xs:string"/>
        <xsl:variable name="circulaireActiviteiten">
            <xsl:for-each
                select="$xmlDocuments/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
                <xsl:if
                    test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $bovenLiggend">
                    <xsl:variable name="lokaalBovenliggend" select="rol:identificatie"/>
                    <xsl:choose>
                        <xsl:when test="$identificatie = $lokaalBovenliggend">
                            <xsl:value-of select="concat($lokaalBovenliggend, ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="foo:circulaireActiviteitenTPOD_1700($identificatie, $lokaalBovenliggend)"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$circulaireActiviteiten"/>
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
    
    <xsl:function name="foo:activiteitenPadTPOD_1700">
        <xsl:param name="identificatie" as="xs:string"/>
        <xsl:param name="bovenliggend" as="xs:string"/>
        <xsl:param name="activiteitenLijst" as="xs:string*"/>
        <xsl:variable name="activiteitenPad">
            <xsl:for-each
                select="$xmlDocuments/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
                <xsl:if test="rol:identificatie = $bovenliggend">
                    <xsl:variable name="lokaalBovenliggend"
                        select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                    <xsl:choose>
                        <xsl:when test="not(contains($activiteitenLijst, $lokaalBovenliggend))">
                            <xsl:value-of select="concat($identificatie, ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="foo:activiteitenPadTPOD_1700($identificatie, $lokaalBovenliggend, $activiteitenLijst)"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$activiteitenPad"/>
    </xsl:function>
    
    <!-- ============TPOD_1710================================================================================================================ -->
    
    <sch:pattern id="TPOD_1710">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="activiteitenLijst" value="foo:activiteitenLijstTPOD_1710()"/>
            <sch:let name="circulaireActivititeiten"
                value="foo:circulaireActivititeitenTPOD_1710(., $activiteitenLijst)"/>
            <!-- TPOD1710  -->
            <sch:let name="CONDITION" value="string-length($circulaireActivititeiten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                TPOD1710: Activiteit-ids: <sch:value-of select="substring($circulaireActivititeiten,1,string-length($circulaireActivititeiten)-2)"/>: Een
                bovenliggende activiteit mag niet naar een activiteit verwijzen die lager in de hiërarchie ligt.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:circulaireActivititeitenTPOD_1710">
        <xsl:param name="context" as="node()"/>
        <xsl:param name="activiteitenLijst"/>
        <xsl:variable name="circulaireActivititeiten">
            <xsl:variable name="bovenLiggend"
                select="string($context/rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href)"/>
            <xsl:variable name="identificatie" select="$context/rol:identificatie/text()"/>
            <!-- hier worden de activiteiten uitgefilterd waarvan de bovenliggende activiteiten in de functionele structuur zitten -->
            <xsl:if test="contains($activiteitenLijst, $bovenLiggend)">
                <xsl:value-of
                    select="foo:selecteerCirculaireActiviteitenTPOD_1710($identificatie, $identificatie, $context)"
                />
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$circulaireActivititeiten"/>
    </xsl:function>
    
    <xsl:function name="foo:selecteerCirculaireActiviteitenTPOD_1710">
        <xsl:param name="identificatie" as="xs:string"/>
        <xsl:param name="bovenliggend" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="selecteerCirculaireActiviteiten">
            <xsl:for-each
                select="$xmlDocuments/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
                <xsl:if
                    test="string(rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href) = $bovenliggend">
                    <xsl:variable name="lokaalBovenliggend" select="rol:identificatie/text()"/>
                    <xsl:choose>
                        <xsl:when test="$identificatie = $lokaalBovenliggend">
                            <xsl:value-of select="concat($lokaalBovenliggend, ', ')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="foo:selecteerCirculaireActiviteitenTPOD_1710($identificatie, $lokaalBovenliggend, $context)"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$selecteerCirculaireActiviteiten"/>
    </xsl:function>
        
    <xsl:function name="foo:activiteitenLijstTPOD_1710">
        <xsl:variable name="activiteitenLijst">
            <xsl:for-each
                select="$xmlDocuments/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
                <xsl:value-of select="rol:identificatie/text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$activiteitenLijst"/>
    </xsl:function>
    
    <!-- ============TPOD_1730================================================================================================================ -->
    
    <sch:pattern id="TPOD_1730">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="activiteitenLijst" value="foo:activiteitenLijstTPOD_1730()"/>
            <!-- TPOD1730  -->
            <sch:let name="CONDITION" value="contains($activiteitenLijst, rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef/@xlink:href)"/>
            <sch:assert
                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                TPOD_1730: <sch:value-of select="rol:identificatie"/> 
                Betreft verwijzing: <sch:value-of select="rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>:
                Gerelateerde activiteiten moeten bestaan indien er naar verwezen wordt.</sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <xsl:function name="foo:activiteitenLijstTPOD_1730">
        <xsl:variable name="activiteitenLijst">
            <xsl:for-each
                select="$xmlDocuments/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
                <xsl:value-of select="rol:identificatie/text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$activiteitenLijst"/>
    </xsl:function>
    
    <!-- ============TPOD_1740================================================================================================================ -->
    
    <sch:pattern id="TPOD_1740">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="activiteitenLijst" value="foo:activiteitenLijstTPOD_1740()"/>
            
            <!-- TPOD1740  -->
            <sch:let name="CONDITION" value="not(contains($activiteitenLijst, rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href))"/>
            <sch:report
                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                REPORT: TPOD1740: <sch:value-of select="rol:identificatie"/>: Betreft verwijzing: <sch:value-of select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>:
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
    
    <!-- ============TPOD_1750================================================================================================================ -->
    
    <sch:pattern id="TPOD_1750">
        <sch:rule
            context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION"
                value="
                contains(rol:locatieaanduiding/l-ref:LocatieRef/@xlink:href, '.gebiedengroep.') or contains(rol:locatieaanduiding/l-ref:LocatieRef/@xlink:href, '.gebied.')
                or
                contains(rol:locatieaanduiding/l-ref:GebiedRef/@xlink:href, '.gebiedengroep.') or contains(rol:locatieaanduiding/l-ref:GebiedRef/@xlink:href, '.gebied.')
                "/>    
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1750: Betreft <sch:value-of select="rol:identificatie"
                />: Een gebiedsaanwijzing moet een gebied of gebiedengroep zijn (en mag geen punt,
                puntengroep, lijn of lijnengroep zijn). </sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- ============TPOD_1760================================================================================================================ -->
    
    <sch:pattern id="TPOD_1760">
        <sch:rule
            context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/ga:Gebiedsaanwijzing">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION"
                value="
                contains(ga:locatieaanduiding/l-ref:LocatieRef/@xlink:href, '.gebiedengroep.') or contains(ga:locatieaanduiding/l-ref:LocatieRef/@xlink:href, '.gebied.')
                or
                contains(ga:locatieaanduiding/l-ref:GebiedRef/@xlink:href, '.gebiedengroep.') or contains(ga:locatieaanduiding/l-ref:GebiedRef/@xlink:href, '.gebied.')                
                "/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1760: Betreft <sch:value-of select="ga:identificatie"
                />: Een gebiedsaanwijzing moet een gebied of gebiedengroep zijn (en mag geen punt,
                puntengroep, lijn of lijnengroep zijn). </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1780================================================================================================================ -->
    
    <sch:pattern id="TPOD_1780">
        <sch:rule
            context="/stop:AanleveringBesluit">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="CONDITION"
                value="count(//tekst:Hoofdstuk/descendant::tekst:Artikel)>0"/>    
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1780: Een omgevingsdocument met een artikelstructuur moet bestaan uit tenminste een hoofdstuk en een artikel. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1830================================================================================================================ -->    
    
    <sch:pattern id="TPOD1830">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/ga:Gebiedsaanwijzing/ga:type">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR"/>
            <sch:let name="CONDITION" value="not(text()='http://standaarden.omgevingswet.overheid.nl/typegebiedsaanwijzing/id/concept/Functie')"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                TPOD1830: Binnen het object ‘Gebiedsaanwijzing’ in AMvB/MR is de waarde ‘Functie’ van attribuut ‘type’
                (datatype TypeGebiedsaanwijzing) niet toegestaan. Het object waarom het
                gaat: <sch:value-of select="../ga:identificatie/text()"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1840================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1840">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/ga:Gebiedsaanwijzing/ga:type">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR"/>
            <sch:let name="CONDITION" value="not(text()='http://standaarden.omgevingswet.overheid.nl/typegebiedsaanwijzing/id/concept/Beperkingengebied')"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                H:TPOD1840: Binnen het object ‘Gebiedsaanwijzing’ is de waarde ‘beperkingengebied’ van attribuut ‘type’
                (datatype TypeGebiedsaanwijzing) niet toegestaan. Het object waarom het
                gaat: <sch:value-of select="../ga:identificatie/text()"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1860================================================================================================================ -->
    
    <sch:pattern id="TPOD_1860">
        <sch:rule context="//r:Regeltekst">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="CONDITION"
                value="not(r:gerelateerdeRegeltekst/r-ref:RegeltekstRef/@xlink:href eq r:identificatie)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1860: Betreft <sch:value-of select="name()"/>:
                <sch:value-of select="r:identificatie"/>: Iedere verwijzing naar een ander
                OwObject moet een bestaand (ander) OwObject zijn. (gerelateerdeRegeltekst verwijst
                naar zichzelf) </sch:assert>
        </sch:rule>
        <sch:rule context="//rol:Activiteit">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION"
                value="not(rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef/@xlink:href eq rol:identificatie)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1860: Betreft <sch:value-of select="name()"/>:
                <sch:value-of select="rol:identificatie"/>: Iedere verwijzing naar een ander
                OwObject moet een bestaand (ander) OwObject zijn. (gerelateerdeActiviteit verwijst
                naar zichzelf) </sch:assert>
        </sch:rule>
        <sch:rule context="//r:artikelOfLid/r-ref:RegeltekstRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//r:Regeltekst/r:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>,
                <sch:value-of select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject
                moet een bestaand (ander) OwObject zijn. (r:Regeltekst/r:identificatie niet aangetroffen) </sch:assert>
        </sch:rule>
        <sch:rule context="//@rkow:regeltekstId">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//r:Regeltekst/r:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',.,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1860: Betreft <sch:value-of select="name()"/>:
                <sch:value-of select="."/>: Iedere verwijzing naar een ander OwObject
                moet een bestaand (ander) OwObject zijn. (r:Regeltekst/r:identificatie niet aangetroffen) </sch:assert>
        </sch:rule>
        <sch:rule context="//r:RegelVoorIedereen/r:activiteitaanduiding/rol-ref:ActiviteitRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Activiteit/rol:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>,
                <sch:value-of select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject
                moet een bestaand (ander) OwObject zijn. (rol:Activiteit/rol:identificatie niet aangetroffen)</sch:assert>
        </sch:rule>
        <sch:rule context="//r:omgevingsnormaanduiding/rol-ref:OmgevingsnormRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Omgevingsnorm/rol:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>,
                <sch:value-of select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject
                moet een bestaand (ander) OwObject zijn. (rol:Omgevingsnorm/rol:identificatie niet aangetroffen) </sch:assert>
        </sch:rule>
        <sch:rule context="//r:gebiedsaanwijzing/ga-ref:GebiedsaanwijzingRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//ga:Gebiedsaanwijzing/ga:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>,
                <sch:value-of select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject
                moet een bestaand (ander) OwObject zijn. (ga:Gebiedsaanwijzing/ga:identificatie niet aangetroffen) </sch:assert>
        </sch:rule>
        <sch:rule context="//rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Activiteit/rol:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../rol:identificatie"/>, <sch:value-of
                    select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject moet een
                bestaand (ander) OwObject zijn. (rol:Activiteit/rol:identificatie niet aangetroffen) </sch:assert>
        </sch:rule>
        <sch:rule
            context="//l-ref:LocatieRef | l-ref:GebiedRef | l-ref:GebiedengroepRef | l-ref:PuntRef | l-ref:PuntengroepRef | l-ref:LijnengroepRef | l-ref:LijnRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="identifiers" value="foo:getLocationIdentifiersTPOD_1860()"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1860: Betreft <sch:value-of select="../../name()"/>:
                <sch:value-of select="../../*:identificatie"/>, <sch:value-of
                    select="@xlink:href"/>: Iedere verwijzing naar een ander OwObject moet een
                bestaand (ander) OwObject zijn. (verwijzing vanuit l:ref niet aangetroffen) </sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:getLocationIdentifiersTPOD_1860">
        <xsl:variable name="identifiers">
            <xsl:for-each
                select="$xmlDocuments//(l:Gebied | l:Gebiedengroep | l:Punt | l:Puntengroep | l:Lijn | l:Lijnengroep)/l:identificatie">
                <xsl:value-of select="concat('.',text(),'.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <xsl:function name="foo:getIdentifiersTPOD_1860">
        <xsl:param name="xpath" as="node()*"/>
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xpath">
                <xsl:value-of select="concat('.',text(),'.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <!-- ============TPOD_1870================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1870">
        <sch:rule context="//r:artikelOfLid">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="identifiers"
                value="foo:getRegelTekstIdentifiersTPOD_1870()"/>
            <sch:let name="CONDITION" value="contains($identifiers, r-ref:RegeltekstRef/@xlink:href)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1870: Betreft
                <sch:value-of select="../name()"/>: <sch:value-of select="../@ow:regeltekstId"/>, <sch:value-of
                    select="r-ref:RegeltekstRef/@xlink:href"/>: Een verwijzing naar ArtikelOfLid moet verwijzen naar een bestaand artikel of lid. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:getRegelTekstIdentifiersTPOD_1870">
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xmlDocuments//r:Regeltekst">
                <xsl:value-of select="r:identificatie/text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <!-- ============TPOD_1880================================================================================================================ -->
    
    <sch:pattern id="TPOD_1880">
        <sch:rule context="//rol:Omgevingswaarde">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION" value="not($SOORT_REGELING=$WV)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1880: De IMOW-objecten 'Omgevingswaarde' zijn niet van toepassing op de Waterschapsverordening.: 
                Identificatie: <sch:value-of select="rol:identificatie/text()"/>
            </sch:assert>
        </sch:rule>
        <sch:rule context="//r:Omgevingswaarderegel">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION" value="not($SOORT_REGELING=$WV)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD1880: De IMOW-objecten 'Omgevingswaarderegel' zijn niet van toepassing op de Waterschapsverordening.: 
                Regeltekst-referentie: <sch:value-of select="string(r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href)"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1890================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1890">
        <sch:rule context="//*:identificatie">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="CONDITION" value="contains(text(), concat('.', lower-case(tokenize(../name(), ':')[last()]), '.'))"/>
            <sch:assert
                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1890: Betreft <sch:value-of select="../name()"/>: <sch:value-of
                    select="text()"/>: De identificatie van het OwObject moet de naam van het OwObject-element zelf bevatten.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1910================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1910">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen/sl:objectType">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="objects" value="foo:owObjectenLijstTPOD_1910(.)"/>
            <sch:let name="CONDITION" value="contains($objects, concat('.',text(),'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                H:TPOD1910: De objecttypen in
                ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen dienen overeen te komen met
                de daadwerkelijke objecten in het betreffende Ow-bestand. Het objecttype waarom het
                gaat staan nu genoemd: <sch:value-of select="text()"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
   
    <xsl:function name="foo:owObjectenLijstTPOD_1910">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="owObjectenLijst">
            <xsl:for-each select="$context/../../../sl:stand/ow-dc:owObject/*"> 
                <xsl:value-of select="concat('.',local-name(),'.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$owObjectenLijst"/>
    </xsl:function>
    
    <!-- ============TPOD_1920================================================================================================================ -->
    
    <sch:pattern id="TPOD_1920">
        <sch:rule context="/Modules/RegelingVersie/Bestand">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="nfFOOT" value="foo:notfoundFileOrObjectTypeTPOD_1920(naam,.)"></sch:let>
            <sch:let name="CONDITION" value="string-length($nfFOOT) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD1920: De
                objecttypen in manifest-ow dienen overeen te komen met de objecttypen in het
                betreffende Ow-bestand. De objecttypen waarom het gaat staan nu genoemd:
                <sch:value-of select="$nfFOOT"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:notfoundFileOrObjectTypeTPOD_1920">
        <xsl:param name="naam"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="notfoundFileOrObjectType">
            <xsl:for-each select="$context/objecttype">
                <xsl:variable name="objecttype" select="text()"/>
                <xsl:choose>
                    <xsl:when test=". = 'Geometrie'">
                        <xsl:if test="not(document($naam)//geo:FeatureCollectionGeometrie)">
                            <xsl:value-of select="concat($naam, ': ', ., ', ')"/>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if
                            test="not(document($naam)//ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen[sl:objectType = $objecttype])">
                            <xsl:value-of select="concat($naam, ': ', ., ', ')"/>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$notfoundFileOrObjectType"/>
    </xsl:function>
    
    <!-- ============TPOD_1930================================================================================================================ -->
    
    <sch:pattern id="TPOD_1930">
        <sch:rule context="//l:Gebiedengroep/l:groepselement">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="notFound" value="foo:notFoundTPOD_1930(.)"/>
            <sch:let name="CONDITION" value="string-length($notFound) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1930: Betreft
                <sch:value-of select="../../name()"/>: <sch:value-of select="../l:identificatie"
                />, <sch:value-of select="$notFound"/>: Iedere verwijzing naar een OwObject in een
                Gebiedengroep moet een bestaand (ander) OwObject van het type Gebied zijn.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:notFoundTPOD_1930">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="notFound">
            <xsl:variable name="identifiers"
                select="foo:getIdentifiersTPOD_1930($xmlDocuments//l:Gebied/l:identificatie)"/>
            <xsl:for-each select="$context/l-ref:GebiedRef">
                <xsl:if test="not(contains($identifiers, @xlink:href))">
                    <xsl:value-of select="concat(@xlink:href, ', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$notFound"/>
    </xsl:function>
    
    <xsl:function name="foo:getIdentifiersTPOD_1930">
        <xsl:param name="xpath" as="node()*"/>
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xpath">
                <xsl:value-of select="text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <!-- ============TPOD_1940================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1940">
        <sch:rule
            context="//l:Puntengroep/l:groepselement">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="notFound" value="foo:notFoundTPOD_1940(.)"/>
            <sch:let name="CONDITION" value="string-length($notFound) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1940: Betreft <sch:value-of
                    select="../../name()"/>: <sch:value-of select="../l:identificatie"/>,
                <sch:value-of select="$notFound"/>: Iedere verwijzing naar een OwObject
                in een Puntengroep moet een bestaand (ander) OwObject van het type Punt zijn. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:notFoundTPOD_1940">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="identifiers"
            select="foo:getIdentifiersTPOD_1940($xmlDocuments//l:Punt/l:identificatie)"/>
        <xsl:variable name="notFound">
            <xsl:for-each select="$context/l-ref:PuntRef">
                <xsl:if test="not(contains($identifiers, @xlink:href))">
                    <xsl:value-of select="concat(@xlink:href, ', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$notFound"/>
    </xsl:function>
    
    <xsl:function name="foo:getIdentifiersTPOD_1940">
        <xsl:param name="xpath" as="node()*"/>
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xpath">
                <xsl:value-of select="text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <!-- ============TPOD_1950================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1950">
        <sch:rule
            context="//l:Lijnengroep/l:groepselement">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="notFound" value="foo:notFoundTPOD_1950(.)"/>
            <sch:let name="CONDITION" value="string-length($notFound) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1950: Betreft <sch:value-of
                    select="../../name()"/>: <sch:value-of select="../l:identificatie"/>,
                <sch:value-of select="$notFound"/>: Iedere verwijzing naar een OwObject
                in een Lijnengroep moet een bestaand (ander) OwObject van het type Lijn zijn. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:notFoundTPOD_1950">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="notFound">
            <xsl:variable name="identifiers"
                select="foo:getIdentifiersTPOD_1950($xmlDocuments//l:Lijn/l:identificatie)"/>
            <xsl:for-each select="$context/l-ref:LijnRef">
                <xsl:if test="not(contains($identifiers, @xlink:href))">
                    <xsl:value-of select="concat(@xlink:href, ', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$notFound"/>
    </xsl:function>
    
    <xsl:function name="foo:getIdentifiersTPOD_1950">
        <xsl:param name="xpath" as="node()*"/>
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xpath">
                <xsl:value-of select="text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <!-- ============TPOD_1960================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1960">
        <sch:rule context="//l:Lijn/l:geometrie/g-ref:GeometrieRef">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="href" value="string(@xlink:href)"/>
            <sch:let name="geometrie" value="foo:geometrieTPOD_1960($href)"/>
            <sch:let name="CONDITION" value="not($geometrie//gml:MultiPoint || $geometrie//gml:Point || $geometrie//gml:MultiSurface)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                TPOD_1960: Betreft <sch:value-of
                    select="../../name()"/>: <sch:value-of select="../../l:identificatie"/>,
                <sch:value-of select="@xlink:href"/>: Iedere verwijzing naar een gmlObject
                vanuit een Lijn moet een lijn-geometrie zijn. 
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:geometrieTPOD_1960">
        <xsl:param name="href"/>
        <xsl:for-each select="$gmlDocuments//geo:Geometrie">
            <xsl:if test="string(geo:id/text())=$href">
                <xsl:copy-of select="."/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_1970================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1970">
        <sch:rule context="//l:Punt/l:geometrie/g-ref:GeometrieRef">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="href" value="string(@xlink:href)"/>
            <sch:let name="geometrie" value="$gmlDocuments//geo:Geometrie[geo:id/text() eq $href]"/>
            <sch:let name="CONDITION" value="$geometrie//gml:MultiPoint || $geometrie//gml:Point"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                TPOD_1970: Betreft <sch:value-of
                    select="../../name()"/>: <sch:value-of select="../../l:identificatie"/>,
                <sch:value-of select="@xlink:href"/>: Iedere verwijzing naar een gmlObject
                vanuit een Punt moet een punt-geometrie zijn. 
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1980================================================================================================================ -->
    
    <sch:pattern id="TPOD_1980">
        <sch:rule context="//l:Gebied/l:geometrie/g-ref:GeometrieRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="href" value="string(@xlink:href)"/>
            <sch:let name="CONDITION" value="foo:calculateConditionTPOD_1980($href)=1"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1980: Betreft <sch:value-of select="../../name()"/>: <sch:value-of
                    select="../../l:identificatie"/>, <sch:value-of select="@xlink:href"/>: Iedere
                verwijzing naar een gmlObject vanuit een Gebied moet een gebied-geometrie zijn.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:calculateConditionTPOD_1980">
        <xsl:param name="href"/>
        <xsl:for-each select="$gmlDocuments">
            <xsl:value-of select="0"/>
            <xsl:if test="//geo:Geometrie[geo:id/text() eq $href]/geo:geometrie/gml:MultiSurface
                or
                //geo:Geometrie[geo:id/text() eq $href]/geo:geometrie/gml:Polygon
                or 
                //geo:Geometrie[geo:id/text() eq $href]/geo:geometrie/gml:Surface/gml:patches/gml:PolygonPatch">
                <xsl:value-of select="1"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_1990================================================================================================================ -->
    
    <sch:pattern id="TPOD_1990">
        <sch:rule context="//geo:Geometrie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="geoLocationGeoReferenceIdentifiers"
                value="foo:getLocationGeoReferenceIdentifiersTPOD_1990()"/>
            <sch:let name="nietGerefereerdeGeometrie"
                value="foo:nietGerefereerdeGeometrieTPOD_1990($geoLocationGeoReferenceIdentifiers, .)"/>
            <sch:let name="CONDITION" value="string-length($nietGerefereerdeGeometrie) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1990: Ieder OwObject, behalve Activiteit heeft minstens een OwObject dat ernaar verwijst.:
                <sch:value-of select="$nietGerefereerdeGeometrie" />
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="//r:Regeltekst/r:identificatie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="regeltekstReferenties"
                value="foo:getReferencesTPOD_1990(//r-ref:RegeltekstRef)"/>
            <sch:let name="nietGerefereerdeReferenties" value="foo:nietGerefereerdeReferentiesTPOD_1990($regeltekstReferenties, .)"/>
            <sch:let name="CONDITION" value="string-length($nietGerefereerdeReferenties) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1990: Ieder OwObject, behalve Activiteit heeft minstens een OwObject dat ernaar verwijst.:
                <sch:value-of select="substring($nietGerefereerdeReferenties,1,string-length($nietGerefereerdeReferenties)-2)"/>
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="//(vt:FormeleDivisie|vt:Hoofdlijn)/vt:identificatie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="formeleDivisieReferenties"
                value="foo:getReferencesTPOD_1990(//(vt-ref:FormeleDivisieRef|vt-ref:HoofdlijnRef))"/>
            <sch:let name="nietGerefereerdeReferenties" value="foo:nietGerefereerdeReferentiesTPOD_1990($formeleDivisieReferenties, .)"/>
            <sch:let name="CONDITION" value="string-length($nietGerefereerdeReferenties) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1990: Ieder OwObject, behalve Activiteit heeft minstens een OwObject dat ernaar verwijst.:
                <sch:value-of select="substring($nietGerefereerdeReferenties,1,string-length($nietGerefereerdeReferenties)-2)"/>
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="//l:identificatie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="locatieReferenties"
                value="foo:getLocationReferenceIdentifiersTPOD_1990()"/>
            <sch:let name="nietGerefereerdeReferenties">
                <xsl:if
                    test="not(contains($locatieReferenties, concat('.', text(), '.')))">
                    <xsl:value-of select="concat(string(text()), ', ')"/>
                </xsl:if>
            </sch:let>
            <sch:let name="CONDITION" value="string-length($nietGerefereerdeReferenties) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_1990: Ieder OwObject, behalve Activiteit heeft minstens een OwObject dat ernaar verwijst.:
                <sch:value-of select="substring($nietGerefereerdeReferenties,1,string-length($nietGerefereerdeReferenties)-2)"/>
            </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    
    <xsl:function name="foo:nietGerefereerdeGeometrieTPOD_1990">
        <xsl:param name="identifiers"/>
        <xsl:param name="context" as="node()"/>
        <xsl:if test="not(contains($identifiers, concat('.', string($context/geo:id/text()), '.')))">
            <xsl:value-of select="string($context/geo:id/text())"/>
        </xsl:if>
    </xsl:function>
    
    <xsl:function name="foo:nietGerefereerdeReferentiesTPOD_1990">
        <xsl:param name="referenties"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="nietGerefereerdeReferenties">
            <xsl:if
                test="not(contains($referenties, concat('.', $context/text(), '.')))">
                <xsl:value-of select="concat(string($context/text()), ', ')"/>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$nietGerefereerdeReferenties"/>
    </xsl:function>
    
    <xsl:function name="foo:getReferencesTPOD_1990">
        <xsl:param name="xpath" as="node()*"/>
        <xsl:variable name="references">
            <xsl:for-each select="$xmlDocuments//$xpath">
                <xsl:value-of select="concat('.', string(@xlink:href), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$references"/>
    </xsl:function>
    
    <xsl:function name="foo:getLocationGeoReferenceIdentifiersTPOD_1990">
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xmlDocuments//g-ref:GeometrieRef">
                <xsl:value-of select="concat('.', string(@xlink:href), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <xsl:function name="foo:getLocationReferenceIdentifiersTPOD_1990">
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xmlDocuments//(l-ref:LocatieRef|l-ref:GebiedRef|l-ref:LijnRef|l-ref:PuntRef|l-ref:GebiedengroepRef|l-ref:PuntengroepRef|l-ref:LijnengroepRef)">
                <xsl:value-of select="concat('.', string(@xlink:href), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <!-- ============TPOD_2000================================================================================================================ -->
    
    <sch:pattern id="TPOD_2000">
        <sch:rule context="//r:Regeltekst">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION" value="string-length(foo:checkWIdTPOD_2000(@wId)) > 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2000: Betreft
                <sch:value-of select="name()"/>: <sch:value-of select="@wId"/>: het wId van de
                Regeltekst in OW moet verwijzen naar een bestaande wId van een Artikel of Lid in OP
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    <xsl:function name="foo:checkWIdTPOD_2000">
        <xsl:param name="identifier"/>
        <xsl:for-each select="$xmlDocuments//(tekst:Artikel | tekst:Lid)/@wId">
            <xsl:if test="$identifier eq .">
                <xsl:value-of select="$identifier"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_2010================================================================================================================ -->
    
    <sch:pattern id="TPOD_2010">
        <sch:rule context="//r:Regeltekst | vt:FormeleDivisie">
            <sch:let name="APPLICABLE" value="not($SOORT_REGELING = '')"/>
            <sch:let name="CONDITION"
                value="string-length(foo:checkFBRWorkTPOD_2010(@wIdRegeling)) > 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2010: Betreft
                <sch:value-of select="name()"/>: <sch:value-of select="@wIdRegeling"/>: het wIdRegeling van de
                Regeltekst of FormeleDivisie in OW moet verwijzen naar een bestaande FRBRWork behorend bij Regeling in OP </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkFBRWorkTPOD_2010">
        <xsl:param name="identifier"/>
        <xsl:for-each select="$xmlDocuments//data:ExpressionIdentificatie/data:FRBRWork/text()">
            <xsl:if test="$identifier eq .">
                <xsl:value-of select="$identifier"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_2020================================================================================================================ -->
    
    <sch:pattern id="TPOD_2020">
        <sch:rule context="//Modules/RegelingVersie/FRBRwork">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION"
                value="string-length(foo:checkFBRWorkTPOD_2020(text())) > 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2020: Betreft
                <sch:value-of select="name()"/>: <sch:value-of select="text()"/>: het FRBRWork van het manifest in OW moet verwijzen naar een bestaand FRBRWork van een Regelingversie in OP </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkFBRWorkTPOD_2020">
        <xsl:param name="identifier"/>
        <xsl:for-each select="$xmlDocuments//data:ExpressionIdentificatie/data:FRBRWork/text()">
            <xsl:if test="$identifier eq .">
                <xsl:value-of select="$identifier"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_2030================================================================================================================ -->
    
    <sch:pattern id="TPOD_2030">
        <sch:rule context="//Modules/RegelingVersie/FRBRExpression">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION"
                value="string-length(foo:checkFRBRExpressionTPOD_2030(text())) > 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2030: Betreft
                <sch:value-of select="name()"/>: <sch:value-of select="text()"/>: het FRBRExpression van het manifest in OW moet verwijzen naar een bestaand FRBRExpression van een Regelingversie in OP </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkFRBRExpressionTPOD_2030">
        <xsl:param name="identifier"/>
        <xsl:for-each select="$xmlDocuments//data:ExpressionIdentificatie/data:FRBRExpression/text()">
            <xsl:if test="$identifier eq .">
                <xsl:value-of select="$identifier"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_2040================================================================================================================ -->
    
    <sch:pattern id="TPOD_2040">
        <sch:rule context="//vt:FormeleDivisie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION" value="string-length(foo:checkWIdTPOD_2040(@wId)) > 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2040: Betreft
                <sch:value-of select="name()"/>: <sch:value-of select="@wId"/>: het wId van de
                FormeleDivisie in OW moet verwijzen naar een bestaande wId van een FormeleDivisie in OP
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkWIdTPOD_2040">
        <xsl:param name="identifier"/>
        <xsl:for-each select="$xmlDocuments//tekst:FormeleDivisie/@wId">
            <xsl:if test="$identifier eq .">
                <xsl:value-of select="$identifier"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_2050================================================================================================================ -->
    
    <sch:pattern id="TPOD_2050">
        <sch:rule context="//stop:AanleveringBesluit">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="message" value="foo:existsTPOD_2050()"/>
            <sch:let name="CONDITION" value="string-length($message)=0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2050: <sch:value-of select="$message"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:existsTPOD_2050">
        <xsl:choose>
            <xsl:when test="not(document('manifest.xml')//lvbb:manifest or document('manifest-ow.xml')//Modules)">
                <xsl:value-of select="'Manifest.xml en manifest-ow.xml zijn niet aangetroffen.'"/>
            </xsl:when>
            <xsl:when test="not(document('manifest-ow.xml')//Modules)">
                <xsl:value-of select="'Manifest-ow.xml is niet aangetroffen.'"/>
            </xsl:when>
            <xsl:when test="not(document('manifest.xml')//lvbb:manifest)">
                <xsl:value-of select="'Manifest.xml is niet aangetroffen.'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="''"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- ============TPOD_2060================================================================================================================ -->
    
    <sch:pattern id="TPOD_2060">
        <sch:rule context="//tekst:Artikel">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="message" value="foo:checkFouteArtikelLidCombinatieTPOD_2060(.)"/>
            <sch:let name="CONDITION" value="string-length($message) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                H:TPOD2060:
                <sch:value-of select="$message"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkFouteArtikelLidCombinatieTPOD_2060">
        <xsl:param name="context" as="node()"/>
        <!-- Ophalen wId uit stop-bestand -->
        <xsl:variable name="artikelWiD" select="string($context/@wId)"/>
        <!-- Verzamelen alle wIds uit regelteksten (omgeven door punten om contains foutloos te kunnen doen) -->
        <xsl:variable name="wIds">
            <xsl:for-each select="$xmlDocuments//r:Regeltekst/@wId">
                <xsl:value-of select="concat('.', string(.), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <!-- Alle wids van Lid (leden) uit stop bestand en ontstane fouten verzamelen in results -->
        <xsl:variable name="results">
            <xsl:for-each select="$context/tekst:Lid">
                <!-- ophalen wId van lid -->
                <xsl:variable name="lidWiD" select="string(./@wId)"/>
                <!-- CONTROLE: Als de lijst van wIds in Regelteksten zowel het artikel nummer bevat alsmede ook een lidnummer, dan is dat fout. -->
                <xsl:if
                    test="contains($wIds, concat('.', $lidWiD, '.')) and contains($wIds, concat('.', $artikelWiD, '.'))">
                    <!-- HIER is het dus FOUT -->
                    <!-- Ophalen regeltekstId behorend bij artikelwId -->
                    <xsl:variable name="regelTekstIdArtikel" select="$xmlDocuments//r:Regeltekst[@wId=$artikelWiD]/r:identificatie"/>
                    <!-- Ophalen regeltekstId behorend bij lid-wId -->
                    <xsl:variable name="regelTekstIdLid" select="$xmlDocuments//r:Regeltekst[@wId=$lidWiD]/r:identificatie"/>
                    <!-- Het ID part van de Foutmelding wordt geconstrueerd en in Results gezet. -->
                    <xsl:value-of
                        select="concat('artikel-wId: ', $artikelWiD, ' (',$regelTekstIdArtikel,')  --&gt; lid-wId: ', $lidWiD, ' (',$regelTekstIdLid,') ')"  disable-output-escaping="no"
                    />
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="message">
            <!-- Als Results inhoud heeft (lengte) dan wordt er nog een tekst voorgevoegd en dat vormt het resultaat van de functie -->
            <xsl:if test="string-length($results) > 0">
                <xsl:value-of
                    select="
                    concat('Als een Regeltekst van een Lid is gemaakt mag er geen Regeltekst meer gemaakt worden van het artikel dat boven dit Lid hangt. Betreft: ',
                    $results)"  disable-output-escaping="no"/>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$message"/>
    </xsl:function>
    
    <!-- ============TPOD_2070================================================================================================================ -->
    
    <sch:pattern id="TPOD_2070">
        <sch:rule context="//rol:Activiteit/@ow:regeltekstId">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION" value="foo:checkOwRegeltekstIdverwijzingTPOD_2070(.)=true()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2070: Alleen v0.98 | Als de activiteit een bepaalde regeltekstID heeft dan moet deze overeenkomen met de ID die je via de Activiteit --> RegelVoorIedereen --> Regeltekst vindt.: 
                ActiviteitId: <sch:value-of select="../rol:identificatie/text()"/>, ow:regeltekstId: <sch:value-of select="string(.)"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    <xsl:function name="foo:checkOwRegeltekstIdverwijzingTPOD_2070">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="regelId" select="string($context)"/>
        <xsl:variable name="activiteitId" select="$context/../rol:identificatie/text()"/>
        <xsl:variable name="foundRegelTekst">
            <xsl:if test="not(string($regelId) = '')">
                <xsl:for-each select="$xmlDocuments//r:RegelVoorIedereen">
                    <xsl:if test="
                        string(r:activiteitaanduiding/rol-ref:ActiviteitRef/@xlink:href)=$activiteitId 
                        and 
                        string(r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href)=$regelId
                        ">
                        <xsl:value-of select="$activiteitId"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:if>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$foundRegelTekst=$activiteitId">
                <xsl:value-of select="true()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    
    
</sch:schema>
