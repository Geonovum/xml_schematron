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
    
    <!-- Bussiness Rules Groups -->
    <sch:let name="AMvB_MR_BRG" value="/regelingtype_001 /regelingtype_002"/>
    <sch:let name="AMvB_MR" value="
        $SOORT_REGELING=$AMvB or 
        $SOORT_REGELING=$MR"/>
    <sch:let name="Omgevingsplan_BRG" value="/regelingtype_003"/>
    <sch:let name="Omgevingsplan" value="
        $SOORT_REGELING=$OP"/>
    <sch:let name="OP-implementatie-GemeentenEnWaterschappen_BRG" value="/regelingtype_003 /regelingtype_005"/>
    <sch:let name="OP-implementatie-GemeentenEnWaterschappen" value="
        $SOORT_REGELING=$OP or 
        $SOORT_REGELING=$WV"/>
    <sch:let name="OW-generiek_BRG" value="/regelingtype_001 /regelingtype_002 /regelingtype_003 /regelingtype_004 /regelingtype_005 /regelingtype_006 /regelingtype_007 /regelingtype_008 /regelingtype_009 /regelingtype_010 /regelingtype_011"/>
    <sch:let name="OW-generiek" value="
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
    <sch:let name="OW-generiek_OZON_BRG" value="/regelingtype_001 /regelingtype_002 /regelingtype_003 /regelingtype_004 /regelingtype_005 /regelingtype_006 /regelingtype_007 /regelingtype_008 /regelingtype_009 /regelingtype_010 /regelingtype_011"/>
    <sch:let name="OW-generiek_OZON" value="
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
    <sch:let name="OP-implementatie-generiek_BRG" value="/regelingtype_001 /regelingtype_002 /regelingtype_003 /regelingtype_004 /regelingtype_005 /regelingtype_006 /regelingtype_007 /regelingtype_008 /regelingtype_009 /regelingtype_010 /regelingtype_011"/>
    <sch:let name="OP-implementatie-generiek" value="
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
    <sch:let name="OP-implementatie-niet-Rijk_BRG" value="/regelingtype_003 /regelingtype_004 /regelingtype_005 /regelingtype_006 /regelingtype_007 /regelingtype_008 /regelingtype_009 /regelingtype_010 /regelingtype_011"/>
    <sch:let name="OP-implementatie-niet-Rijk" value="
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
    <sch:let name="OP-implementatie-Omgevingsverordening_BRG" value="/regelingtype_004"/>
    <sch:let name="OP-implementatie-Omgevingsverordening" value="
        $SOORT_REGELING=$OV"/>
    <sch:let name="OP-implementatie-regelstructuur_BRG" value="/regelingtype_001 /regelingtype_002 /regelingtype_003 /regelingtype_004 /regelingtype_005 /regelingtype_009"/>
    <sch:let name="OP-implementatie-regelstructuur" value="
        $SOORT_REGELING=$AMvB or 
        $SOORT_REGELING=$MR or 
        $SOORT_REGELING=$OP or 
        $SOORT_REGELING=$OV or 
        $SOORT_REGELING=$WV or 
        $SOORT_REGELING=$VR
        "/>
    <sch:let name="Regelstructuur_BRG" value="/regelingtype_001 /regelingtype_002 /regelingtype_003 /regelingtype_004 /regelingtype_005 /regelingtype_009"/>
    <sch:let name="Regelstructuur" value="
        $SOORT_REGELING=$AMvB or 
        $SOORT_REGELING=$MR or 
        $SOORT_REGELING=$OP or 
        $SOORT_REGELING=$OV or 
        $SOORT_REGELING=$WV or 
        $SOORT_REGELING=$VR
        "/>
    <sch:let name="Regelstructuur_OZON_BRG" value="/regelingtype_001 /regelingtype_002 /regelingtype_003 /regelingtype_004 /regelingtype_005 /regelingtype_009"/>
    <sch:let name="Regelstructuur_OZON" value="
        $SOORT_REGELING=$AMvB or 
        $SOORT_REGELING=$MR or 
        $SOORT_REGELING=$OP or 
        $SOORT_REGELING=$OV or 
        $SOORT_REGELING=$WV or 
        $SOORT_REGELING=$VR
        "/>
    <sch:let name="Vrijetekststructuur_BRG" value="/regelingtype_006 /regelingtype_007 /regelingtype_008 /regelingtype_010 /regelingtype_011"/>
    <sch:let name="Vrijetekststructuur" value="
        $SOORT_REGELING=$OVi or
        $SOORT_REGELING=$PB or
        $SOORT_REGELING=$I or
        $SOORT_REGELING=$P or
        $SOORT_REGELING=$RI
        "/>
    <sch:let name="Vrijetekststructuur_OZON_BRG" value="/regelingtype_006 /regelingtype_007 /regelingtype_008 /regelingtype_010 /regelingtype_011"/>
    <sch:let name="Vrijetekststructuur_OZON" value="
        $SOORT_REGELING=$PB or
        $SOORT_REGELING=$I or
        $SOORT_REGELING=$P or
        $SOORT_REGELING=$RI or
        $SOORT_REGELING=$OVi
        "/>
    <sch:let name="Waterschapsverordening_BRG" value="/regelingtype_005"/>
    <sch:let name="Waterschapsverordening" value="
        $SOORT_REGELING=$WV"/>
    
    <!-- ============TPOD_0410================================================================================================================ -->
    
    <sch:pattern id="TPOD_0410" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0410'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//tekst:Hoofdstuk/tekst:Kop[tekst:Label ne 'Hoofdstuk']"/>
        <sch:param name="idf" value="string(../@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Een Hoofdstuk moet worden geduid met het label Hoofdstuk.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0420=============================================================================================================== -->
    
    <sch:pattern id="TPOD_0420" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0420'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//tekst:Hoofdstuk/tekst:Kop[tekst:Label ne 'Hoofdstuk']"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Een Hoofdstuk moet worden geduid met het label Hoofdstuk.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0460" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0460'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//tekst:Titel/tekst:Kop[tekst:Label ne 'Titel']"/>
        <sch:param name="idf" value="string(../@eId)"/>
        <sch:param name="nameidf" value="'eId'"/>
        <sch:param name="regel" value="'Een Titel moet worden geduid met het label Titel.'"/>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0470================================================================================================================ -->
    
    <sch:pattern id="TPOD0470" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0470'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:foutenTPOD_0470(.)[1]) = 0"/>
        <sch:param name="context" value="//tekst:Hoofdstuk/tekst:Titel"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'De nummering van Titels moet beginnen met het nummer van het Hoofdstuk waarin de Titel voorkomt.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0480" is-a="abstractPatternWarning">
        <sch:param name="code" value="'++TPOD0480'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0480(.)[1]) = 0"/>
        <sch:param name="context" value="//tekst:Titel"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Titels moeten oplopend worden genummerd in Arabische cijfers.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0490" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0490'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
        <sch:param name="context" value="//tekst:Titel"/>
        <sch:param name="idf" value="string(@eId)"/>
        <sch:param name="nameidf" value="'eId'"/>
        <sch:param name="regel" value="'Achter het cijfer van een titelnummer mag geen punt worden opgenomen.'"/>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ===========TPOD_0510================================================================================================================= -->
    
    <sch:pattern id="TPOD0510" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0510'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//tekst:Afdeling/tekst:Kop[tekst:Label ne 'Afdeling']"/>
        <sch:param name="idf" value="string(../@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Een Hoofdstuk moet worden geduid met het label Hoofdstuk.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0520================================================================================================================ -->
    
    <sch:pattern id="TPOD0520" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0520'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0520(.)) = 0"/>
        <sch:param name="context" value="//tekst:Hoofdstuk/tekst:Titel/tekst:Afdeling"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Als tussen Hoofdstuk en Afdeling Titel voorkomt dan moet de nummering van Afdelingen beginnen met het samengestelde nummer van de Titel waarin de Afdeling voorkomt, gevolgd door een punt.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0530" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0530'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0530(.)) = 0"/>
        <sch:param name="context" value="//tekst:Afdeling"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Afdelingen moeten oplopend worden genummerd in Arabische cijfers.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0540" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0540'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
        <sch:param name="context" value="//tekst:Afdeling"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Achter het laatste cijfer van een Afdelingnummer mag geen punt worden opgenomen.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0560================================================================================================================ -->
    
    <sch:pattern id="TPOD0560" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0560'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0560(.)) = 0"/>
        <sch:param name="context" value="//tekst:Hoofdstuk/tekst:Afdeling"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Als tussen Hoofdstuk en Afdeling geen Titel voorkomt dan moet de nummering van Afdelingen beginnen met het nummer van het Hoofdstuk waarin de Afdeling voorkomt, gevolgd door een punt.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0570" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0570'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//tekst:Paragraaf/tekst:Kop[(lower-case(tekst:Label) ne '§') and (tekst:Label ne 'Paragraaf')]"/>
        <sch:param name="idf" value="string(../@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Een Paragraaf moet worden geduid met de label Paragraaf of het paragraaf-teken.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0580=============================================================================================================== -->
    
    <sch:pattern id="TPOD0580" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0580'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0580(.)[1]) = 0"/>
        <sch:param name="context" value="//tekst:Afdeling/tekst:Paragraaf"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'De nummering van Paragrafen begint met het samengestelde nummer van de Afdeling waarin de Paragraaf voorkomt, gevolgd door een punt.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0590" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0590'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0590(.)) = 0"/>
        <sch:param name="context" value="//tekst:Paragraaf"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Paragrafen moeten oplopend worden genummerd in Arabische cijfers.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0600" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0600'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
        <sch:param name="context" value="//tekst:Paragraaf"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Achter het cijfer van een paragraafnummer mag geen punt worden opgenomen.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0620================================================================================================================ -->
    
    <sch:pattern id="TPOD0620" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0620'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//tekst:Paragraaf/tekst:Subparagraaf/tekst:Kop[lower-case(tekst:Label) ne 'subparagraaf']"/>
        <sch:param name="idf" value="string(../@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Een Subparagraaf moet worden geduid met de label Subparagraaf.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0630================================================================================================================ -->
    
    <sch:pattern id="TPOD0630" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0630'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0630(tekst:Kop/tekst:Nummer/text(), .)) = 0"/>
        <sch:param name="context" value="//tekst:Afdeling/tekst:Paragraaf"/>
        <sch:param name="idf" value="string(../@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'De nummering van Subparagrafen begint met het samengestelde nummer van de Paragraaf waarin de Subparagraaf voorkomt, gevolgd door een punt.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0640" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0640'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0640(string(tekst:Kop/tekst:Nummer), .)) = 0"/>
        <sch:param name="context" value="//tekst:Afdeling/tekst:Paragraaf"/>
        <sch:param name="idf" value="string(../@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Subparagrafen moeten oplopend worden genummerd in Arabische cijfers.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <xsl:function name="foo:volgordeTPOD_0640">
        <xsl:param name="paragraaf"/>
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
    
    <!-- ============TPOD_0650================================================================================================================ -->
    
    <sch:pattern id="TPOD0650" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0650'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
        <sch:param name="context" value="//tekst:Subparagraaf"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Achter het laatste cijfer van een Subparagraafnummer mag geen punt worden opgenomen.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0670================================================================================================================ -->
    
    <sch:pattern id="TPOD0670" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0670'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//tekst:Subparagraaf/tekst:Subsubparagraaf/tekst:Kop[lower-case(tekst:Label) ne 'subsubparagraaf']"/>
        <sch:param name="idf" value="string(../@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Een Subsubparagraaf moet worden geduid met de label Subsubparagraaf.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0680================================================================================================================ -->
    
    <sch:pattern id="TPOD0680" is-a="abstractPatternWarning">
        <sch:param name="code" value="'+TPOD0680'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0680(string(tekst:Kop/tekst:Nummer), .)) = 0"/>
        <sch:param name="context" value="//tekst:Paragraaf/tekst:Subparagraaf"/>
        <sch:param name="idf" value="string(../@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'De nummering van Subsubparagrafen begint met het samengestelde nummer van de Subparagraaf waarin de Subsubparagraaf voorkomt, gevolgd door een punt.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0690" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0690'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0690(string(tekst:Kop/tekst:Nummer), .)) = 0"/>
        <sch:param name="context" value="//tekst:Paragraaf/tekst:Subparagraaf"/>
        <sch:param name="idf" value="string(../@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Subsubparagrafen moeten oplopend worden genummerd in Arabische cijfers.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0700" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0700'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
        <sch:param name="context" value="//tekst:Subsubparagraaf"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Achter het laatste cijfer van een Subsubparagraafnummer mag geen punt worden opgenomen.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0720================================================================================================================ -->
    
    <sch:pattern id="TPOD0720" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD0720'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//tekst:Artikel/tekst:Kop[lower-case(tekst:Label) ne 'artikel']"/>
        <sch:param name="idf" value="string(../@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Een Artikel moet worden geduid met de label Artikel.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0730================================================================================================================ -->
    
    <sch:pattern id="TPOD0730" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0730'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0730(string(tekst:Kop/tekst:Nummer), .)) = 0"/>
        <sch:param name="context" value="//tekst:Hoofdstuk"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'De nummering van Artikelen begint met het nummer van het Hoofdstuk waarin het Artikel voorkomt, gevolgd door een punt.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0740" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0740'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-GemeentenEnWaterschappen"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0740(string(tekst:Kop/tekst:Nummer), .)) = 0"/>
        <sch:param name="context" value="//tekst:Hoofdstuk"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Artikelnummers moeten oplopend worden genummerd in Arabische cijfers.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0741_a" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0741'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-Omgevingsverordening"/>
        <sch:param name="CONDITION" value="string-length(foo:bevatGeletterdeNummersTPOD_0741(string(tekst:Kop/tekst:Nummer), .)) = 0"/>
        <sch:param name="context" value="//tekst:Hoofdstuk"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'De nummering van Artikelen bevat letters en kan niet middels schematron op geldigheid worden gecheckt. Dit moet handmatig gebeuren.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD0741_b" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0741'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-Omgevingsverordening"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0741(string(tekst:Kop/tekst:Nummer), foo:bevatGeletterdeNummersTPOD_0741(string(tekst:Kop/tekst:Nummer), .), .)) = 0"/>
        <sch:param name="context" value="//tekst:Hoofdstuk"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'De nummering van Artikelen begint met het nummer van het Hoofdstuk waarin het Artikel voorkomt, gevolgd door een punt, daarna oplopende nummering van de Artikelen in Arabische cijfers inclusief indien nodig een letter.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0750" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0750'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="not(ends-with(string(tekst:Kop/tekst:Nummer), '.'))"/>
        <sch:param name="context" value="//tekst:Artikel"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Achter het laatste cijfer van een Artikelnummer mag geen punt worden opgenomen.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0780================================================================================================================ -->
    
    <sch:pattern id="TPOD0780_a" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0780'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-GemeentenEnWaterschappen"/>
        <sch:param name="CONDITION" value="string-length(foo:bevatGeletterdeNummersTPOD_0780(.)) = 0"/>
        <sch:param name="context" value="//tekst:Lid"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Leden moeten per artikel oplopend genummerd worden in Arabische cijfers (en indien nodig, een letter).'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD0780_b" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0780'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-GemeentenEnWaterschappen"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0780(foo:bevatGeletterdeNummersTPOD_0780(.),.)) = 0"/>
        <sch:param name="context" value="//tekst:Lid"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Leden moeten per artikel oplopend genummerd worden in Arabische cijfers (en indien nodig, een letter).'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0781_a" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0781'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-Omgevingsverordening"/>
        <sch:param name="CONDITION" value="string-length(foo:bevatGeletterdeNummersTPOD_0781(.)) = 0"/>
        <sch:param name="context" value="//tekst:Lid"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Leden moeten per artikel oplopend genummerd worden in Arabische cijfers (en indien nodig, een letter).'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD0781_b" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0781'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-Omgevingsverordening"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0781(foo:bevatGeletterdeNummersTPOD_0781(.),.)) = 0"/>
        <sch:param name="context" value="//tekst:Lid"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Leden moeten per artikel oplopend genummerd worden in Arabische cijfers (en indien nodig, een letter).'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0790" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0790'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:volgordeTPOD_0790(.)) = 0"/>
        <sch:param name="context" value="//tekst:Lid"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Het eerste lid van ieder artikel krijgt het nummer 1'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0800" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0800'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="ends-with(string(tekst:LidNummer),'.')"/>
        <sch:param name="context" value="//tekst:Lid"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Achter het lidnummer moet een punt worden opgenomen.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0810================================================================================================================ -->
    
    <sch:pattern id="TPOD0810" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0810'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-GemeentenEnWaterschappen"/>
        <sch:param name="CONDITION" value="name(*[1])='Lijstaanhef'"/>
        <sch:param name="context" value="//tekst:Lijst"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Een Lijst wordt altijd voorafgegaan door een inleidende tekst, oftewel de Lijstaanhef.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0820================================================================================================================ -->
    
    <sch:pattern id="TPOD0820" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD0820'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="count(ancestor-or-self::tekst:Lijst)&lt;4"/>
        <sch:param name="context" value="//tekst:Lijst"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Lijsten mogen in ten hoogste drie niveaus gebruikt worden.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    
    <!-- ============TPOD_0830================================================================================================================ -->
    
    <sch:pattern id="TPOD0830" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0830'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-GemeentenEnWaterschappen"/>
        <sch:param name="CONDITION" value="string-length(foo:checkEersteNiveauLijstLettersTPOD_0830(.)[1]) = 0"/>
        <sch:param name="context" value="//tekst:Lijst"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'De onderdelen van de Lijst op het eerste niveau moeten worden aangegeven met letters.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <!-- ============TPOD_0831================================================================================================================ -->
    
    <sch:pattern id="TPOD0831" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0831'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-Omgevingsverordening"/>
        <sch:param name="CONDITION" value="true()"/>
        <sch:param name="context" value="//tekst:Lijst"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Het teken voor een Lijstitem mag zelf bepaald worden door het bevoegd gezag, ook als een lijst binnen een lid wordt gebruikt.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <xsl:function name="foo:checkEersteNiveauLijstLettersTPOD_0831">
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
    
    <!-- ============TPOD_0840================================================================================================================ -->
    
    <sch:pattern id="TPOD0840" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0840'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-GemeentenEnWaterschappen"/>
        <sch:param name="CONDITION" value="string-length(foo:checkTweedeNiveauLijstCijfersTPOD_0840(.)[1]) = 0"/>
        <sch:param name="context" value="//tekst:Lijst"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'De onderdelen van de Lijst op het tweede niveau moeten worden aangegeven met Arabische cijfers.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <!-- ============TPOD_0841================================================================================================================ -->
    
    <sch:pattern id="TPOD0841" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0841'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-Omgevingsverordening"/>
        <sch:param name="CONDITION" value="true()"/>
        <sch:param name="context" value="//tekst:Lijst"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Het teken voor een Lijstitem op het tweede niveau mag zelf bepaald worden door het bevoegd gezag, ook als een lijst binnen een lid wordt gebruikt.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <xsl:function name="foo:checkTweedeNiveauLijstCijfersTPOD_0841">
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
    
    <!-- ============TPOD_0850================================================================================================================ -->
    
    <sch:pattern id="TPOD0850" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0850'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-GemeentenEnWaterschappen"/>
        <sch:param name="CONDITION" value="string-length(foo:checkDerdeNiveauLijstCijfersTPOD_0850(.)[1]) = 0"/>
        <sch:param name="context" value="//tekst:Lijst"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'De onderdelen van de Lijst op het derde niveau moeten worden aangegeven met Arabische cijfers.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <xsl:function name="foo:checkDerdeNiveauLijstCijfersTPOD_0850">
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
    
    <!-- ============TPOD_0851================================================================================================================ -->
    
    <sch:pattern id="TPOD0851" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0851'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-Omgevingsverordening"/>
        <sch:param name="CONDITION" value="true()"/>
        <sch:param name="context" value="//tekst:Lijst"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Het teken voor een Lijstitem op het derde niveau mag zelf bepaald worden door het bevoegd gezag, ook als een lijst binnen een lid wordt gebruikt.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <xsl:function name="foo:checkDerdeNiveauLijstCijfersTPOD_0851">
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
    
    <sch:pattern id="TPOD0880" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0880'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="((tekst:Label/text() = 'Hoofdstuk') and (lower-case(tekst:Opschrift/text()) = 'algemene bepalingen'))"/>
        <sch:param name="context" value="//tekst:Hoofdstuk/tekst:Kop[string(tekst:Nummer) = '1']"/>
        <sch:param name="idf" value="string(../@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Hoofdstuk 1 heeft het Opschrift Algemene bepalingen.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_0930================================================================================================================ -->
    
    <sch:pattern id="TPOD0930_a" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD0930'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:aantalTPOD_0930_28992(.)) = 0"/>
        <sch:param name="context" value="//basisgeo:geometrie"/>
        <sch:param name="idf" value="string(../basisgeo:id)"></sch:param>
        <sch:param name="nameidf" value="'id'"></sch:param>
        <sch:param name="regel" value="'Een geometrie moet zijn opgebouwd middels één coordinate reference system (crs): EPSG:28992 (=RD) of EPSG:4258 (=ETRS89). Indien gebruik wordt gemaakt van EPSG:28992 (=RD new) dan moeten coördinaten in eenheden van meters worden opgegeven waarbij de waarde maximaal drie decimalen achter de komma mag bevatten.'"></sch:param>
        <sch:param name="melding" value="concat(': ',foo:aantalTPOD_0930_28992(.))"/>
        <sch:param name="waarschuwing" value="''"/>
        
    </sch:pattern>
    
    <sch:pattern id="TPOD0930_b" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD0930'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:aantalTPOD_0930_4258(.)) = 0"/>
        <sch:param name="context" value="//basisgeo:geometrie"/>
        <sch:param name="idf" value="string(../basisgeo:id)"></sch:param>
        <sch:param name="nameidf" value="'id'"></sch:param>
        <sch:param name="regel" value="'Een geometrie moet zijn opgebouwd middels één coordinate reference system (crs): EPSG:28992 (=RD) of EPSG:4258 (=ETRS89). Indien gebruik wordt gemaakt van EPSG:4258 (=ETRS89) dan moeten coördinaten in eenheden van decimale graden worden opgegeven waarbij de waarde maximaal acht decimalen achter de komma mag bevatten.'"></sch:param>
        <sch:param name="melding" value="concat(': ',foo:aantalTPOD_0930_4258(.))"/>
        <sch:param name="waarschuwing" value="''"/>
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
                            concat(' coördinaten: ',
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
                            concat(' coördinaten: ',
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
    
    <sch:pattern id="TPOD0940" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD0940'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:crssesTPOD_0940(foo:crsTPOD_0940(.), .)) = 0"/>
        <sch:param name="context" value="//basisgeo:geometrie"/>
        <sch:param name="idf" value="string(../basisgeo:id)"></sch:param>
        <sch:param name="nameidf" value="'id'"></sch:param>
        <sch:param name="regel" value="'Een geometrie moet zijn opgebouwd middels één coordinate reference system (crs)'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD0980" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD0980'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:opschriftTPOD0980(.)[1]) &gt; 0"/>
        <sch:param name="context" value="//tekst:Hoofdstuk[tekst:Kop/tekst:Nummer/text() eq '1']"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Hoofdstuk 1 moet een artikel \&quot;begripsbepalingen\&quot; bevatten.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD1000" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1000'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="count(tekst:Term)=1 and count(tekst:Definitie)=1"/>
        <sch:param name="context" value="//tekst:Begrip"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Een Begrip moet bestaan uit één term en één definitie.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
        
    <!-- ============TPOD_1010================================================================================================================ -->
    
    <sch:pattern id="TPOD1010" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1010'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:checkBegripTPOD1010(.)) = 0"/>
        <sch:param name="context" value="//tekst:Begrippenlijst"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Een Begriplijst moet gesorteerd zijn.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD1020" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1020'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-regelstructuur"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//tekst:Begrippenlijst[tekst:Begrip/tekst:LiNummer]"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Begrippen mogen niet worden genummerd.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_1070================================================================================================================ -->
    
    <sch:pattern id="TPOD1070" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1070'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="tekst:Inhoud/tekst:Begrippenlijst/tekst:Begrip/tekst:LiNummer"/>
        <sch:param name="context" value="//tekst:Artikel[tekst:Kop/tekst:Opschrift/text() eq 'Meet- en rekenbepalingen']"/>
        <sch:param name="idf" value="string(@eId)"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Meet- en rekenbepalingen mogen niet worden genummerd.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_1310================================================================================================================ -->
    
    <sch:pattern id="TPOD1310" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1310'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//l:Gebied/l:hoogte[string(da:eenheid) ne 'http://standaarden.omgevingswet.overheid.nl/eenheid/id/concept/Meter_Eenheid']"/>
        <sch:param name="idf" value="string(../l:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Locatie heeft het attribuut hoogte, indien het attribuut hoogte gevuld wordt dient hier binnen de eenheid de URI van \&quot;meter\&quot; gekozen te worden.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_1650================================================================================================================ -->
    
    <sch:pattern id="TPOD1650" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1650'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="
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
        <sch:param name="context" value="//(rol:Omgevingswaarde|rol:Omgevingsnorm)/rol:normwaarde/rol:Normwaarde"/>
        <sch:param name="idf" value="string(../../rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Het attribuut \&quot;normwaarde\&quot; moet bestaan uit één van de drie mogelijke attributen: \&quot;kwalitatieveWaarde\&quot; òf \&quot;kwantitatieveWaarde\&quot; òf \&quot;waardeInRegeltekst\&quot;'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_1700================================================================================================================ -->
    
    <sch:pattern id="TPOD1700" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1700'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-regelstructuur"/>
        <sch:param name="CONDITION" value="not(contains(foo:run1700(rol:identificatie/text(), string(rol:bovenliggendeActiviteit/rol:ActiviteitRef/@xlink:href), foo:activiteitenLijstTPOD_1700()), ','))"/>
        <sch:param name="context" value="//rol:Activiteit"/>
        <sch:param name="idf" value="string(rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Voor elke hiërarchie van nieuwe activiteiten geldt dat de hoogste activiteit in de hiërarchie een bovenliggende activiteit moet hebben die reeds bestaat in de functionele structuur.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Verwijzingen naar DSO data worden nog niet onderzocht.'"/>
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
    
    
    <!-- ============TPOD_1710================================================================================================================ -->
    
    <sch:pattern id="TPOD1710" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1710'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-regelstructuur"/>
        <sch:param name="CONDITION" value="string-length(foo:circulaireActivititeitenTPOD_1710(., foo:activiteitenLijstTPOD_1710())) = 0"/>
        <sch:param name="context" value="//rol:Activiteit"/>
        <sch:param name="idf" value="string(rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Een bovenliggende activiteit mag niet naar een activiteit verwijzen die lager in de hiërarchie ligt.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
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
    
    <sch:pattern id="TPOD1730" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1730'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-regelstructuur"/>
        <sch:param name="CONDITION" value="contains(foo:activiteitenLijstTPOD_1730(), rol:gerelateerdeActiviteit/rol:ActiviteitRef/@xlink:href)"/>
        <sch:param name="context" value="//rol:Activiteit"/>
        <sch:param name="idf" value="string(rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Gerelateerde activiteiten moeten bestaan indien er naar verwezen wordt.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
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
    
    <sch:pattern id="TPOD1740" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1740'"/>
        <sch:param name="businessRuleGroup" value="$Regelstructuur_OZON"/>
        <sch:param name="CONDITION" value="contains(foo:activiteitenLijstTPOD_1740(), string(rol:bovenliggendeActiviteit/rol:ActiviteitRef/@xlink:href))"/>
        <sch:param name="context" value="//rol:Activiteit"/>
        <sch:param name="idf" value="string(rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Bovenliggende activiteiten moeten bestaan indien er naar verwezen wordt.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
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
    
    <sch:pattern id="TPOD1750" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1750'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-regelstructuur"/>
        <sch:param name="CONDITION" value="not(foo:activiteitenGebiedenTPOD_1750(rol:identificatie/text()) = 'false')"/>
        <sch:param name="context" value="//rol:Activiteit"/>
        <sch:param name="idf" value="string(rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Een Activiteit moet een gebied of gebiedengroep betreffen (en mag geen punt, puntengroep, lijn of lijnengroep zijn).'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD1760" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1760'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="
            contains(ga:locatieaanduiding/l:LocatieRef/@xlink:href, '.gebiedengroep.') or contains(ga:locatieaanduiding/l:LocatieRef/@xlink:href, '.gebied.')
            or
            contains(ga:locatieaanduiding/l:GebiedRef/@xlink:href, '.gebiedengroep.') or contains(ga:locatieaanduiding/l:GebiedRef/@xlink:href, '.gebied.')
            "/>
        <sch:param name="context" value="//ga:Gebiedsaanwijzing"/>
        <sch:param name="idf" value="string(ga:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Een gebiedsaanwijzing moet een gebied of gebiedengroep zijn (en mag geen punt, puntengroep, lijn of lijnengroep zijn).'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_1770================================================================================================================ -->
    
    <sch:pattern id="TPOD1770" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1770'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//ga:Gebiedsaanwijzing"/>
        <sch:param name="idf" value="string(ga:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Binnen het object \&quot;Gebiedsaanwijzing\&quot; moeten de waarden van de attributen \&quot;groep\&quot; (datatype \&quot;Gebiedsaanwijzinggroep\&quot;) hiërarchisch vallen onder het \&quot;type\&quot; (datatype \&quot;TypeGebiedsaanwijzing\&quot;).'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Deze test wordt niet uitgevoerd omdat het binnen deze schematron nog niet mogelijk is om waardelijst-hierarchieën op te vragen via een externe API'"/>
    </sch:pattern>
    
    <!-- ============TPOD_1780================================================================================================================ -->
    
    <sch:pattern id="TPOD1780" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1780'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-regelstructuur"/>
        <sch:param name="CONDITION" value="count(//tekst:Hoofdstuk/descendant::tekst:Artikel) &gt; 0"/>
        <sch:param name="context" value="//aanlevering:AanleveringBesluit"/>
        <sch:param name="idf" value="string('n.v.t.')"></sch:param>
        <sch:param name="nameidf" value="'eId'"></sch:param>
        <sch:param name="regel" value="'Een omgevingsdocument met een artikelstructuur moet bestaan uit tenminste een hoofdstuk en een artikel.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_1790================================================================================================================ -->
    
    <sch:pattern id="TPOD1790" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1790'"/>
        <sch:param name="businessRuleGroup" value="$Omgevingsplan"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//r:Instructieregel"/>
        <sch:param name="idf" value="string(r:artikelOfLid/r:RegeltekstRef/@xlink:href)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Het IMOW-object \&quot;Instructieregel\&quot; is niet van toepassing (voor Omgevingsplan).'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_1830================================================================================================================ -->    
    
    <sch:pattern id="TPOD1830" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1830'"/>
        <sch:param name="businessRuleGroup" value="$AMvB_MR"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//ga:Gebiedsaanwijzing[ga:type/text() eq 'http://standaarden.omgevingswet.overheid.nl/typegebiedsaanwijzing/id/concept/Functie']"/>
        <sch:param name="idf" value="string(ga:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Binnen het object ‘Gebiedsaanwijzing’ is de waarde ‘functie’ van attribuut ‘type’ (datatype TypeGebiedsaanwijzing) niet toegestaan. (voor AMvB/MR)'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_1840================================================================================================================ -->    
    
    <sch:pattern id="TPOD1840" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1840'"/>
        <sch:param name="businessRuleGroup" value="$AMvB_MR"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//ga:Gebiedsaanwijzing[ga:type/text() eq 'http://standaarden.omgevingswet.overheid.nl/typegebiedsaanwijzing/id/concept/Beperkingengebied']"/>
        <sch:param name="idf" value="string(ga:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Binnen het object ‘Gebiedsaanwijzing’ is de waarde \&quot;beperkingengebied\&quot; van attribuut \&quot;type\&quot; (datatype TypeGebiedsaanwijzing) niet toegestaan. (voor AMvB/MR).'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_1850================================================================================================================ -->    
    
    <sch:pattern id="TPOD1850" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1850'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-regelstructuur"/>
        <sch:param name="CONDITION" value="string-length(foo:CheckFouteConstructiesTPOD_1850(.))=0"/>
        <sch:param name="context" value="//r:Regeltekst"/>
        <sch:param name="idf" value="string(r:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Alle Juridische regels binnen één Regeltekst moeten van hetzelfde type zijn, respectievelijk; RegelVoorIedereen, Instructieregel of Omgevingswaarderegel.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD1860_a" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1860'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="not(r:gerelateerdeRegeltekst/r:RegeltekstRef/@xlink:href eq r:identificatie)"/>
        <sch:param name="context" value="//r:Regeltekst"/>
        <sch:param name="idf" value="string(r:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD1860_b" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1860'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="not(rol:gerelateerdeActiviteit/rol:ActiviteitRef/@xlink:href eq rol:identificatie)"/>
        <sch:param name="context" value="//rol:Activiteit"/>
        <sch:param name="idf" value="string(rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD1860_c" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1860'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="contains(foo:getIdentifiersTPOD_1860($xmlDocuments//r:Regeltekst/r:identificatie), concat('.',string(@xlink:href),'.'))"/>
        <sch:param name="context" value="//r:artikelOfLid/r:RegeltekstRef"/>
        <sch:param name="idf" value="string(../../r:artikelOfLid/r:RegeltekstRef/@xlink:href)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD1860_d" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1860'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="contains(foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Activiteit/rol:identificatie), concat('.',string(@xlink:href),'.'))"/>
        <sch:param name="context" value="//r:RegelVoorIedereen/r:activiteitaanduiding/rol:ActiviteitRef"/>
        <sch:param name="idf" value="string(../../r:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.'"></sch:param>
        <sch:param name="melding" value="concat(': ',string(@xlink:href))"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD1860_e" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1860'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="contains(foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Omgevingsnorm/rol:identificatie), concat('.',string(@xlink:href),'.'))"/>
        <sch:param name="context" value="//r:omgevingsnormaanduiding/rol:OmgevingsnormRef"/>
        <sch:param name="idf" value="string(../../r:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.'"></sch:param>
        <sch:param name="melding" value="concat(': ',string(@xlink:href))"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD1860_f" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1860'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="contains(foo:getIdentifiersTPOD_1860($xmlDocuments//ga:Gebiedsaanwijzing/ga:identificatie), concat('.',string(@xlink:href),'.'))"/>
        <sch:param name="context" value="//r:gebiedsaanwijzing/ga:GebiedsaanwijzingRef"/>
        <sch:param name="idf" value="string(../../r:artikelOfLid/r:RegeltekstRef/@xlink:href)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.'"></sch:param>
        <sch:param name="melding" value="concat(': ',string(@xlink:href))"/>
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD1860_g" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1860'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="contains(foo:getIdentifiersTPOD_1860($xmlDocuments//rol:Activiteit/rol:identificatie), concat('.',string(@xlink:href),'.'))"/>
        <sch:param name="context" value="//rol:gerelateerdeActiviteit/rol:ActiviteitRef"/>
        <sch:param name="idf" value="string(../../rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.'"></sch:param>
        <sch:param name="melding" value="concat(': ',string(@xlink:href))"/>
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD1860_h" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1860'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="contains(foo:getLocationIdentifiersTPOD_1860(), concat('.',string(@xlink:href),'.'))"/>
        <sch:param name="context" value="//l:LocatieRef | l:GebiedRef | l:GebiedengroepRef | l:PuntRef | l:PuntengroepRef | l:LijnengroepRef | l:LijnRef"/>
        <sch:param name="idf" value="string(../../*:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.'"></sch:param>
        <sch:param name="melding" value="concat(': ',string(@xlink:href))"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
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
    
    <sch:pattern id="TPOD1870" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1870'"/>
        <sch:param name="businessRuleGroup" value="$Regelstructuur_OZON"/>
        <sch:param name="CONDITION" value="contains(foo:getRegelTekstIdentifiersTPOD_1870(), concat('.',r:RegeltekstRef/@xlink:href,'.'))"/>
        <sch:param name="context" value="//r:artikelOfLid"/>
        <sch:param name="idf" value="string(r:RegeltekstRef/@xlink:href)"></sch:param>
        <sch:param name="nameidf" value="'RegeltekstRef'"></sch:param>
        <sch:param name="regel" value="'Een verwijzing naar ArtikelOfLid moet verwijzen naar een bestaand artikel of lid.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
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
    
    <sch:pattern id="TPOD1880" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1880'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="not($Waterschapsverordening)"/>
        <sch:param name="context" value="//(rol:Omgevingswaarde|r:Omgevingswaarderegel)"/>
        <sch:param name="idf" value="string(rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'De IMOW-objecten \&quot;Omgevingswaarde$=\&quot; zijn niet van toepassing op de Waterschapsverordening.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_1890================================================================================================================ -->    
    
    <sch:pattern id="TPOD1890" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1890'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="contains(text(), concat('.', foo:CheckFouteIdentifierTPOD_1890(.), '.'))"/>
        <sch:param name="context" value="//*:identificatie"/>
        <sch:param name="idf" value="string(.)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'De identificatie van het OwObject moet de naam van het OwObject-element zelf bevatten, en in het geval van een Juridische regel, de term juridischeregel.'"></sch:param>
        <sch:param name="melding" value="concat(': ', local-name(..))"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD1910" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1910'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="contains(foo:owObjectenLijstTPOD_1910(.), concat('.',text(),'.'))"/>
        <sch:param name="context" value="//sl:objectTypen/sl:objectType"/>
        <sch:param name="idf" value="string(.)"></sch:param>
        <sch:param name="nameidf" value="'objectType'"></sch:param>
        <sch:param name="regel" value="'De objecttypen in ow-dc:owBestand/sl:standBestand/sl:inhoud/sl:objectTypen dienen overeen te komen met de daadwerkelijke objecten in het betreffende Ow-bestand.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD1920" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1920'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:notfoundFileOrObjectTypeTPOD_1920(ow-manifest:naam,.)) = 0"/>
        <sch:param name="context" value="/ow-manifest:Aanleveringen/ow-manifest:Aanlevering/ow-manifest:Bestand"/>
        <sch:param name="idf" value="string(concat(ow-manifest:objecttype,': ',ow-manifest:naam))"></sch:param>
        <sch:param name="nameidf" value="'objecttype'"></sch:param>
        <sch:param name="regel" value="'De objecttypen in manifest-ow dienen overeen te komen met de objecttypen in het betreffende Ow-bestand.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD1930" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1930'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:notFoundTPOD_1930(.)) = 0"/>
        <sch:param name="context" value="//l:Gebiedengroep/l:groepselement"/>
        <sch:param name="idf" value="string(../l:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een OwObject in een Gebiedengroep moet een bestaand (ander) OwObject van het type Gebied zijn.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD1940" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1940'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:notFoundTPOD_1940(.)) = 0"/>
        <sch:param name="context" value="//l:Puntengroep/l:groepselement"/>
        <sch:param name="idf" value="string(../l:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een OwObject in een Puntengroep moet een bestaand (ander) OwObject van het type Punt zijn.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD1950" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1950'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:notFoundTPOD_1950(.)) = 0"/>
        <sch:param name="context" value="//l:Lijnengroep/l:groepselement"/>
        <sch:param name="idf" value="string(../l:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een OwObject in een Puntengroep moet een bestaand (ander) OwObject van het type Punt zijn.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD1960" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1960'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="foo:testGeometrie_1960(.)"/>
        <sch:param name="context" value="//l:Lijn/l:geometrie/l:GeometrieRef"/>
        <sch:param name="idf" value="string(../../l:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een gmlObject vanuit een Lijn moet een lijn-geometrie zijn.'"></sch:param>
        <sch:param name="melding" value="concat(', ',@xlink:href)"/>         
        <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <xsl:function name="foo:testGeometrie_1960"  as="xs:boolean" >
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="found">
            <xsl:for-each select="$gmlDocuments//basisgeo:Geometrie">
                <xsl:choose>
                    <xsl:when test="basisgeo:id/text() = string($context/@xlink:href)">
                        <xsl:choose>
                            <xsl:when test="not(.//gml:MultiPoint || .//gml:Point || .//gml:MultiSurface)">
                                <xsl:value-of select="1"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="0"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="0"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$found > 0"/>
    </xsl:function>
    
    <!-- ============TPOD_1970================================================================================================================ -->    
    
    <sch:pattern id="TPOD1970" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1970'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="foo:testGeometrie_1970(.)"/>
        <sch:param name="context" value="//l:Punt/l:geometrie/l:GeometrieRef"/>
        <sch:param name="idf" value="string(../../l:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een gmlObject vanuit een Punt moet een punt-geometrie zijn.'"></sch:param>
        <sch:param name="melding" value="concat(', ',@xlink:href)"/>         
        <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <xsl:function name="foo:testGeometrie_1970"  as="xs:boolean" >
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="found">
            <xsl:for-each select="$gmlDocuments//basisgeo:Geometrie">
                <xsl:choose>
                    <xsl:when test="basisgeo:id/text() = string($context/@xlink:href)">
                        <xsl:choose>
                            <xsl:when test="(.//gml:MultiPoint || .//gml:Point)">
                                <xsl:value-of select="1"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="0"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="0"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$found > 0"/>
    </xsl:function>
    
    <!-- ============TPOD_1980================================================================================================================ -->
    
    <sch:pattern id="TPOD1980" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1980'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="foo:calculateConditionTPOD_1980(string(@xlink:href)) = 1"/>
        <sch:param name="context" value="//l:Gebied/l:geometrie/l:GeometrieRef"/>
        <sch:param name="idf" value="string(../../l:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een gmlObject vanuit een Gebied moet een gebied-geometrie zijn.'"></sch:param>
        <sch:param name="melding" value="concat(', ',@xlink:href)"/>
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD1990a" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1990'"/>
        <sch:param name="businessRuleGroup" value="$Regelstructuur_OZON"/>
        <sch:param name="CONDITION" value="string-length(foo:nietGerefereerdeGeometrieTPOD_1990(foo:getLocationGeoReferenceIdentifiersTPOD_1990(), .)) = 0"/>
        <sch:param name="context" value="//basisgeo:Geometrie"/>
        <sch:param name="idf" value="string(basisgeo:id/text())"></sch:param>
        <sch:param name="nameidf" value="'id'"></sch:param>
        <sch:param name="regel" value="'Iedere Geometrie heeft minstens een OwObject dat ernaar verwijst.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD1990b" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1990'"/>
        <sch:param name="businessRuleGroup" value="$Regelstructuur_OZON"/>
        <sch:param name="CONDITION" value="string-length(foo:nietGerefereerdeReferentiesTPOD_1990(foo:getReferencesTPOD_1990($xmlDocuments//r:RegeltekstRef), .)) = 0"/>
        <sch:param name="context" value="//r:Regeltekst/r:identificatie"/>
        <sch:param name="idf" value="string(substring(foo:nietGerefereerdeReferentiesTPOD_1990(foo:getReferencesTPOD_1990($xmlDocuments//r:RegeltekstRef), .),1,string-length(foo:nietGerefereerdeReferentiesTPOD_1990(foo:getReferencesTPOD_1990($xmlDocuments//r:RegeltekstRef), .))-2))"></sch:param>
        <sch:param name="nameidf" value="'id'"></sch:param>
        <sch:param name="regel" value="'Iedere Regeltekst heeft minstens een OwObject dat ernaar verwijst.'"></sch:param>
        <sch:param name="melding" value="''"/>
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD1990c" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1990'"/>
        <sch:param name="businessRuleGroup" value="$Regelstructuur_OZON"/>
        <sch:param name="CONDITION" value="string-length(foo:nietGerefereerdeReferentiesTPOD_1990(foo:getReferencesTPOD_1990($xmlDocuments//(vt:DivisieRef|vt:HoofdlijnRef)), .)) = 0"/>
        <sch:param name="context" value="//(vt:Divisie|vt:Hoofdlijn)/vt:identificatie"/>
        <sch:param name="idf" value="string(substring(foo:nietGerefereerdeReferentiesTPOD_1990(foo:getReferencesTPOD_1990($xmlDocuments//(vt:DivisieRef|vt:HoofdlijnRef)), .),1,string-length(foo:nietGerefereerdeReferentiesTPOD_1990(foo:getReferencesTPOD_1990($xmlDocuments//(vt:DivisieRef|vt:HoofdlijnRef)), .))-2))"></sch:param>
        <sch:param name="nameidf" value="'id'"></sch:param>
        <sch:param name="regel" value="'Iedere Divisie of Hoofdlijn heeft minstens een OwObject dat ernaar verwijst.'"></sch:param>
        <sch:param name="melding" value="''"/>        
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD1990d" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1990'"/>
        <sch:param name="businessRuleGroup" value="$Regelstructuur_OZON"/>
        <sch:param name="CONDITION" value="string-length(foo:nietGerefereerdeReferentiesTPOD_1990(foo:getReferencesTPOD_1990($xmlDocuments//rol:ActiviteitRef), .)) = 0"/>
        <sch:param name="context" value="//rol:Activiteit/rol:identificatie"/>
        <sch:param name="idf" value="string(substring(foo:nietGerefereerdeReferentiesTPOD_1990(foo:getReferencesTPOD_1990($xmlDocuments//rol:ActiviteitRef), .),1,string-length(foo:nietGerefereerdeReferentiesTPOD_1990(foo:getReferencesTPOD_1990($xmlDocuments//rol:ActiviteitRef), .))-2))"></sch:param>
        <sch:param name="nameidf" value="'id'"></sch:param>
        <sch:param name="regel" value="'Iedere Activiteit-aanduiding heeft minstens een OwObject dat ernaar verwijst.'"></sch:param>
        <sch:param name="melding" value="''"/>
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <sch:pattern id="TPOD1990e" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD1990'"/>
        <sch:param name="businessRuleGroup" value="$Regelstructuur_OZON"/>
        <sch:param name="CONDITION" value="string-length(foo:getLocationReferenceIdentifiersTPOD_1990(text())) > 0"/>
        <sch:param name="context" value="//l:identificatie"/>
        <sch:param name="idf" value="string(text())"></sch:param>
        <sch:param name="nameidf" value="'id'"></sch:param>
        <sch:param name="regel" value="'Iedere Locatie-aanduiding heeft minstens een OwObject dat ernaar verwijst.'"></sch:param>
        <sch:param name="melding" value="''"/>
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
        
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
        <xsl:param name="id"/>
        <xsl:variable name="identifiers">
            <xsl:for-each
                select="$xmlDocuments//(l:LocatieRef | l:GebiedRef | l:LijnRef | l:PuntRef | l:GebiedengroepRef | l:PuntengroepRef | l:LijnengroepRef)">
                <xsl:if test="string(@xlink:href)=$id">
                    <xsl:value-of select="string(@xlink:href)"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$identifiers"/>
    </xsl:function>
    
    <!-- ============TPOD_2000================================================================================================================ -->
    
    <sch:pattern id="TPOD2000" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2000'"/>
        <sch:param name="businessRuleGroup" value="$Regelstructuur"/>
        <sch:param name="CONDITION" value="string-length(foo:checkWIdTPOD_2000(@wId)) > 0"/>
        <sch:param name="context" value="//r:Regeltekst"/>
        <sch:param name="idf" value="string(@wId)"></sch:param>
        <sch:param name="nameidf" value="'wId'"></sch:param>
        <sch:param name="regel" value="'Het wId van de Regeltekst in OW moet verwijzen naar een bestaande wId van een Artikel of Lid in OP.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD2040" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD2040'"/>
        <sch:param name="businessRuleGroup" value="$Vrijetekststructuur_OZON"/>
        <sch:param name="CONDITION" value="string-length(foo:checkWIdTPOD_2040(@wId)) > 0"/>
        <sch:param name="context" value="//vt:Divisie"/>
        <sch:param name="idf" value="string(@wId)"></sch:param>
        <sch:param name="nameidf" value="'wId'"></sch:param>
        <sch:param name="regel" value="'Het wId van de Divisie in OW moet verwijzen naar een bestaande wId van een Divisie in OP.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
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
    
    <sch:pattern id="TPOD2050" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2050'"/>
        <sch:param name="businessRuleGroup" value="$OP-implementatie-niet-Rijk"/>
        <sch:param name="CONDITION" value="string-length(foo:existsTPOD_2050()) = 0"/>
        <sch:param name="context" value="//aanlevering:AanleveringBesluit"/>
        <sch:param name="idf" value="string(foo:existsTPOD_2050())"></sch:param>
        <sch:param name="nameidf" value="'resultaat'"></sch:param>
        <sch:param name="regel" value="'Controleren of het manifest-ow en het manifest bestaan, en de bestanden benoemd in de manifest-bestanden aanwezig zijn.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD2060" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2060'"/>
        <sch:param name="businessRuleGroup" value="$Regelstructuur"/>
        <sch:param name="CONDITION" value="string-length(foo:checkFouteArtikelLidCombinatieTPOD_2060(.)) = 0"/>
        <sch:param name="context" value="//tekst:Artikel"/>
        <sch:param name="idf" value="string(@wId)"></sch:param>
        <sch:param name="nameidf" value="'wId'"></sch:param>
        <sch:param name="regel" value="'Als er een Regeltekst van een Lid is gemaakt mag er geen Regeltekst meer gemaakt worden van het Artikel dat boven dit Lid hangt.'"></sch:param>
        <sch:param name="melding" value="concat(': ',foo:checkFouteArtikelLidCombinatieTPOD_2060(.))"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD2080" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2080'"/>
        <sch:param name="businessRuleGroup" value="$Regelstructuur"/>
        <sch:param name="CONDITION" value="(r:instructieregelTaakuitoefening or r:instructieregelInstrument) and not(r:instructieregelTaakuitoefening and r:instructieregelInstrument) and not(not(r:instructieregelTaakuitoefening) and not(r:instructieregelInstrument))"/>
        <sch:param name="context" value="//r:Instructieregel"/>
        <sch:param name="idf" value="string(r:artikelOfLid/r:RegeltekstRef/@xlink:href)"></sch:param>
        <sch:param name="nameidf" value="'id'"></sch:param>
        <sch:param name="regel" value="'Binnen een instructieregel dient er gekozen te worden tussen InstructieregelInstrument of InstructieregelTaakuitoefening (één van de twee moet voorkomen).'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_2090================================================================================================================ -->
    
    <sch:pattern id="TPOD2090" is-a="abstractPatternWarning">
        <sch:param name="code" value="'TPOD2090'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="
            count(rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde)=count(rol:normwaarde/rol:Normwaarde/(rol:kwalitatieveWaarde|rol:kwantitatieveWaarde|rol:waardeInRegeltekst)) 
            or count(rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde)=count(rol:normwaarde/rol:Normwaarde/(rol:kwalitatieveWaarde|rol:kwantitatieveWaarde|rol:waardeInRegeltekst)) 
            or count(rol:normwaarde/rol:Normwaarde/rol:waardeInRegeltekst)=count(rol:normwaarde/rol:Normwaarde/(rol:kwalitatieveWaarde|rol:kwantitatieveWaarde|rol:waardeInRegeltekst))"/>
        <sch:param name="context" value="//rol:Omgevingsnorm"/>
        <sch:param name="idf" value="string(rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Alle normwaarden van een norm moeten hetzelfde type zijn (kwalitatief, kwantitatief, of waardeInRegeltekst).'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_2100================================================================================================================ -->
    
    <sch:pattern id="TPOD2100" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2100'"/>
        <sch:param name="businessRuleGroup" value="$Regelstructuur"/>
        <sch:param name="CONDITION" value="../rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde[1]"/>
        <sch:param name="context" value="//rol:Omgevingsnorm/rol:eenheid"/>
        <sch:param name="idf" value="string(../rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Eenheid mag alleen voorkomen bij een Norm met de normwaarden van het type kwantitatief.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_2110================================================================================================================ -->
    
    <sch:pattern id="TPOD2110" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2110'"/>
        <sch:param name="businessRuleGroup" value="$Vrijetekststructuur"/>
        <sch:param name="CONDITION" value="(vt:idealisatie and vt:locatieaanduiding) or (not(vt:idealisatie) and not(vt:locatieaanduiding))"/>
        <sch:param name="context" value="//vt:Tekstdeel"/>
        <sch:param name="idf" value="string(vt:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Idealisatie (bij Tekstdeel) is verplicht als Tekstdeel een locatie heeft.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_2120================================================================================================================ -->
    
    <sch:pattern id="TPOD2120" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2120'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:vindDubbeleTPOD_2120(text())) = 0"/>
        <sch:param name="context" value="//*:identificatie"/>
        <sch:param name="idf" value="string(text())"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere OW-identificatie dient slechts 1 keer voor te komen per aanlevering (c.q. je mag niet binnen dezelfde aanlevering een ID aanmaken, en vervolgens het ID wijzigen).'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD2130" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2130'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:vindDubbeleTPOD_2130(string(@xlink:href), ../../l:identificatie/text())[1]) = 0"/>
        <sch:param name="context" value="//l:GeometrieRef"/>
        <sch:param name="idf" value="string(../../l:identificatie/text())"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Er zijn meerdere locaties die naar 1 geometrie verwijzen (altijd 1 locatie per geometrie toegestaan).'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD2140" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2140'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:checkWorkIdRegelingTPOD_2140(text())) > 0"/>
        <sch:param name="context" value="//ow-manifest:WorkIDRegeling"/>
        <sch:param name="idf" value="string(text())"></sch:param>
        <sch:param name="nameidf" value="'workId'"></sch:param>
        <sch:param name="regel" value="'Eet WorkIDRegeling van het manifest in OW moet verwijzen naar een bestaande FRBRWork in een Regelingversie in OP.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD2150" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2150'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="string-length(foo:checkDoelIdTPOD_2150(text())) > 0"/>
        <sch:param name="context" value="//ow-manifest:DoelID"/>
        <sch:param name="idf" value="string(text())"></sch:param>
        <sch:param name="nameidf" value="'id'"></sch:param>
        <sch:param name="regel" value="'Het DoelID van het manifest-ow moet verwijzen naar een bestaand doel dat aanwezig is in de bijbehorende Regeling in OP.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
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
    
    <sch:pattern id="TPOD2160" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2160'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="count(ow-manifest:DoelID) = 1"/>
        <sch:param name="context" value="//ow-manifest:Aanlevering"/>
        <sch:param name="idf" value="string(ow-manifest:DoelID/text())"></sch:param>
        <sch:param name="nameidf" value="'DoelID'"></sch:param>
        <sch:param name="regel" value="'In het manifest-ow mag maar voor 1 doel aangeleverd worden.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_2170================================================================================================================ -->
    
    <sch:pattern id="TPOD2170" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2170'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="count(rol:Normwaarde/rol:waardeInRegeltekst) &lt; 2"/>
        <sch:param name="context" value="//(rol:Omgevingswaarde|rol:Omgevingsnorm)/rol:normwaarde"/>
        <sch:param name="idf" value="string(../rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Indien de normwaarde van het type \&quot;waardeInRegeltekst\&quot; is, mag er maar één normwaarde voorkomen.'"></sch:param>
        <sch:param name="melding" value="''"/>         <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============TPOD_2180================================================================================================================ -->
    
    <!-- Het is lastig een fout te triggeren op iets dat niet voorkomt, en je wilt het maar een keer testen.
    Daarom heb ik gekozen voor het manifest-ow dat maar een keer voorkomt, en dan op die plaats te controleren of ergens in een xml-document 
    Een regelingsgebied is gedeclareerd.
    Nu gaat deze validatie de mist in als het manifest-ow niet voorkomt, maar dan hebben we nog wel meer problemen.
    -->
    <sch:pattern id="TPOD2180" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2180'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="count($xmlDocuments//rg:Regelingsgebied) = 1"/>
        <sch:param name="context" value="//aanlevering:AanleveringBesluit"/>
        <sch:param name="idf" value="string(Regelingsgebied)"></sch:param>
        <sch:param name="nameidf" value="'Betreft'"></sch:param>
        <sch:param name="regel" value="'Het Regelingsgebied is niet aangetroffen.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>

    <!-- ============TPOD_2190================================================================================================================ -->
    
    <sch:pattern id="TPOD2190" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2190'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//ow-manifest:Aanleveringen/ow-manifest:Aanlevering/ow-manifest:Bestand[ow-manifest:objecttype[1]/text() eq 'Geometrie']"/>
        <sch:param name="idf" value="string(ow-manifest:naam/text())"></sch:param>
        <sch:param name="nameidf" value="'naam'"></sch:param>
        <sch:param name="regel" value="'In het manifest-OW mag het objecttype Geometrie niet voorkomen.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    
    <!-- ============TPOD_2200================================================================================================================ -->
    
    <sch:pattern id="TPOD2200" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD2200'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek"/>
        <sch:param name="CONDITION" value="false()"/>
        <sch:param name="context" value="//ow-manifest:Aanleveringen/ow-manifest:Aanlevering/ow-manifest:Bestand[ends-with(ow-manifest:naam[1]/text(), '.gml')]"/>
        <sch:param name="idf" value="string(ow-manifest:naam/text())"></sch:param>
        <sch:param name="nameidf" value="'naam'"></sch:param>
        <sch:param name="regel" value="'In het manifest-OW mag een bestandsnaam niet eindigen op \&quot;.gml\&quot;.'"></sch:param>
        <sch:param name="melding" value="''"/>         
        <sch:param name="waarschuwing" value="''"/>
    </sch:pattern>
    
    <!-- ============ABSTRACT PATTERN================================================================================================================ -->
    
    <sch:pattern id="abstractPatternError" abstract="true">
        <sch:rule context="$context">
            <sch:assert test="($businessRuleGroup and $CONDITION) or not($businessRuleGroup)" role="error"> 
                { 
                "code": "<sch:value-of
                    select="$code"/>", 
                "ernst": "Blokkerend", 
                "<sch:value-of
                    select="$nameidf"/>": "<sch:value-of select="$idf"/>", 
                "bestandsnaam":
                "<sch:value-of select="base-uri(.)"/>", 
                "regel": "<sch:value-of select="$regel"/>",
                "melding": "Dit is niet het geval bij <sch:value-of select="$nameidf"/>: <sch:value-of select="$idf"/><sch:value-of select="$melding"/>",
                "waarschuwing":  "<sch:value-of select="$waarschuwing"/>"           
                }, 
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern id="abstractPatternWarning" abstract="true">
        <sch:rule context="$context">
            <sch:assert test="($businessRuleGroup and $CONDITION) or not($businessRuleGroup)" role="warning"> 
                { 
                "code": "<sch:value-of
                    select="$code"/>", 
                "ernst": "Waarschuwing", 
                "<sch:value-of
                    select="$nameidf"/>": "<sch:value-of select="$idf"/>", 
                "bestandsnaam":
                "<sch:value-of select="base-uri(.)"/>", 
                "regel": "<sch:value-of select="$regel"/>",
                "melding": "Dit is niet het geval bij <sch:value-of select="$nameidf"/>: <sch:value-of select="$idf"/><sch:value-of select="$melding"/>",
                "waarschuwing":  "<sch:value-of select="$waarschuwing"/>"           
                }, 
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>
