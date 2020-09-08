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
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelingsgebied" prefix="rg"/>
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
    <sch:let name="xmlDocuments" value="collection('.?select=*.xml;recurse=yes')"/>
    <sch:let name="gmlDocuments" value="collection('.?select=*.gml;recurse=yes')"/>
    <sch:let name="SOORT_REGELING" value="$xmlDocuments//aanlevering:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>
    
    <sch:let name="AMvB" value="'/join/id/stop/regelingtype_001'"/> <!-- AMvB -->
    <sch:let name="MR" value="'/join/id/stop/regelingtype_002'"/>   <!-- Ministeriële Regeling -->
    <sch:let name="OP" value="'/join/id/stop/regelingtype_003'"/>   <!-- Omgevingsplan -->
    <sch:let name="OV" value="'/join/id/stop/regelingtype_004'"/>   <!-- Omgevingsverordening -->
    <sch:let name="WV" value="'/join/id/stop/regelingtype_005'"/>   <!-- Waterschapsverordening -->
    <sch:let name="OVi" value="'/join/id/stop/regelingtype_006'"/>   <!-- Omgevingsvisie -->
    <sch:let name="PB" value="'/join/id/stop/regelingtype_007'"/>   <!-- Projectbesluit -->
    <sch:let name="I" value="'/join/id/stop/regelingtype_008'"/>   <!-- Instructie -->
    <sch:let name="VR" value="'/join/id/stop/regelingtype_009'"/>   <!-- Voorbeschermingsregels -->
    <sch:let name="P" value="'/join/id/stop/regelingtype_010'"/>   <!-- Programma -->
    <sch:let name="RI" value="'/join/id/stop/regelingtype_011'"/>   <!-- Reactieve interventie -->
    
    <sch:let name="rijk" value="$SOORT_REGELING=$AMvB or $SOORT_REGELING=$MR"/>
    <sch:let name="omgevingsplan" value="$SOORT_REGELING=$OP"/>
    <sch:let name="omgevingsplan-en-waterschap" value="$SOORT_REGELING=$OP or $SOORT_REGELING=$WV"/>
    <sch:let name="allen" value="
        $SOORT_REGELING=$AMvB or 
        $SOORT_REGELING=$MR or 
        $SOORT_REGELING=$OP or 
        $SOORT_REGELING=$OV or 
        $SOORT_REGELING=$WV or 
        $SOORT_REGELING=$OVi or
        $SOORT_REGELING=$PB or
        $SOORT_REGELING=$I or
        $SOORT_REGELING=$VR or
        $SOORT_REGELING=$P or
        $SOORT_REGELING=$RI
        "/>
    <sch:let name="allen-behalve-rijk" value="
        $SOORT_REGELING=$OP or 
        $SOORT_REGELING=$OV or 
        $SOORT_REGELING=$WV or 
        $SOORT_REGELING=$OVi or
        $SOORT_REGELING=$PB or
        $SOORT_REGELING=$I or
        $SOORT_REGELING=$VR or
        $SOORT_REGELING=$P or
        $SOORT_REGELING=$RI
        "/>
    <sch:let name="omgevingsverordening" value="$SOORT_REGELING=$OV"/>
    <sch:let name="regelstructuur" value="
        $SOORT_REGELING=$AMvB or 
        $SOORT_REGELING=$MR or 
        $SOORT_REGELING=$OP or 
        $SOORT_REGELING=$OV or 
        $SOORT_REGELING=$WV or 
        $SOORT_REGELING=$VR
        "/>
    <sch:let name="vrijetekststructuur" value="
        $SOORT_REGELING=$OVi or
        $SOORT_REGELING=$PB or
        $SOORT_REGELING=$I or
        $SOORT_REGELING=$P or
        $SOORT_REGELING=$RI
        "/>
    <sch:let name="waterschapsverordening" value="$SOORT_REGELING=$WV"/>
    
    <!-- ============TPOD_0410================================================================================================================ -->
    
    <sch:pattern id="TPOD_0410">
        <sch:rule context="//tekst:Hoofdstuk/tekst:Kop[tekst:Label ne 'Hoofdstuk']">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:report test="false()">asa</sch:report>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0410",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="../@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een Hoofdstuk moet worden geduid met het label Hoofdstuk.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="../@eId"/>."/>"
                },
            </sch:assert> 
        </sch:rule>
    </sch:pattern>
        
    <!-- ============TPOD_0420=============================================================================================================== -->
    
    <sch:pattern id="TPOD_0420">
        <sch:rule context="//tekst:Hoofdstuk">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0420(.)">
            </sch:let>
            <sch:let name="CONDITION" value="string-length($volgorde[1]) = 0"/>
            <sch:report test="true()"><sch:value-of select="$SOORT_REGELING"/></sch:report>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0420",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Hoofdstukken moeten oplopend worden genummerd in Arabische cijfers.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0420">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context/../tekst:Hoofdstuk">
            <xsl:if test="$context/@eId=@eId and not(string(tekst:Kop/tekst:Nummer)=string(position()))">
                <xsl:value-of select="@eId"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_0460================================================================================================================ -->
    
    <sch:pattern id="TPOD_0460">
        <sch:rule context="//tekst:Titel/tekst:Kop[tekst:Label ne 'Titel']">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0460",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="../@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een Titel moet worden geduid met het label Titel.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="../@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0470================================================================================================================ -->
    
    <sch:pattern id="TPOD_0470">
        <sch:rule context="//tekst:Hoofdstuk/tekst:Titel">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="fouten" value="foo:foutenTPOD_0470(.)"/>
            
            <sch:let name="CONDITION" value="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0470",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "De nummering van Titels moet beginnen met het nummer van het Hoofdstuk waarin de Titel voorkomt.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:foutenTPOD_0470">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context/../tekst:Titel">
            <xsl:if test="$context/@eId=@eId and not(starts-with(tekst:Kop/tekst:Nummer, concat($context/../tekst:Kop/tekst:Nummer, '.')))">
                <xsl:value-of select="@eId"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ===========TPOD_0480================================================================================================================= -->
    
    <sch:pattern id="TPOD_0480">
        <sch:rule context="//tekst:Titel">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0480(.)"/>
            <sch:let name="CONDITION" value="string-length($volgorde[1]) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0480",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Titels moeten oplopend worden genummerd in Arabische cijfers.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
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
    
    <!-- ============TPOD_0490================================================================================================================ -->
    
    <sch:pattern id="TPOD_0490">
        <sch:rule context="//tekst:Titel">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                { 
                "code": "TPOD0490", 
                "ernst": "Waarschuwing", 
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>", 
                "regel": "Achter het cijfer van een titelnummer mag geen punt worden opgenomen.", 
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>:<sch:value-of select="string(tekst:Kop/tekst:Nummer)"/>" 
                }
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ===========TPOD_0510================================================================================================================= -->
    
    <sch:pattern id="TPOD_0510">
        <sch:rule context="//tekst:Afdeling/tekst:Kop[tekst:Label ne 'Afdeling']">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0510",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="../@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een Afdeling moet worden geduid met de label Afdeling.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="../@eId"/>."
                },
                
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0520================================================================================================================ -->
    
    <sch:pattern id="TPOD_0520">
        <sch:rule context="//tekst:Hoofdstuk/tekst:Titel/tekst:Afdeling">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0520(.)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0520",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Als tussen Hoofdstuk en Afdeling Titel voorkomt dan moet de nummering van Afdelingen beginnen met het samengestelde nummer van de Titel waarin de Afdeling voorkomt, gevolgd door een punt.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0520">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context/../tekst:Afdeling">
            <xsl:if test="$context/@eId=@eId and not(starts-with(string(tekst:Kop/tekst:Nummer),concat(../tekst:Kop/tekst:Nummer, '.')))">
                <xsl:value-of select="@eId"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_0530================================================================================================================ -->
    
    <sch:pattern id="TPOD_0530">
        <sch:rule context="//tekst:Afdeling">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0530(.)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0530",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Afdelingen moeten oplopend worden genummerd in Arabische cijfers.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0530">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context/../tekst:Afdeling">
            <xsl:if test="$context/@eId=@eId and not(substring-after(string(tekst:Kop/tekst:Nummer),concat(../tekst:Kop/tekst:Nummer,'.'))=string(position()))">
                <xsl:value-of select="@eId"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    
    <!-- ===========TPOD_0540================================================================================================================= -->
    
    <sch:pattern id="TPOD_0540">
        <sch:rule context="//tekst:Afdeling">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0540",
                "ernst": "",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Achter het laatste cijfer van een Afdelingnummer mag geen punt worden opgenomen.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>:<sch:value-of select="string(tekst:Kop/tekst:Nummer)"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0560================================================================================================================ -->
    
    <sch:pattern id="TPOD_0560">
        <sch:rule context="//tekst:Hoofdstuk/tekst:Afdeling">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="fouten" value="foo:volgordeTPOD_0560(.)"/>
            <sch:let name="CONDITION" value="string-length($fouten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0560",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Als tussen Hoofdstuk en Afdeling geen Titel voorkomt dan moet de nummering van Afdelingen beginnen met het nummer van het Hoofdstuk waarin de Afdeling voorkomt, gevolgd door een punt. ",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0560">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context/../tekst:Afdeling">
            <xsl:if test="$context/@eId=@eId and not(starts-with(string(tekst:Kop/tekst:Nummer),concat(../tekst:Kop/tekst:Nummer, '.')))">
                <xsl:value-of select="@eId"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ===========TPOD_0570================================================================================================================= -->
    
    <sch:pattern id="TPOD_0570">
        <sch:rule context="//tekst:Paragraaf/tekst:Kop[(lower-case(tekst:Label) ne '§') and (tekst:Label ne 'Paragraaf')]">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0570",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een Paragraaf moet worden geduid met de label Paragraaf of het paragraaf-teken.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0580=============================================================================================================== -->
    
    <sch:pattern id="TPOD_0580">
        <sch:rule context="//tekst:Afdeling/tekst:Paragraaf">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0580( .)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0580",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "De nummering van Paragrafen begint met het samengestelde nummer van de Afdeling waarin de Paragraaf voorkomt, gevolgd door een punt.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0580">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context/../tekst:Paragraaf">
            <xsl:if test="$context/@eId=@eId and not(starts-with(string(tekst:Kop/tekst:Nummer),concat(../tekst:Kop/tekst:Nummer, '.')))">
                <xsl:value-of select="@eId"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_0590================================================================================================================ -->
    
    <sch:pattern id="TPOD_0590">
        <sch:rule context="//tekst:Paragraaf">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0590( .)"/>
            
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0590",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Paragrafen moeten oplopend worden genummerd in Arabische cijfers.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0590">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context/../tekst:Paragraaf">
            <xsl:if test="$context/@eId=@eId and not(substring-after(string(tekst:Kop/tekst:Nummer),concat(../tekst:Kop/tekst:Nummer,'.'))=string(position()))">
                <xsl:value-of select="@eId"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_0600================================================================================================================ -->
    
    <sch:pattern id="TPOD_0600">
        <sch:rule context="//tekst:Paragraaf">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0600",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Achter het cijfer van een paragraafnummer mag geen punt worden opgenomen.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>:<sch:value-of select="string(tekst:Kop/tekst:Nummer)"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
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
            <sch:let name="paragraaf" value="tekst:Kop/tekst:Nummer/text()"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0630($paragraaf, .)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_0630: De nummering van Subparagrafen begint met het samengestelde nummer van de Paragraaf waarin de Subparagraaf voorkomt, gevolgd door een punt. 
                (betreft: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0630">
        <xsl:param name="paragraaf" as="xs:string"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="volgorde">
            <xsl:for-each select="$context/tekst:Subparagraaf">
                <xsl:if test="not(string(tekst:Kop/tekst:Nummer)=concat($paragraaf, '.', string(position())))">
                    <xsl:value-of select="concat('paragraaf: ',$paragraaf, ' subparagraaf: ',string(tekst:Kop/tekst:Nummer),', ')"/>
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
        <sch:rule context="//tekst:Subparagraaf">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0650",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Achter het laatste cijfer van een Subparagraafnummer mag geen punt worden opgenomen.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>:<sch:value-of select="string(tekst:Kop/tekst:Nummer)"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
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
                (betreft subparagraaf: <sch:value-of select="$subparagraaf"/>, subsubparagrafen: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/></sch:assert>
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
                (betreft subparagraaf: <sch:value-of select="$subparagraaf"/>,subsubparagrafen: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)  
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
        <sch:rule context="//tekst:Subsubparagraaf">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0700",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Achter het laatste cijfer van een Subsubparagraafnummer mag geen punt worden opgenomen. ",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>:<sch:value-of select="string(tekst:Kop/tekst:Nummer)"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
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
                (betreft hoofdstuk: <sch:value-of select="$hoofdstuk"/>, artikels: <sch:value-of select="substring($volgorde,1,string-length($volgorde)-2)"/>)</sch:assert>
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
                (betreft hoofdstuk: <sch:value-of select="$hoofdstuk"/>, artikelen: <sch:value-of select="substring($bevatLetters, 1, string-length($bevatLetters) - 2)"/>)</sch:assert>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0741($hoofdstuk, $bevatLetters, .)"/>
            <sch:let name="CONDITION_2" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_2) or not($APPLICABLE)"> 
                TPOD_0741: De nummering van Artikelen begint met het nummer van het Hoofdstuk waarin het Artikel
                voorkomt, gevolgd door een punt, daarna oplopende nummering van de Artikelen in Arabische cijfers inclusief indien nodig een letter. 
                (betreft hoofdstuk:<sch:value-of select="$hoofdstuk"/>, artikelen: <sch:value-of select="substring($volgorde, 1, string-length($volgorde) - 2)"/>)</sch:assert>
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
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0750",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Achter het laatste cijfer van een Artikelnummer mag geen punt worden opgenomen.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>:<sch:value-of select="string(tekst:Kop/tekst:Nummer)"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0780================================================================================================================ -->
    
    <sch:pattern id="TPOD_0780">
        <sch:rule context="//tekst:Lid">
            <sch:let name="APPLICABLE" value="$omgevingsverordening"/>
            <sch:let name="bevatLetters" value="foo:bevatGeletterdeNummersTPOD_0780(.)"/>
            <sch:let name="CONDITION_1" value="string-length($bevatLetters) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_1) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0780",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Leden moeten per artikel oplopend genummerd worden in Arabische cijfers (en indien nodig, een letter).",
                "melding": "De nummering van Leden ( <sch:value-of select="string(tekst:LidNummer)"/> ) bevat letters en kan niet middels schematron op geldigheid worden gecheckt. Dit moet handmatig gebeuren."
                },
            </sch:assert> 
            <sch:let name="volgorde" value="foo:volgordeTPOD_0780($bevatLetters,.)"/>
            <sch:let name="CONDITION_2" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_2) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0780",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Leden moeten per artikel oplopend genummerd worden in Arabische cijfers (en indien nodig, een letter).",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>:<sch:value-of select="string(tekst:LidNummer)"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:bevatGeletterdeNummersTPOD_0780">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="bevatLetters">
            <xsl:for-each select="$context/../tekst:Lid">
                <xsl:if test="matches(tekst:LidNummer, '\d{1,2}[a-z]{1,2}\.')">
                    <xsl:value-of select="concat(string(tekst:LidNummer), ', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$bevatLetters"/>
    </xsl:function>
    
    <xsl:function name="foo:volgordeTPOD_0780">
        <xsl:param name="bevatLetters"/>
        <xsl:param name="context" as="node()"/>
        <xsl:if test="string-length($bevatLetters) = 0">
            <xsl:for-each select="$context/../tekst:Lid">
                <xsl:if test="$context/@eId=@eId">
                    <xsl:choose>
                        <xsl:when test="(matches(tekst:LidNummer, '\d{1,2}\.')) or (matches(tekst:LidNummer, '\d{1,2}[a-z]{1}\.'))">
                            <xsl:choose>
                                <xsl:when test="matches(tekst:LidNummer, '\d{1,2}\.')">
                                    <xsl:if test="not(string(tekst:LidNummer)=concat(string(position()),'.'))">
                                        <xsl:value-of select="@eId"/>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:when test="matches(tekst:LidNummer, '\d{1,2}[a-z]{1}\.')">
                                    <xsl:if test="not(ends-with(tekst:LidNummer, '.'))">
                                        <xsl:value-of select="@eId"/>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="@eId"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@eId"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:function>
    
    <!-- ============TPOD_0781================================================================================================================ -->
    
    <sch:pattern id="TPOD_0781">
        <sch:rule context="//tekst:Lid">
            <sch:let name="APPLICABLE" value="$omgevingsverordening"/>
            <sch:let name="bevatLetters" value="foo:bevatGeletterdeNummersTPOD_0781(.)"/>
            <sch:let name="CONDITION_1" value="string-length($bevatLetters) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_1) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0781",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Leden moeten per artikel oplopend genummerd worden in Arabische cijfers (en indien nodig, een letter).",
                "melding": "De nummering van Leden ( <sch:value-of select="string(tekst:LidNummer)"/> ) bevat letters en kan niet middels schematron op geldigheid worden gecheckt. Dit moet handmatig gebeuren."
                },
            </sch:assert> 
            <sch:let name="volgorde" value="foo:volgordeTPOD_0781($bevatLetters,.)"/>
            <sch:let name="CONDITION_2" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION_2) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0781",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Leden moeten per artikel oplopend genummerd worden in Arabische cijfers (en indien nodig, een letter).",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>:<sch:value-of select="string(tekst:LidNummer)"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:bevatGeletterdeNummersTPOD_0781">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="bevatLetters">
            <xsl:for-each select="$context/../tekst:Lid">
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
            <xsl:for-each select="$context/../tekst:Lid">
                <xsl:if test="$context/@eId=@eId">
                    <xsl:choose>
                        <xsl:when test="(matches(tekst:LidNummer, '\d{1,2}\.')) or (matches(tekst:LidNummer, '\d{1,2}[a-z]{1}\.'))">
                            <xsl:choose>
                                <xsl:when test="matches(tekst:LidNummer, '\d{1,2}\.')">
                                    <xsl:if test="not(string(tekst:LidNummer)=concat(string(position()),'.'))">
                                        <xsl:value-of select="@eId"/>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:when test="matches(tekst:LidNummer, '\d{1,2}[a-z]{1}\.')">
                                    <xsl:if test="not(ends-with(tekst:LidNummer, '.'))">
                                        <xsl:value-of select="@eId"/>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="@eId"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@eId"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:function>
    
    <!-- ============TPOD_0790================================================================================================================ -->
    
    <sch:pattern id="TPOD_0790">
        <sch:rule context="//tekst:Lid">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="volgorde" value="foo:volgordeTPOD_0790(.)"/>
            <sch:let name="CONDITION" value="string-length($volgorde) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0790",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Het eerste lid van ieder artikel krijgt het nummer 1",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>: <sch:value-of select="tekst:LidNummer"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0790">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context/../tekst:Lid">
            <xsl:if test="position() = 1">
                <xsl:choose>
                    <xsl:when
                        test="(matches(tekst:LidNummer, '\d{1,2}\.')) or (matches(tekst:LidNummer, '\d{1,2}[a-z]{1}\.'))">
                        <xsl:if test="matches(tekst:LidNummer, '\d{1,2}\.')">
                            <xsl:if test="not(string(tekst:LidNummer) = '1.')">
                                <xsl:value-of select="@eId"/>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="matches(tekst:LidNummer, '\d{1,2}[a-z]{1}\.')">
                            <xsl:variable name="first" select="tokenize(tekst:LidNummer, '[a-z]{1}')[1]"/>
                            <xsl:if test="not(string($first) = string(1))">
                                <xsl:value-of select="@eId"/>
                            </xsl:if>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@eId"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_0800================================================================================================================ -->
    
    <sch:pattern id="TPOD_0800">
        <sch:rule context="//tekst:Lid">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="ends-with(string(tekst:LidNummer),'.')"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0800",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Achter het lidnummer moet een punt worden opgenomen.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>: <sch:value-of select="tekst:LidNummer"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0810================================================================================================================ -->
    
    <sch:pattern id="TPOD_0810">
        <sch:rule context="//tekst:Lijst">
            <sch:let name="APPLICABLE" value="$omgevingsplan-en-waterschap"/>
            <sch:let name="CONDITION" value="name(*[1])='Lijstaanhef'"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0810",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een Lijst wordt altijd voorafgegaan door een inleidende tekst, oftewel de Lijstaanhef.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0820================================================================================================================ -->
    
    <sch:pattern id="TPOD_0820">
        <sch:rule context="//tekst:Lijst">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="count(ancestor-or-self::tekst:Lijst)&lt;4"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0820",
                "ernst": "Blokkerend",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Lijsten mogen in ten hoogste drie niveaus gebruikt worden.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    <!-- ============TPOD_0830_0831================================================================================================================ -->
    
    <sch:pattern id="TPOD_0830_0831">
        <sch:rule context="//tekst:Lijst">
            <sch:report test="true()"><sch:value-of select="$SOORT_REGELING"/></sch:report>
            <sch:let name="APPLICABLE" value="$omgevingsplan-en-waterschap"/>
            <sch:let name="lijstMetLettersAangeven" value="foo:checkEersteNiveauLijstLettersTPOD_0830(.)"> </sch:let>
            <sch:let name="CONDITION" value="string-length($lijstMetLettersAangeven[1]) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0830_0831",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "De onderdelen van de Lijst op het eerste niveau moeten worden aangegeven met letters.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
                TPOD_0830/0831:<sch:value-of select="$lijstMetLettersAangeven"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkEersteNiveauLijstLettersTPOD_0830">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="ancestors" select="count($context/ancestor-or-self::tekst:Lijst)"/>
        <xsl:if test="$ancestors = 1">
            <xsl:for-each select="$context/tekst:Li">
                <xsl:if test="not(matches(tekst:LiNummer, '[a-z]{1}\.')) and not(matches(tekst:LiNummer, '[a-z]{1}'))">
                    <xsl:value-of select="@eId"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:function>
    
    <!-- ============TPOD_0840_0841================================================================================================================ -->
    
    <sch:pattern id="TPOD_0840_0841">
        <sch:rule context="//tekst:Lijst">
            <sch:let name="APPLICABLE" value="$omgevingsplan-en-waterschap"/>
            <sch:let name="ancestorsFout" value="foo:checkTweedeNiveauLijstCijfersTPOD_0840(.)"> </sch:let>
            <sch:let name="CONDITION" value="string-length($ancestorsFout[1]) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0840_0841",
                "ernst": "",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "De onderdelen van de Lijst op het tweede niveau moeten worden aangegeven met Arabische cijfers.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkTweedeNiveauLijstCijfersTPOD_0840">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="ancestors" select="count($context/ancestor-or-self::tekst:Lijst)"/>
        <xsl:if test="$ancestors = 2">
            <xsl:for-each select="$context/tekst:Li">
                <xsl:if test="not(matches(tekst:LiNummer, '[0-9]{1,2}\.')) and not(matches(tekst:LiNummer, '[0-9]{1,2}'))">
                    <xsl:value-of select="@eId"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:function>
    
    <!-- ============TPOD_0850_0851================================================================================================================ -->
    
    <sch:pattern id="TPOD_0850_0851">
        <sch:rule context="//tekst:Lijst">
            <sch:let name="APPLICABLE" value="$omgevingsplan-en-waterschap"/>
            <sch:let name="ancestorsFout" value="foo:checkTweedeNiveauLijstCijfersTPOD_0850(.)"> </sch:let>
            <sch:let name="CONDITION" value="string-length($ancestorsFout[1]) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0850_0851",
                "ernst": "",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "De onderdelen van de Lijst op het derde niveau moeten worden aangegeven met Arabische cijfers.",
                "melding": "Dit is niet het geval bij eId: <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkTweedeNiveauLijstCijfersTPOD_0850">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="ancestors" select="count($context/ancestor-or-self::tekst:Lijst)"/>
        <xsl:if test="$ancestors = 3">
            <xsl:for-each select="$context/tekst:Li">
                <xsl:if test="not(matches(tekst:LiNummer, '[0-9]{1,2}\.')) and not(matches(tekst:LiNummer, '[0-9]{1,2}'))">
                    <xsl:value-of select="@eId"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:function>
    
    <!-- ============TPOD_0880================================================================================================================ -->
    <sch:pattern id="TPOD880">
    <sch:rule context="//tekst:Hoofdstuk/tekst:Kop[string(tekst:Nummer) = '1']">
        <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
        <sch:let name="CONDITION" value="((tekst:Label/text() = 'Hoofdstuk') and (lower-case(tekst:Opschrift/text()) = 'algemene bepalingen'))"/>
        <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
            {               
            "code": "TPOD0880",
            "ernst": "Waarschuwing",
            "eId": "<sch:value-of select="../@eId"/>",
            "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
            "regel": "Hoofdstuk 1 heeft het Opschrift Algemene bepalingen",
            "melding": "Opschrift is hier: <sch:value-of select="tekst:Opschrift/text()"/>
            },
        </sch:assert>
    </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_0930================================================================================================================ -->
    
    <sch:pattern id="TPOD_0930_28992">
        <sch:rule context="//basisgeo:geometrie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="fout" value="foo:aantalTPOD_0930_28992(.)"/>
            <sch:let name="CONDITION" value="string-length($fout) = 0"/>
            <sch:let name="ASSERT" value="($APPLICABLE and $CONDITION) or not($APPLICABLE)"/>
            <sch:assert test="$ASSERT">
                {               
                "code": "TPOD0930",
                "ernst": "Blokkerend",
                "id": "<sch:value-of select="../basisgeo:id"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een geometrie moet zijn opgebouwd middels één coordinate reference system (crs): EPSG:28992 (=RD) of EPSG:4258 (=ETRS89). Indien gebruik wordt gemaakt van EPSG:28992 (=RD new) dan moeten coördinaten in eenheden van meters worden opgegeven waarbij de waarde maximaal drie decimalen achter de komma mag bevatten. Indien gebruik wordt gemaakt van EPSG:4258 (=ETRS89) dan moeten coördinaten in eenheden van decimale graden worden opgegeven waarbij de waarde maximaal acht decimalen achter de komma mag bevatten.",
                "melding": "<sch:value-of select="$fout"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="TPOD_0930_4258">
        <sch:rule context="//basisgeo:geometrie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="fout" value="foo:aantalTPOD_0930_4258(.)"/>
            <sch:let name="CONDITION" value="string-length($fout) = 0"/>
            <sch:let name="ASSERT" value="($APPLICABLE and $CONDITION) or not($APPLICABLE)"/>
            <sch:assert test="$ASSERT">
                {               
                "code": "TPOD0930",
                "ernst": "Blokkerend",
                "id": "<sch:value-of select="../basisgeo:id"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een geometrie moet zijn opgebouwd middels één coordinate reference system (crs): EPSG:28992 (=RD) of EPSG:4258 (=ETRS89). Indien gebruik wordt gemaakt van EPSG:28992 (=RD new) dan moeten coördinaten in eenheden van meters worden opgegeven waarbij de waarde maximaal drie decimalen achter de komma mag bevatten. Indien gebruik wordt gemaakt van EPSG:4258 (=ETRS89) dan moeten coördinaten in eenheden van decimale graden worden opgegeven waarbij de waarde maximaal acht decimalen achter de komma mag bevatten.",
                "melding": "<sch:value-of select="$fout"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:aantalTPOD_0930_28992">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="fout">
            <xsl:for-each select="$context/*">
                <xsl:variable name="srsName" select="string(./@srsName)"/>
                <xsl:if test="tokenize(string(./@srsName), ':')[last()] = '28992'">
                    <xsl:variable name="fouteCoord" select="foo:fouteCoordTPOD_0930(., 3)"/>
                    <xsl:if test="string-length($fouteCoord) > 0">
                        <xsl:value-of
                            select="
                            concat(' EPSG:28992 (=RD new), coördinaten in meters: Maximaal 3 decimalen. gml:id=', ./@gml:id, ', coördinaten: ',
                            concat(substring(substring($fouteCoord, 1, string-length($fouteCoord) - 2), 0, 80), '.....'))"
                        />
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$fout"/>
    </xsl:function>
    
    <xsl:function name="foo:aantalTPOD_0930_4258">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="fout">
            <xsl:for-each select="$context/*">
                <xsl:variable name="srsName" select="string(./@srsName)"/>
                <xsl:if test="tokenize(string(./@srsName), ':')[last()] = '4258'">
                    <xsl:variable name="fouteCoord" select="foo:fouteCoordTPOD_0930(., 8)"/>
                    <xsl:if test="string-length($fouteCoord) > 0">
                        <xsl:value-of
                            select="
                            concat(' EPSG:4258 (=ETRS89) coördinaten in graden, Maximaal 8 decimalen. gml:id=', ./@gml:id, ', coördinaten: ',
                            concat(substring(substring($fouteCoord, 1, string-length($fouteCoord) - 2), 0, 80), '.....'))"
                        />
                    </xsl:if>
                </xsl:if>
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
            context="//basisgeo:geometrie">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="crs" value="foo:crsTPOD_0940(.)"/>
            <sch:let name="crsses" value="foo:crssesTPOD_0940($crs, .)"/>
            <sch:let name="CONDITION" value="string-length($crsses) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                {               
                "code": "TPOD0940",
                "ernst": "Blokkerend",
                "id": "<sch:value-of select="../basisgeo:id"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een geometrie moet zijn opgebouwd middels één coordinate reference system (crs)",
                "melding": "EPSG:28992 (=RD new) of EPSG:4258 (=ETRS89). Id=<sch:value-of select="../basisgeo:id"/> bevat een combinatie van beiden."
                },
            </sch:assert>
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
            <sch:let name="CONDITION" value="string-length(foo:opschriftTPOD0980(.)[1]) > 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD0980",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Hoofdstuk 1 moet een artikel 'begripsbepalingen' bevatten.",
                "melding": "Dit is niet aangetroffen in Hoofdstuk <sch:value-of select="@eId"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:opschriftTPOD0980">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context/descendant::tekst:Artikel">
            <xsl:if test="lower-case(tekst:Kop/tekst:Opschrift/text()) = 'begripsbepalingen'">
                <xsl:value-of select="@eId"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_1000================================================================================================================ -->
    
    <sch:pattern id="TPOD_1000">
        <sch:rule context="//tekst:Begrip">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="tekst:Term and tekst:Definitie"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1000",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een Begrip moet bestaan uit één term en één definitie.",
                "melding": "Dit is niet het geval in Begrip met eId: <sch:value-of select="@eId"/> "
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
        
    <!-- ============TPOD_1010================================================================================================================ -->
    
    <sch:pattern id="TPOD_1010">
        <sch:rule context="//tekst:Begrippenlijst">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="items"
                value="foo:checkBegripTPOD1010(.)"/>
            <sch:let name="CONDITION"
                value="string-length($items)=0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1010",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een Begriplijst moet gesorteerd zijn",
                "melding": "Dit geldt niet voor de Begrippenlijst met eId: <sch:value-of select="@eId"/> "
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkBegripTPOD1010">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="list">
            <xsl:for-each select="$context/tekst:Begrip">
                <xsl:value-of select="tekst:Term/text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="sortedList">
            <xsl:for-each select="$context/tekst:Begrip">
                <xsl:sort select="tekst:Term/text()"/>
                <xsl:value-of select="tekst:Term/text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="not($sortedList=$list)">
            <xsl:value-of select="string($context/@eId)"/>            
        </xsl:if>
    </xsl:function>
    
    <!-- ============TPOD_1020================================================================================================================ -->
    
    <sch:pattern id="TPOD_1020">
        <sch:rule context="//tekst:Begrippenlijst[tekst:Begrip/tekst:LiNummer]">
            <sch:let name="APPLICABLE" value="$regelstructuur"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1020",
                "ernst": "Waarschuwing,
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Begrippen mogen niet worden genummerd",
                "melding": "In de Begrippenlijst met eId: <sch:value-of select="@eId"/> wordt LiNummer aangetroffen"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1070================================================================================================================ -->
    
    <sch:pattern id="TPOD_1070">
        <sch:rule context="//tekst:Begrippenlijst[tekst:Begrip/tekst:LiNummer]">
            <sch:let name="APPLICABLE" value="$allen-behalve-rijk"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1070",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="@eId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Meet- en rekenbepalingen mogen niet worden genummerd.",
                "melding": "In de Begrippenlijst met eId: <sch:value-of select="@eId"/> wordt LiNummer aangetroffen"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1310================================================================================================================ -->
    
    <sch:pattern id="TPOD_1310">
        <sch:rule context="//l:Gebied/l:hoogte[string(da:eenheid) ne 'http://standaarden.omgevingswet.overheid.nl/eenheid/id/concept/Meter_Eenheid']">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1310",
                "ernst": "Waarschuwing",
                "identificatie": "<sch:value-of select="../l:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Locatie heeft het attribuut hoogte, indien het attribuut hoogte gevuld wordt dient hier binnen de eenheid de URI van 'meter' gekozen te worden.",
                "melding": "Dit is niet zo in Gebied: <sch:value-of select="../l:identificatie"/> "
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
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
                {               
                "code": "TPOD1650",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../../rol:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Het attribuut 'normwaarde' moet bestaan uit één van de drie mogelijke attributen; 'kwalitatieveWaarde' óf 'kwantitatieveWaarde' of 'waardeInRegeltekst'",
                "melding": "Dit is niet het geval bij indentifivatie: <sch:value-of select="../../rol:identificatie"/> "
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1700================================================================================================================ -->
    
    <sch:pattern id="TPOD_1700">
        <sch:rule context="rol:Activiteit">
            <sch:let name="APPLICABLE" value="$regelstructuur"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1700",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="rol:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Blokkerend",
                "melding": "Voor elke hiërarchie van nieuwe activiteiten geldt dat de hoogste activiteit in de hiërarchie een bovenliggende activiteit moet hebben die reeds bestaat in de functionele structuur.",
                "waarschuwing": "Verwijzingen naar DSO data worden nog niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1710================================================================================================================ -->
    
    <sch:pattern id="TPOD_1710">
        <sch:rule context="//rol:Activiteit">
            <sch:let name="APPLICABLE" value="$regelstructuur"/>
            <sch:let name="activiteitenLijst" value="foo:activiteitenLijstTPOD_1710()"/>
            <sch:let name="circulaireActivititeiten"
                value="foo:circulaireActivititeitenTPOD_1710(., $activiteitenLijst)"/>
            <!-- TPOD1710  -->
            <sch:let name="CONDITION" value="string-length($circulaireActivititeiten) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                {               
                "code": "TPOD1710",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="rol:identificatie/text()"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een bovenliggende activiteit mag niet naar een activiteit verwijzen die lager in de hiërarchie ligt. ",
                "melding": "Dit is niet het geval in: <sch:value-of select="rol:identificatie/text()"/> ",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:circulaireActivititeitenTPOD_1710">
        <xsl:param name="context" as="node()"/>
        <xsl:param name="activiteitenLijst"/>
        <xsl:variable name="circulaireActivititeiten">
            <xsl:variable name="bovenLiggend"
                select="string($context/rol:bovenliggendeActiviteit/rol:ActiviteitRef/@xlink:href)"/>
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
                    test="string(rol:bovenliggendeActiviteit/rol:ActiviteitRef/@xlink:href) = $bovenliggend">
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
        <sch:rule context="//rol:Activiteit">
            <sch:let name="APPLICABLE" value="$regelstructuur"/>
            <sch:let name="activiteitenLijst" value="foo:activiteitenLijstTPOD_1730()"/>
            <!-- TPOD1730  -->
            <sch:let name="CONDITION" value="contains($activiteitenLijst, rol:gerelateerdeActiviteit/rol:ActiviteitRef/@xlink:href)"/>
            <sch:assert
                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                {               
                "code": "TPOD1730",
                "ernst": "Waarschuwing",
                "identificatie": "<sch:value-of select="rol:identificatie/text()"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Gerelateerde activiteiten moeten bestaan indien er naar verwezen wordt.",
                "melding": "Dit is niet het geval in: <sch:value-of select="rol:identificatie/text()"/> met verwijzing naar: <sch:value-of select="rol:gerelateerdeActiviteit/rol:ActiviteitRef/@xlink:href"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <xsl:function name="foo:activiteitenLijstTPOD_1730">
        <xsl:variable name="activiteitenLijst">
            <xsl:for-each
                select="$xmlDocuments//rol:Activiteit">
                <xsl:value-of select="rol:identificatie/text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$activiteitenLijst"/>
    </xsl:function>
    
    <!-- ============TPOD_1740================================================================================================================ -->
    
    <sch:pattern id="TPOD_1740">
        <sch:rule context="//rol:Activiteit">
            <sch:let name="APPLICABLE"
                value="$SOORT_REGELING = $AMvB or $SOORT_REGELING = $MR or $SOORT_REGELING = $OP or $SOORT_REGELING = $OV or $SOORT_REGELING = $WV"/>
            <sch:let name="activiteitenLijst" value="foo:activiteitenLijstTPOD_1740()"/>
            <sch:let name="CONDITION" value="contains($activiteitenLijst, string(rol:bovenliggendeActiviteit/rol:ActiviteitRef/@xlink:href))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                {               
                "code": "TPOD1740",
                "ernst": "Waarschuwing",
                "identificatie": "<sch:value-of select="rol:identificatie/text()"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Bovenliggende activiteiten moeten bestaan indien er naar verwezen wordt.",
                "melding": "Dit is niet het geval in: <sch:value-of select="rol:identificatie/text()"/> met verwijzing naar: <sch:value-of select="rol:bovenliggendeActiviteit/rol:ActiviteitRef/@xlink:href"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <xsl:function name="foo:activiteitenLijstTPOD_1740">
        <xsl:variable name="activiteitenLijst">
            <xsl:for-each
                select="$xmlDocuments//rol:Activiteit">
                <xsl:value-of select="rol:identificatie/text()"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$activiteitenLijst"/>
    </xsl:function>
    
    <!-- ============TPOD_1750================================================================================================================ -->
    
    <sch:pattern id="TPOD_1750">
        <sch:rule context="//rol:Activiteit">
            <sch:let name="APPLICABLE" value="$regelstructuur"/>
            <sch:let name="ref" value="rol:identificatie/text()"/>
            <sch:let name="CONDITION" value="not(foo:activiteitenGebiedenTPOD_1750($ref) = 'false')"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                <sch:value-of select="foo:activiteitenGebiedenTPOD_1750($ref)"/>
                {               
                "code": "TPOD1750",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="rol:identificatie/text()"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een Activiteit moet een gebied of gebiedengroep betreffen (en mag geen punt, puntengroep, lijn of lijnengroep zijn).",
                "melding": "Dit is niet het geval in: <sch:value-of select="rol:identificatie/text()"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    <xsl:function name="foo:activiteitenGebiedenTPOD_1750">
        <xsl:param name="ref"/>
        <xsl:variable name="returnValue">
            <xsl:for-each
                select="$xmlDocuments//r:RegelVoorIedereen/r:activiteitaanduiding[string(rol:ActiviteitRef/@xlink:href) = $ref]/r:ActiviteitLocatieaanduiding/r:locatieaanduiding">
                <xsl:for-each select="*">
                    <xsl:choose>
                        <xsl:when test="./local-name() = 'LocatieRef'">
                            <xsl:if
                                test="not(contains(string(@xlink:href), '.gebiedengroep.') or contains(string(@xlink:href), '.gebied.'))">
                                <xsl:value-of select="false()"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:when test="./local-name() = 'GebiedengroepRef'">
                            <xsl:if test="not((contains(string(./@xlink:href), '.gebiedengroep.')))">
                                <xsl:value-of select="false()"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:when test="./local-name() = 'GebiedRef'">
                            <xsl:if test="not((contains(string(./@xlink:href), '.gebied.')))">
                                <xsl:value-of select="false()"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="false()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$returnValue"/>
    </xsl:function>
        
    <!-- ============TPOD_1760================================================================================================================ -->
    
    <sch:pattern id="TPOD_1760">
        <sch:rule
            context="//ga:Gebiedsaanwijzing">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="CONDITION"
                value="
                contains(ga:locatieaanduiding/l:LocatieRef/@xlink:href, '.gebiedengroep.') or contains(ga:locatieaanduiding/l:LocatieRef/@xlink:href, '.gebied.')
                or
                contains(ga:locatieaanduiding/l:GebiedRef/@xlink:href, '.gebiedengroep.') or contains(ga:locatieaanduiding/l:GebiedRef/@xlink:href, '.gebied.')                
                "/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1760",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="ga:identificatie/text()"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een gebiedsaanwijzing moet een gebied of gebiedengroep zijn (en mag geen punt, puntengroep, lijn of lijnengroep zijn).",
                "melding": "Dit is niet het geval in: <sch:value-of select="ga:identificatie/text()"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1780================================================================================================================ -->
    
    <sch:pattern id="TPOD_1780">
        <sch:rule
            context="//aanlevering:AanleveringBesluit">
            <sch:let name="APPLICABLE" value="$regelstructuur"/>
            <sch:let name="CONDITION"
                value="count(//tekst:Hoofdstuk/descendant::tekst:Artikel)>0"/>    
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1780",
                "ernst": "Blokkerend",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een omgevingsdocument met een artikelstructuur moet bestaan uit tenminste een hoofdstuk en een artikel.",
                "melding": "Een van beiden of beiden missen."
                },
                TPOD1780: Een omgevingsdocument met een artikelstructuur moet bestaan uit tenminste een hoofdstuk en een artikel. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1790================================================================================================================ -->
    
    <sch:pattern id="TPOD_1790">
        <sch:rule
            context="//r:Instructieregel">
            <sch:let name="APPLICABLE" value="$omgevingsplan"/>
            <sch:let name="CONDITION"
                value="false()"/>    
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1790",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="string(r:artikelOfLid/r:RegeltekstRef/@xlink:href)"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Het IMOW-object 'Instructieregel' is niet van toepassing (voor Omgevingsplan).",
                "melding": "Betreft:<sch:value-of select="string(r:artikelOfLid/r:RegeltekstRef/@xlink:href)"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1830================================================================================================================ -->    
    
    <sch:pattern id="TPOD1830">
        <sch:rule context="//ga:Gebiedsaanwijzing[ga:type/text() eq 'http://standaarden.omgevingswet.overheid.nl/typegebiedsaanwijzing/id/concept/Functie']">
            <sch:let name="APPLICABLE" value="$rijk"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                {               
                "code": "TPOD1830",
                "ernst": "Waarschuwing",
                "identificatie": "<sch:value-of select="ga:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Binnen het object ‘Gebiedsaanwijzing’ is de waarde ‘functie’ van attribuut ‘type’ (datatype TypeGebiedsaanwijzing) niet toegestaan. (voor AMvB/MR)",
                "melding": "Dit is wel het geval in <sch:value-of select="ga:identificatie"/> "
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1840================================================================================================================ -->    
    
    <sch:pattern id="TPOD1840">
        <sch:rule context="//ga:Gebiedsaanwijzing[ga:type/text() eq 'http://standaarden.omgevingswet.overheid.nl/typegebiedsaanwijzing/id/concept/Beperkingengebied']">
            <sch:let name="APPLICABLE" value="$rijk"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                {               
                "code": "TPOD1840",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="ga:identificatie/text()"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Binnen het object ‘Gebiedsaanwijzing’ is de waarde ‘beperkingengebied’ van attribuut ‘type’ (datatype TypeGebiedsaanwijzing) niet toegestaan. (voor AMvB/MR) ",
                "melding": "Dit is wel het geval in <sch:value-of select="ga:identificatie"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1850================================================================================================================ -->    
    
    <sch:pattern id="TPOD1850">
        <sch:rule context="//r:Regeltekst">
            <sch:let name="APPLICABLE" value="$regelstructuur"/>
            <sch:let name="fouten" value="foo:CheckFouteConstructiesTPOD_1850(.)"/>
            <sch:let name="CONDITION" value="string-length($fouten)=0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                {               
                "code": "TPOD1850",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="r:identificatie/text()"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Alle Juridische regels binnen één Regeltekst moeten van hetzelfde type zijn, respectievelijk; RegelVoorIedereen, Instructieregel of Omgevingswaarderegel.",
                "melding": "Regeltekst waarom het gaat: <sch:value-of select="r:identificatie/text()"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:CheckFouteConstructiesTPOD_1850">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="regeltekstId" select="$context/r:identificatie/text()"/>
        <xsl:variable name="ct" select="count($xmlDocuments//r:artikelOfLid/r:RegeltekstRef[@xlink:href eq $regeltekstId])"/>
        <xsl:variable name="cr" select="count($xmlDocuments//r:RegelVoorIedereen/r:artikelOfLid/r:RegeltekstRef[@xlink:href eq $regeltekstId])"/>
        <xsl:variable name="ci" select="count($xmlDocuments//r:Instructieregel/r:artikelOfLid/r:RegeltekstRef[@xlink:href eq $regeltekstId])"/>
        <xsl:variable name="co" select="count($xmlDocuments//r:Omgevingswaarderegel/r:artikelOfLid/r:RegeltekstRef[@xlink:href eq $regeltekstId])"/>
        <xsl:if test="not($ct=$cr or $ct=$ci or $ct=$co)">
            <xsl:value-of select="$regeltekstId"/>
        </xsl:if>                
    </xsl:function>
    
    <!-- ============TPOD_1860================================================================================================================ -->
    
    <sch:pattern id="TPOD_1860">
        <sch:rule context="//r:Regeltekst">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="CONDITION"
                value="not(r:gerelateerdeRegeltekst/r:RegeltekstRef/@xlink:href eq r:identificatie)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1860",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="r:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.",
                "melding": "Betreft verwijzing gerelateerdeRegeltekst naar zichzelf: <sch:value-of select="name()"/>: <sch:value-of select="r:identificatie"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        <sch:rule context="//rol:Activiteit">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="CONDITION"
                value="not(rol:gerelateerdeActiviteit/rol:ActiviteitRef/@xlink:href eq rol:identificatie)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1860",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="rol:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.",
                "melding": "Betreft verwijzing gerelateerdeActiviteit naar zichzelf: <sch:value-of select="name()"/>: <sch:value-of select="rol:identificatie"/>, ",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        <sch:rule context="//r:artikelOfLid/r:RegeltekstRef">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//r:Regeltekst/r:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1860",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../../r:artikelOfLid/r:RegeltekstRef/@xlink:href"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.",
                "melding": "Betreft <sch:value-of select="../../name()"/>: <sch:value-of select="../../r:artikelOfLid/r:RegeltekstRef/@xlink:href"/>, <sch:value-of select="@xlink:href"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        <sch:rule context="//r:RegelVoorIedereen/r:activiteitaanduiding/rol:ActiviteitRef">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Activiteit/rol:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1860",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../../r:artikelOfLid/r:RegeltekstRef/@xlink:href"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.",
                "melding": "Betreft <sch:value-of select="../../name()"/>: <sch:value-of select="../../r:artikelOfLid/r:RegeltekstRef/@xlink:href"/>, <sch:value-of select="@xlink:href"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        <sch:rule context="//r:omgevingsnormaanduiding/rol:OmgevingsnormRef">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Omgevingsnorm/rol:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1860",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../../r:artikelOfLid/r:RegeltekstRef/@xlink:href"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.",
                "melding": "Betreft <sch:value-of select="../../name()"/>: <sch:value-of select="../../r:artikelOfLid/r:RegeltekstRef/@xlink:href"/>, <sch:value-of select="@xlink:href"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        <sch:rule context="//r:gebiedsaanwijzing/ga:GebiedsaanwijzingRef">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//ga:Gebiedsaanwijzing/ga:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1860",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../../r:artikelOfLid/r:RegeltekstRef/@xlink:href"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.",
                "melding": "Betreft <sch:value-of select="../../name()"/>: <sch:value-of select="../../r:artikelOfLid/r:RegeltekstRef/@xlink:href"/>, <sch:value-of select="@xlink:href"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        <sch:rule context="//rol:gerelateerdeActiviteit/rol:ActiviteitRef">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="identifiers"
                value="foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Activiteit/rol:identificatie)"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1860",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../../rol:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.",
                "melding": "Betreft <sch:value-of select="../../name()"/>: <sch:value-of select="../../rol:identificatie"/>, <sch:value-of select="@xlink:href"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        <sch:rule
            context="//l:LocatieRef | l:GebiedRef | l:GebiedengroepRef | l:PuntRef | l:PuntengroepRef | l:LijnengroepRef | l:LijnRef">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="identifiers" value="foo:getLocationIdentifiersTPOD_1860()"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1860",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../../*:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.",
                "melding": "Betreft <sch:value-of select="../../name()"/>: <sch:value-of select="../../*:identificatie"/>, <sch:value-of select="@xlink:href"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
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
            <sch:let name="APPLICABLE" value="$regelstructuur"/>
            <sch:let name="identifiers" value="foo:getRegelTekstIdentifiersTPOD_1870()"/>
            <sch:let name="CONDITION" value="contains($identifiers, concat('.',r:RegeltekstRef/@xlink:href,'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1870",
                "ernst": "Blokkerend",
                "RegeltekstRef": "<sch:value-of select="r:RegeltekstRef/@xlink:href"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Een verwijzing naar ArtikelOfLid moet verwijzen naar een bestaand artikel of lid.",
                "melding": "Betreft
                <sch:value-of select="../name()"/>: <sch:value-of select="../@ow:regeltekstId"/>, <sch:value-of select="r:RegeltekstRef/@xlink:href"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:getRegelTekstIdentifiersTPOD_1870">
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xmlDocuments//r:Regeltekst">
                <xsl:value-of select="concat('.',r:identificatie/text(),'.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <!-- ============TPOD_1880================================================================================================================ -->
    
    <sch:pattern id="TPOD_1880">
        <sch:rule context="//(rol:Omgevingswaarde|r:Omgevingswaarderegel)">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="CONDITION" value="not($waterschapsverordening)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1880",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="rol:identificatie/text()"/><sch:value-of select="string(r:artikelOfLid/r:RegeltekstRef/@xlink:href)"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "De IMOW-objecten 'Omgevingswaarde' zijn niet van toepassing op de Waterschapsverordening",
                "melding": "Betreft <sch:value-of select="local-name()"/>: <sch:value-of select="rol:identificatie/text()"/><sch:value-of select="string(r:artikelOfLid/r:RegeltekstRef/@xlink:href)"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1890================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1890">
        <sch:rule context="//*:identificatie">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="CONDITION" value="contains(text(), concat('.', foo:CheckFouteIdentifierTPOD_1890(.), '.'))"/>
            <sch:assert
                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1890",
                "ernst": "Blokkerend",
                "eId": "<sch:value-of select="text()"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "De identificatie van het OwObject moet de naam van het OwObject-element zelf bevatten, en in het geval van een Juridische regel, de term juridischeregel.",
                "melding": "Betreft <sch:value-of select="../name()"/>: <sch:value-of select="text()"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:CheckFouteIdentifierTPOD_1890">
        <xsl:param name="context"/>
        <xsl:choose>
            <xsl:when test="
                lower-case($context/../local-name())='regelvooriedereen' 
                or 
                lower-case($context/../local-name())='instructieregel' 
                or 
                lower-case($context/../local-name())='omgevingswaarderegel'
                ">
                <xsl:value-of select="'juridischeregel'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="lower-case($context/../local-name())"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- ============TPOD_1910================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1910">
        <sch:rule context="//sl:objectTypen/sl:objectType">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="objects" value="foo:owObjectenLijstTPOD_1910(.)"/>
            <sch:let name="CONDITION" value="contains($objects, concat('.',text(),'.'))"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                {               
                "code": "TPOD1910",
                "ernst": "Blokkerend",
                "objectType": "<sch:value-of select="text()"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "De objecttypen in ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen dienen overeen te komen met de daadwerkelijke objecten in het betreffende Ow-bestand.",
                "melding": "Het objecttype waarom het gaat: <sch:value-of select="text()"/>"
                },
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
        <sch:rule context="/ow-manifest:Aanleveringen/ow-manifest:Aanlevering/ow-manifest:Bestand">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="nfFOOT" value="foo:notfoundFileOrObjectTypeTPOD_1920(ow-manifest:naam,.)"></sch:let>
            <sch:let name="CONDITION" value="string-length($nfFOOT) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1920",
                "ernst": "Blokkerend",
                "eId": "<sch:value-of select="ow-manifest:objecttype"/>, <sch:value-of select="ow-manifest:naam"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "De objecttypen in manifest-ow dienen overeen te komen met de objecttypen in het betreffende Ow-bestand.",
                "melding": "Het gaat om deze objecttypen: <sch:value-of select="$nfFOOT"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:notfoundFileOrObjectTypeTPOD_1920">
        <xsl:param name="naam"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="notfoundFileOrObjectType">
            <xsl:for-each select="$context/ow-manifest:objecttype">
                <xsl:variable name="objecttype" select="text()"/>
                <xsl:choose>
                    <xsl:when test=". = 'Geometrie'">
                        <xsl:if test="not(document($naam)//geo:GeoInformatieObjectVaststelling)">
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
                {               
                "code": "TPOD1930",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../l:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een OwObject in een Gebiedengroep moet een bestaand (ander) OwObject van het type Gebied zijn.",
                "melding": "Betreft <sch:value-of select="../name()"/>: <sch:value-of select="../l:identificatie"/>: <sch:value-of select="substring($notFound,1,string-length($notFound)-2)"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:notFoundTPOD_1930">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="notFound">
            <xsl:variable name="identifiers"
                select="foo:getIdentifiersTPOD_1930($xmlDocuments//l:Gebied/l:identificatie)"/>
            <xsl:for-each select="$context/l:GebiedRef">
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
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="notFound" value="foo:notFoundTPOD_1940(.)"/>
            <sch:let name="CONDITION" value="string-length($notFound) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1940",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../l:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een OwObject in een Puntengroep moet een bestaand (ander) OwObject van het type Punt zijn.",
                "melding": "Betreft <sch:value-of select="../name()"/>: <sch:value-of select="../l:identificatie"/>: <sch:value-of select="substring($notFound,1,string-length($notFound)-2)"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:notFoundTPOD_1940">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="identifiers"
            select="foo:getIdentifiersTPOD_1940($xmlDocuments//l:Punt/l:identificatie)"/>
        <xsl:variable name="notFound">
            <xsl:for-each select="$context/l:PuntRef">
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
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="notFound" value="foo:notFoundTPOD_1950(.)"/>
            <sch:let name="CONDITION" value="string-length($notFound) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1950",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../l:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een OwObject in een Puntengroep moet een bestaand (ander) OwObject van het type Punt zijn.",
                "melding": "Betreft <sch:value-of select="../name()"/>: <sch:value-of select="../l:identificatie"/>: <sch:value-of select="substring($notFound,1,string-length($notFound)-2)"/>."
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:notFoundTPOD_1950">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="notFound">
            <xsl:variable name="identifiers"
                select="foo:getIdentifiersTPOD_1950($xmlDocuments//l:Lijn/l:identificatie)"/>
            <xsl:for-each select="$context/l:LijnRef">
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
            <sch:rule context="//l:Lijn/l:geometrie/l:GeometrieRef">
                <sch:let name="APPLICABLE"
                    value="true()"/>
                <sch:let name="href" value="string(@xlink:href)"/>
                <sch:let name="geometrie" value="$gmlDocuments//basisgeo:Geometrie[basisgeo:id/text() eq $href]"/>
                <sch:let name="CONDITION" value="not($geometrie//gml:MultiPoint || $geometrie//gml:Point || $geometrie//gml:MultiSurface)"/>
                <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                    {               
                    "code": "TPOD1960",
                    "ernst": "Blokkerend",
                    "identificatie": "<sch:value-of select="../../l:identificatie"/>",
                    "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                    "regel": "Iedere verwijzing naar een gmlObject vanuit een Lijn moet een lijn-geometrie zijn.",
                    "melding": "Betreft <sch:value-of select="../../name()"/>: <sch:value-of select="../../l:identificatie"/>, <sch:value-of select="@xlink:href"/>"
                    },
                </sch:assert>
            </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1970================================================================================================================ -->    
    
    <sch:pattern id="TPOD_1970">
        <sch:rule context="//l:Punt/l:geometrie/l:GeometrieRef">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="href" value="string(@xlink:href)"/>
            <sch:let name="geometrie" value="$gmlDocuments//basisgeo:Geometrie[basisgeo:id/text() eq $href]"/>
            <sch:let name="CONDITION" value="$geometrie//gml:MultiPoint || $geometrie//gml:Point"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
                {               
                "code": "TPOD1970",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../../l:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een gmlObject vanuit een Punt moet een punt-geometrie zijn.",
                "melding": "Betreft <sch:value-of select="../../name()"/>: <sch:value-of select="../../l:identificatie"/>, <sch:value-of select="@xlink:href"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_1980================================================================================================================ -->
    
    <sch:pattern id="TPOD_1980">
        <sch:rule context="//l:Gebied/l:geometrie/l:GeometrieRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="href" value="string(@xlink:href)"/>
            <sch:let name="CONDITION" value="foo:calculateConditionTPOD_1980($href) = 1"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1980",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="../../l:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere verwijzing naar een gmlObject vanuit een Gebied moet een gebied-geometrie zijn.",
                "melding": "Betreft <sch:value-of select="../../name()"/>: <sch:value-of select="../../l:identificatie"/>, <sch:value-of select="@xlink:href"/>"
                },       
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:calculateConditionTPOD_1980">
        <xsl:param name="href"/>
        <xsl:for-each select="$gmlDocuments//basisgeo:Geometrie">
            <xsl:value-of select="0"/>
            <xsl:if test="basisgeo:id/text() = $href">
                <xsl:if
                    test="
                    basisgeo:geometrie//gml:Polygon
                    or
                    basisgeo:geometrie//gml:MultiSurface
                    or
                    basisgeo:geometrie//gml:Surface">
                    <xsl:value-of select="1"/>
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_1990================================================================================================================ -->
    
    <sch:pattern id="TPOD_1990">
        <sch:rule context="//basisgeo:Geometrie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="geoLocationGeoReferenceIdentifiers"
                value="foo:getLocationGeoReferenceIdentifiersTPOD_1990()"/>
            <sch:let name="nietGerefereerdeGeometrie"
                value="foo:nietGerefereerdeGeometrieTPOD_1990($geoLocationGeoReferenceIdentifiers, .)"/>
            <sch:let name="CONDITION" value="string-length($nietGerefereerdeGeometrie) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1990",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="basisgeo:id/text()"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere Geometrie heeft minstens een OwObject dat ernaar verwijst",
                "melding": "Betreft: <sch:value-of select="basisgeo:id/text()"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="//r:Regeltekst/r:identificatie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="regeltekstReferenties"
                value="foo:getReferencesTPOD_1990($xmlDocuments//r:RegeltekstRef)"/>
            <sch:let name="nietGerefereerdeReferenties" value="foo:nietGerefereerdeReferentiesTPOD_1990($regeltekstReferenties, .)"/>
            <sch:let name="CONDITION" value="string-length($nietGerefereerdeReferenties) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1990",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="substring($nietGerefereerdeReferenties,1,string-length($nietGerefereerdeReferenties)-2)"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere Regeltekst heeft minstens een OwObject dat ernaar verwijst",
                "melding": "Betreft: <sch:value-of select="substring($nietGerefereerdeReferenties,1,string-length($nietGerefereerdeReferenties)-2)"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="//(vt:FormeleDivisie|vt:Hoofdlijn)/vt:identificatie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="formeleDivisieReferenties"
                value="foo:getReferencesTPOD_1990($xmlDocuments//(vt:FormeleDivisieRef|vt:HoofdlijnRef))"/>
            <sch:let name="nietGerefereerdeReferenties" value="foo:nietGerefereerdeReferentiesTPOD_1990($formeleDivisieReferenties, .)"/>
            <sch:let name="CONDITION" value="string-length($nietGerefereerdeReferenties) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1990",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="substring($nietGerefereerdeReferenties,1,string-length($nietGerefereerdeReferenties)-2)"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere FormeleDivisie of Hoofdlijn heeft minstens een OwObject dat ernaar verwijst",
                "melding": "Betreft: <sch:value-of select="substring($nietGerefereerdeReferenties,1,string-length($nietGerefereerdeReferenties)-2)"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="//rol:Activiteit/rol:identificatie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="activiteitRefs"
                value="foo:getReferencesTPOD_1990($xmlDocuments//rol:ActiviteitRef)"/>
            <sch:let name="nietGerefereerdeReferenties"
                value="foo:nietGerefereerdeReferentiesTPOD_1990($activiteitRefs, .)"/>
            <sch:let name="CONDITION" value="string-length($nietGerefereerdeReferenties) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD1990",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="substring($nietGerefereerdeReferenties,1,string-length($nietGerefereerdeReferenties)-2)"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere Activiteit-aanduiding heeft minstens een OwObject dat ernaar verwijst",
                "melding": "Betreft: <sch:value-of select="substring($nietGerefereerdeReferenties,1,string-length($nietGerefereerdeReferenties)-2)"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
                />
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
                {               
                "code": "TPOD1990",
                "ernst": "Waarschuwing",
                "eId": "<sch:value-of select="substring($nietGerefereerdeReferenties,1,string-length($nietGerefereerdeReferenties)-2)"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Iedere Locatie-aanduiding heeft minstens een OwObject dat ernaar verwijst",
                "melding": "Betreft: <sch:value-of select="substring($nietGerefereerdeReferenties,1,string-length($nietGerefereerdeReferenties)-2)"/>",
                "waarschuwing": "Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht."
                },
            </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <xsl:function name="foo:nietGerefereerdeGeometrieTPOD_1990">
        <xsl:param name="identifiers"/>
        <xsl:param name="context" as="node()"/>
        <xsl:if test="not(contains($identifiers, concat('.', string($context/basisgeo:id/text()), '.')))">
            <xsl:value-of select="string($context/basisgeo:id/text())"/>
        </xsl:if>
    </xsl:function>
    
    <xsl:function name="foo:nietGerefereerdeReferentiesTPOD_1990">
        <xsl:param name="referenties"/>
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="nietGerefereerdeReferenties">
            <xsl:if test="not(contains($referenties, concat('.', $context/text(), '.')))">
                <xsl:value-of select="concat(string($context/text()), ', ')"/>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$nietGerefereerdeReferenties"/>
    </xsl:function>
    
    <xsl:function name="foo:getReferencesTPOD_1990">
        <xsl:param name="xpath" as="node()*"/>
        <xsl:variable name="references">
            <xsl:for-each select="$xpath">
                <xsl:value-of select="concat('.', string(@xlink:href), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$references"/>
    </xsl:function>
    
    <xsl:function name="foo:getLocationGeoReferenceIdentifiersTPOD_1990">
        <xsl:variable name="identifiers">
            <xsl:for-each select="$xmlDocuments//l:GeometrieRef">
                <xsl:value-of select="concat('.', string(@xlink:href), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <xsl:function name="foo:getLocationReferenceIdentifiersTPOD_1990">
        <xsl:variable name="identifiers">
            <xsl:for-each
                select="$xmlDocuments//(l:LocatieRef | l:GebiedRef | l:LijnRef | l:PuntRef | l:GebiedengroepRef | l:PuntengroepRef | l:LijnengroepRef)">
                <xsl:value-of select="concat('.', string(@xlink:href), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <!-- ============TPOD_2000================================================================================================================ -->
    
    <sch:pattern id="TPOD_2000">
        <sch:rule context="//r:Regeltekst">
            <sch:let name="APPLICABLE" value="$regelstructuur"/>
            <sch:let name="CONDITION" value="string-length(foo:checkWIdTPOD_2000(@wId)) > 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD2000",
                "ernst": "Blokkerend",
                "wId": "<sch:value-of select="@wId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Het wId van de Regeltekst in OW moet verwijzen naar een bestaande wId van een Artikel of Lid in OP",
                "melding": "Betreft: <sch:value-of select="@wId"/> "
                },
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
    
    <!-- ============TPOD_2040================================================================================================================ -->
    
    <sch:pattern id="TPOD_2040">
        <sch:rule context="//vt:Divisie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION" value="string-length(foo:checkWIdTPOD_2040(@wId)) > 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2040: Betreft <sch:value-of select="name()"/>: <sch:value-of select="@wId"/>: 
                Het wId van de Divisie in OW moet verwijzen naar een bestaande wId van een Divisie in OP
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkWIdTPOD_2040">
        <xsl:param name="identifier"/>
        <xsl:for-each select="$xmlDocuments//tekst:Divisie/@wId">
            <xsl:if test="$identifier eq .">
                <xsl:value-of select="$identifier"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_2050================================================================================================================ -->
    
    <sch:pattern id="TPOD_2050">
        <sch:rule context="//aanlevering:AanleveringBesluit">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="message" value="foo:existsTPOD_2050()"/>
            <sch:let name="CONDITION" value="string-length($message)=0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD2050",
                "ernst": "Blokkerend",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Kijken of het manifest-ow en het manifest bestaan, en de bestanden benoemd in de manifest-bestanden aanwezig zijn.",
                "melding": "<sch:value-of select="$message"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:existsTPOD_2050">
        <xsl:variable name="message">
            <xsl:choose>
                <xsl:when test="(not(document('manifest-ow.xml'))) and (not(document('manifest.xml')))">
                    <xsl:value-of select="'manifest-ow.xml en manifest.xml zijn niet aangetroffen of niet valide.'"/>
                </xsl:when>
                <xsl:when test="not(document('manifest-ow.xml'))">
                    <xsl:value-of select="concat('manifest-ow.xml is niet aangetroffen of niet valide. ',foo:bestandenTPOD_2050())"/>
                </xsl:when>
                <xsl:when test="not(document('manifest.xml'))">
                    <xsl:value-of select="'manifest.xml is niet aangetroffen of niet valide.'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="foo:bestandenTPOD_2050()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:message select="$message"/>
        <xsl:value-of select="$message"/>
    </xsl:function>
    
    <xsl:function name="foo:bestandenTPOD_2050">
        <xsl:variable name="bestandsnaam">
            <xsl:for-each select="$xmlDocuments/lvbb:manifest/lvbb:bestand">
                <xsl:if test="not(document(lvbb:bestandsnaam/text()))">
                    <xsl:value-of select="concat(lvbb:bestandsnaam/text(), ', ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="concat('Volgende bestanden uit manifest.xml zijn niet aangetroffen: ',$bestandsnaam)"/>
    </xsl:function>
    
    <!-- ============TPOD_2060================================================================================================================ -->
    
    <sch:pattern id="TPOD_2060">
        <sch:rule context="//tekst:Artikel">
            <sch:let name="APPLICABLE" value="$regelstructuur"/>
            <sch:let name="message" value="foo:checkFouteArtikelLidCombinatieTPOD_2060(.)"/>
            <sch:let name="CONDITION" value="string-length($message) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD2060",
                "ernst": "Blokkerend",
                "wId": "<sch:value-of select="@wId"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Als er een Regeltekst van een Lid is gemaakt mag er geen Regeltekst meer gemaakt worden van het Artikel dat boven dit Lid hangt.",
                "melding": "<sch:value-of select="$message"/> "
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkFouteArtikelLidCombinatieTPOD_2060">
        <xsl:param name="context" as="node()"/>
        <!-- Ophalen wId uit stop-bestand -->
        <xsl:variable name="artikelWiD" select="string($context/@wId)"/>
        <!-- Verzamelen alle wIds uit regelteksten (omgeven door punten om contains-functie foutloos te kunnen doen) -->
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
                    <!-- ******   HIER IS HET DUS FOUT ******** -->
                    <!-- Ophalen regeltekstId behorend bij artikelwId -->
                    <xsl:variable name="regelTekstIdArtikel" select="$xmlDocuments//r:Regeltekst[@wId=$artikelWiD]/r:identificatie"/>
                    <!-- Ophalen regeltekstId behorend bij lid-wId -->
                    <xsl:variable name="regelTekstIdLid" select="$xmlDocuments//r:Regeltekst[@wId=$lidWiD]/r:identificatie"/>
                    <!-- Het ID part van de Foutmelding wordt geconstrueerd en in Results gezet. -->
                    <xsl:value-of
                        select="concat('artikel-wId: ', $artikelWiD, ' (',$regelTekstIdArtikel,')  --&gt; lid-wId: ', $lidWiD, ' (',$regelTekstIdLid,') ')"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="message">
            <!-- Als Results inhoud heeft (lengte) dan wordt er nog een tekst voorgevoegd en dat vormt het resultaat van de functie -->
            <xsl:if test="string-length($results) > 0">
                <xsl:value-of
                    select="
                    concat('Betreft: ',
                    $results)" />
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$message"/>
    </xsl:function>
    
    <!-- ============TPOD_2080================================================================================================================ -->
    
    <sch:pattern id="TPOD_2080">
        <sch:rule context="//r:Instructieregel">
            <sch:let name="APPLICABLE" value="$regelstructuur"/>
            <sch:let name="or" value="r:instructieregelTaakuitoefening or r:instructieregelInstrument"></sch:let>
            <sch:let name="both" value="r:instructieregelTaakuitoefening and r:instructieregelInstrument"></sch:let>
            <sch:let name="none" value="not(r:instructieregelTaakuitoefening) and not(r:instructieregelInstrument)"></sch:let>
            <sch:let name="CONDITION" value="$or and not($both) and not($none)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD2080",
                "ernst": "Blokkerend",
                "artikelOfLid": "<sch:value-of select="r:artikelOfLid/r:RegeltekstRef/@xlink:href"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Binnen een instructieregel dient er gekozen te worden tussen InstructieregelInstrument of InstructieregelTaakuitoefening (één van de twee moet voorkomen, niet meer, niet minder).",
                "melding": "Betreft Instructieregel bij Regeltekst: <sch:value-of select="r:artikelOfLid/r:RegeltekstRef/@xlink:href"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_2090================================================================================================================ -->
    
    <sch:pattern id="TPOD_2090">
        <sch:rule context="//rol:Omgevingsnorm">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="kwl" value="count(rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde)"></sch:let>
            <sch:let name="kwn" value="count(rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde)"></sch:let>
            <sch:let name="wir" value="count(rol:normwaarde/rol:Normwaarde/rol:waardeInRegeltekst)"></sch:let>
            <sch:let name="all" value="count(rol:normwaarde/rol:Normwaarde/(rol:kwalitatieveWaarde|rol:kwantitatieveWaarde|rol:waardeInRegeltekst))"></sch:let>
            <sch:let name="CONDITION" value="$kwl=$all or $kwn=$all or $wir=$all"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD2090",
                "ernst": "Blokkerend",
                "identificatie": "<sch:value-of select="rol:identificatie"/>",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Alle normwaarden van een norm moeten hetzelfde type zijn (kwalitatief, kwantitatief, of waardeInRegeltekst).",
                "melding": "Betreft Omgevingsnorm: <sch:value-of select="rol:identificatie"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_2100================================================================================================================ -->
    
    <sch:pattern id="TPOD_2100">
        <sch:rule context="//rol:Omgevingsnorm/rol:eenheid">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION" value="string-length(foo:typeOfNormaardeTPOD_2100(..))>0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2100: Eenheid mag alleen voorkomen bij een Norm met de normwaarden van het type kwantitatief.. 
                Betreft Normwaarde: <sch:value-of select="../rol:identificatie"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:typeOfNormaardeTPOD_2100">
        <xsl:param name="context" as="node()"/>
        <xsl:if test="$context/rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde[1]">
            <xsl:value-of select="$context/rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde[1]/text()"></xsl:value-of>
        </xsl:if>
    </xsl:function>
    

    <!-- ============TPOD_2110================================================================================================================ -->
    
    <sch:pattern id="TPOD_2110">
        <sch:rule context="//vt:Tekstdeel">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION" value="(vt:idealisatie and vt:locatieaanduiding) or not(vt:locatieaanduiding)"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2110: Idealisatie (bij Tekstdeel) is verplicht als Tekstdeel een locatie heeft. 
                Betreft Tekstdeel: <sch:value-of select="vt:identificatie"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_2120================================================================================================================ -->
    
    <sch:pattern id="TPOD_2120">
        <sch:rule context="//*:identificatie">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="dubbel" value="foo:vindDubbeleTPOD_2120(text())"/>
            <sch:let name="CONDITION" value="string-length($dubbel) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2120: Iedere OW-identificatie dient slechts 1 keer voor te komen per aanlevering (c.q. je mag niet binnen dezelfde aanlevering een ID aanmaken, en vervolgens het ID wijzigen), 
                dit betreft id:<sch:value-of select="text()"/>.
                Let op, heel belangrijk om dit eerst te repareren voor conclusies te trekken over fout-situaties in andere validaties.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:vindDubbeleTPOD_2120">
        <xsl:param name="id"/>
        <xsl:variable name="ids">
            <xsl:for-each select="$xmlDocuments//*:identificatie">
                <xsl:value-of select="concat('.', text(), '.')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="dubbeleIds">
            <xsl:variable name="after" select="substring-after($ids, concat('.', $id, '.'))"/>
            <xsl:if test="contains($after, concat('.', $id, '.'))">
                <xsl:value-of select="$id"/>
            </xsl:if>
        </xsl:variable>
        <xsl:value-of select="$dubbeleIds"/>
    </xsl:function>

    <!-- ============TPOD_2130================================================================================================================ -->
    
    <sch:pattern id="TPOD_2130">
        <sch:rule context="//l:GeometrieRef">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="dubbel"
                value="foo:vindDubbeleTPOD_2130(string(@xlink:href), ../../l:identificatie/text())"/>
            <sch:let name="CONDITION" value="string-length($dubbel[1]) = 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2130: Er zijn meerdere locaties die naar 1 geometrie verwijzen (altijd 1 locatie per geometrie
                toegestaan), dit betreft gebied:<sch:value-of select="../../l:identificatie/text()"/>, Geometrieref: <sch:value-of select="$dubbel"/>.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:vindDubbeleTPOD_2130">
        <xsl:param name="href"/>
        <xsl:param name="identifier"/>
        <xsl:for-each select="$xmlDocuments//l:GeometrieRef">
            <xsl:if
                test="not(../../l:identificatie/text() = $identifier) and $href = string(@xlink:href)">
                <xsl:value-of select="string(@xlink:href)"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_2140================================================================================================================ -->
    
    <sch:pattern id="TPOD_2140">
        <sch:rule context="//ow-manifest:WorkIDRegeling">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION"
                value="string-length(foo:checkWorkIdRegelingTPOD_2140(text())) > 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2140: Betreft <sch:value-of select="name()"/>: <sch:value-of select="text()"/>: het WorkIDRegeling van het manifest in OW moet verwijzen naar een bestaande FRBRWork in een Regelingversie in OP </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkWorkIdRegelingTPOD_2140">
        <xsl:param name="identifier"/>
        <xsl:for-each select="$xmlDocuments//data:ExpressionIdentificatie/data:FRBRWork/text()">
            <xsl:if test="$identifier eq .">
                <xsl:value-of select="$identifier"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_2150================================================================================================================ -->
    
    <sch:pattern id="TPOD_2150">
        <sch:rule context="//ow-manifest:DoelID">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION"
                value="string-length(foo:checkDoelIdTPOD_2150(text())) > 0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2150: Betreft <sch:value-of select="name()"/>: <sch:value-of select="text()"/>: Het DoelID van het manifest-ow moet verwijzen naar een bestaand doel dat aanwezig is in de bijbehorende Regeling in OP. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:checkDoelIdTPOD_2150">
        <xsl:param name="identifier"/>
        <xsl:for-each select="$xmlDocuments//data:BeoogdeRegelgeving/data:BeoogdeRegeling/data:doelen/data:doel/text()">
            <xsl:if test="$identifier eq .">
                <xsl:value-of select="$identifier"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <!-- ============TPOD_2160================================================================================================================ -->
    
    <sch:pattern id="TPOD_2160">
        <sch:rule context="//ow-manifest:Aanlevering">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION"
                value="count(ow-manifest:DoelID) = 1"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2160: In het manifest-ow mag maar voor 1 doel aangeleverd worden. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_2170================================================================================================================ -->
    
    <sch:pattern id="TPOD_2170">
        <sch:rule
            context="//(rol:Omgevingswaarde|rol:Omgevingsnorm)/rol:normwaarde">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="CONDITION" value="count(rol:Normwaarde/rol:waardeInRegeltekst) &lt; 2"/>
            <sch:assert
                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_2170: <sch:value-of select="../rol:identificatie"/>: Indien de normwaarde van het type 'waardeInRegeltekst' is, mag er maar één normwaarde voorkomen. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_2180================================================================================================================ -->
    
    <!-- Het is lastig een fout te triggeren op iets dat niet voorkomt, en je wilt het maar een keer testen.
    Daarom heb ik gekozen voor het manifest-ow dat maar een keer voorkomt, en dan op die plaats te controleren of ergens in een xml-document 
    Een regelingsgebied is gedeclareerd.
    Nu gaat deze validatie de mist in als het manifest-ow niet voorkomt, maar dan hebben we nog wel meer problemen.
    -->
    <sch:pattern id="TPOD_2180">
        <sch:rule
            context="//ow-manifest:Aanlevering">
            <sch:let name="APPLICABLE"
                value="true()"/>
            <sch:let name="CONDITION" value="count($xmlDocuments//rg:Regelingsgebied) = 1"/>
            <sch:assert
                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD_2180: Per Regeling moet er een Regelingsgebied zijn aangeleverd.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- ============TPOD_2190================================================================================================================ -->
    
    <sch:pattern id="TPOD_2190">
        <sch:rule context="//ow-manifest:Aanleveringen/ow-manifest:Aanlevering/ow-manifest:Bestand[ow-manifest:objecttype[1]/text() eq 'Geometrie']">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2190: In het manifest-OW mag het objecttype Geometrie niet voorkomen.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- ============TPOD_2200================================================================================================================ -->
    
    <sch:pattern id="TPOD_2200">
        <sch:rule context="//ow-manifest:Aanleveringen/ow-manifest:Aanlevering/ow-manifest:Bestand[ends-with(ow-manifest:naam[1]/text(), '.gml')]">
            <sch:let name="APPLICABLE" value="true()"/>
            <sch:let name="CONDITION" value="false()"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                TPOD2200: In het manifest-OW mag een bestandsnaam niet eindigen op '.gml'.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>
