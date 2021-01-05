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
    <sch:let name="AMvB_MR" value="$SOORT_REGELING=$AMvB or $SOORT_REGELING=$MR"/>
    <sch:let name="Omgevingsplan" value="$SOORT_REGELING=$OP"/>
    <sch:let name="OP-implementatie-GemeentenEnWaterschappen" value="$SOORT_REGELING=$OP or $SOORT_REGELING=$WV"/>
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
    <sch:let name="OP-implementatie-Omgevingsverordening" value="$SOORT_REGELING=$OV"/>
    <sch:let name="OP-implementatie-regelstructuur" value="
        $SOORT_REGELING=$AMvB or 
        $SOORT_REGELING=$MR or 
        $SOORT_REGELING=$OP or 
        $SOORT_REGELING=$OV or 
        $SOORT_REGELING=$WV or 
        $SOORT_REGELING=$VR
        "/>
    <sch:let name="Regelstructuur" value="
        $SOORT_REGELING=$AMvB or 
        $SOORT_REGELING=$MR or 
        $SOORT_REGELING=$OP or 
        $SOORT_REGELING=$OV or 
        $SOORT_REGELING=$WV or 
        $SOORT_REGELING=$VR
        "/>
    <sch:let name="Regelstructuur_OZON" value="
        $SOORT_REGELING=$AMvB or 
        $SOORT_REGELING=$MR or 
        $SOORT_REGELING=$OP or 
        $SOORT_REGELING=$OV or 
        $SOORT_REGELING=$WV or 
        $SOORT_REGELING=$VR
        "/>
    <sch:let name="Vrijetekststructuur" value="
        $SOORT_REGELING=$OVi or
        $SOORT_REGELING=$PB or
        $SOORT_REGELING=$I or
        $SOORT_REGELING=$P or
        $SOORT_REGELING=$RI
        "/>
    <sch:let name="Vrijetekststructuur_OZON" value="
        $SOORT_REGELING=$OVi or
        $SOORT_REGELING=$PB or
        $SOORT_REGELING=$I or
        $SOORT_REGELING=$P or
        $SOORT_REGELING=$RI
        "/>
    <sch:let name="Waterschapsverordening" value="$SOORT_REGELING=$WV"/>
    
    <!-- ============================================================================================================================ -->
	 
    <sch:pattern id="TPOD1860_a" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1860'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="foo:regeltekstReferencesTPOD_1860(.) = 'true'"/>
        <sch:param name="context" value="//r:Regeltekst"/>
        <sch:param name="idf" value="string(r:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.'"></sch:param>
        <sch:param name="melding" value="': een of meer gerelateerde regelteksten verwijzen naar zichzelf of een niet bestaande regeltekst.'"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <xsl:function name="foo:regeltekstReferencesTPOD_1860">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="grandResultValue">
            <xsl:for-each select="$context/r:gerelateerdeRegeltekst/r:RegeltekstRef">
                <xsl:variable name="resultValue">
                <xsl:variable name="href" select="@xlink:href"/>
                <xsl:for-each select="$xmlDocuments//r:Regeltekst/r:identificatie">
                    <xsl:variable name="identificatie" select="."/>
                    <xsl:choose>
                        <xsl:when test="($href eq $identificatie) and not($href eq $context/r:identificatie)">
                            <xsl:value-of select="true()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="false()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="contains($resultValue,'true')">
                        <xsl:value-of select="true()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="false()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="returnValue">
            <xsl:choose>
                <xsl:when test="contains($grandResultValue,'false')">
                    <xsl:value-of select="false()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="true()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$returnValue"/>
    </xsl:function>
    
    <sch:pattern id="TPOD1860_b" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1860'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="foo:activiteitReferencesTPOD_1860(.) = 'true'"/>
        <sch:param name="context" value="//rol:Activiteit"/>
        <sch:param name="idf" value="string(rol:identificatie)"></sch:param>
        <sch:param name="nameidf" value="'identificatie'"></sch:param>
        <sch:param name="regel" value="'Iedere verwijzing naar een ander OwObject moet een bestaand (ander) OwObject zijn.'"></sch:param>
        <sch:param name="melding" value="': een of meer gerelateerde activiteiten verwijzen naar zichzelf of een niet bestaande activiteit.'"/>         
        <sch:param name="waarschuwing" value="'Deze test is op de aangeleverde dataset uitgevoerd, verwijzingen naar DSO data zijn niet onderzocht.'"/>
    </sch:pattern>
    
    <xsl:function name="foo:activiteitReferencesTPOD_1860">
        <xsl:param name="context" as="node()"/>
        <xsl:variable name="grandResultValue">
            <xsl:for-each select="$context/rol:gerelateerdeActiviteit/rol:ActiviteitRef">
                <xsl:variable name="resultValue">
                    <xsl:variable name="href" select="@xlink:href"/>
                    <xsl:for-each select="$xmlDocuments//rol:Activiteit/rol:identificatie">
                        <xsl:variable name="identificatie" select="."/>
                        <xsl:choose>
                            <xsl:when test="($href eq $identificatie) and not($href eq $context/rol:identificatie)">
                                <xsl:value-of select="true()"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="false()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="contains($resultValue,'true')">
                        <xsl:value-of select="true()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="false()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="returnValue">
            <xsl:choose>
                <xsl:when test="contains($grandResultValue,'false')">
                    <xsl:value-of select="false()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="true()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$returnValue"/>
    </xsl:function>
    
    <sch:pattern id="TPOD1860_c" is-a="abstractPatternError">
        <sch:param name="code" value="'TPOD1860'"/>
        <sch:param name="businessRuleGroup" value="$OW-generiek_OZON"/>
        <sch:param name="CONDITION" value="contains(foo:getIdentifiersTPOD_1860($xmlDocuments//r:Regeltekst/r:identificatie), concat('.',string(@xlink:href),'.'))"/>
        <sch:param name="context" value="//r:artikelOfLid/r:RegeltekstRef"/>
        <sch:param name="idf" value="../../r:artikelOfLid/r:RegeltekstRef/@xlink:href"></sch:param>
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
        <sch:param name="idf" value="../../r:identificatie"></sch:param>
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
        <sch:param name="idf" value="../../r:identificatie"></sch:param>
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
        <sch:param name="idf" value="../../r:artikelOfLid/r:RegeltekstRef/@xlink:href"></sch:param>
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
        <sch:param name="idf" value="../../rol:identificatie"></sch:param>
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
        <sch:param name="idf" value="../../*:identificatie"></sch:param>
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

    <sch:include href="../abstract_pattern_error.sch"/>
    <sch:include href="../abstract_pattern_warning.sch"/>
    
</sch:schema>
