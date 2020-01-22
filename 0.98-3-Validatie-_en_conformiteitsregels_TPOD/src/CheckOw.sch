<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
    xmlns:r="http://www.geostandaarden.nl/imow/regels/v20190901"
    xmlns:owo="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
    xmlns:ow="http://www.geostandaarden.nl/imow/owobject/v20190709"
    xmlns:rol="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901"
    xmlns:rol-ref="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="http://whatever">

    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="owo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/owobject/v20190709" prefix="ow"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901" prefix="rol"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709" prefix="rol-ref"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    
    <sch:pattern id="TPOD1650">
        <sch:rule context="/owo:owBestand/sl:standBestand/sl:stand/owo:owObject/rol:Omgevingswaarde">
            <sch:assert test="(rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde or rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde) and 
                not(rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde and rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde)"> H:TPOD1650: 
                Het attribuut 'normwaarde' moet bestaan uit één van de twee mogelijke attributen; 'kwalitatieveWaarde' óf 'kwantitatieveWaarde'.
                </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern id="TPOD1630">
        <sch:rule context="/owo:owBestand/sl:standBestand/sl:stand/owo:owObject/r:Instructieregel">
            <sch:assert test="(r:instructieregelInstrument or r:instructieregelTaakuitoefening) and 
                not(r:instructieregelInstrument and r:instructieregelTaakuitoefening)"> H:TPOD1630: 
                Het attribuut 'instructieregelTaakuitoefening' binnen het object 'Instructieregel' is verplicht wanneer Instructieregel gaat over de uitoefening van een taak.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="TPOD1670">
        <sch:rule context="/owo:owBestand/sl:standBestand/sl:stand/owo:owObject/r:RegelVoorIedereen">
            <sch:assert test="  
                (r:activiteitaanduiding) or
                (not(r:activiteitaanduiding) and not(r:activiteitregelkwalificatie))"> H:TPOD1670: 
                Activiteitregelkwalificatie is alleen te gebruiken wanneer het object ‘Regel voor iedereen’ is geannoteerd met Activiteit.
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern id="Regeltekst_ids">
        <!-- Controleren of OwObjecten een geldige regelTekstId verwijzing hebben. -->
        <sch:rule context="/owo:owBestand/sl:standBestand/sl:stand/owo:owObject/*">
            <sch:let name="regeltekstId" value="@ow:regeltekstId"/>
            <sch:let name="itemname" value="./name()"/>
            <xsl:variable name="regeltekstIds">
                <xsl:for-each
                    select="//sl:standBestand/sl:stand/owo:owObject/r:Regeltekst/r:identificatie">
                    <xsl:value-of select="."/>
                </xsl:for-each>
            </xsl:variable>
            <sch:assert test="contains($regeltekstIds, $regeltekstId)"> ZH::OW:T:Regeltekstnummer
                    <sch:value-of select="$regeltekstId"/> in <sch:value-of select="$itemname"/>
                heeft geen bijbehorend regeltekst-object </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern id="TPOD1700_TPOD1710">
        <!-- Er wordt uitgegaan van een maximale diepte van Ow-Activiteiten-hierarchie binnen een besluit context van 6 lagen (in werkelijkheid komen er
            in een OW-set maar enkele lagen van hierarchie voor voordat er naar een functionele structuur wordt verwezen).
            
            Waarom niet in een functie?
            Dit kan eventueel ook binnen een recursieve functie worden gedaan, maar dan moet er worden gecontroleerd op circulaire structuren, 
            dat veroorzaakt extra code, binnen schematron een ingewikkeld algoritme, de functie kan in latere optimalisatie worden geschreven.
        -->
        <sch:rule context="/owo:owBestand/sl:standBestand">
            <!-- de activiteitenlijst bevat alle activiteiten ids -->
            <xsl:variable name="activiteitenLijst">
                <xsl:for-each select="sl:stand/owo:owObject/rol:Activiteit">
                    <xsl:value-of select="rol:identificatie"/>
                </xsl:for-each>
            </xsl:variable>
            <!-- Uiteindelijk bevatten de offendingIds activiteiten die circulair over andere activiteiten naar zichzelf verwijzen -->
            <xsl:variable name="circulaireActivititeiten">
                <xsl:for-each select="sl:stand/owo:owObject/rol:Activiteit">
                    <xsl:variable name="bovenLiggend"
                        select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                    <xsl:variable name="identificatie" select="rol:identificatie"/>
                    <!-- hier worden de activiteiten uitgefilterd waarvan de bovenliggende activiteiten in de functionele structuur zitten -->
                    <xsl:if test="contains($activiteitenLijst, $bovenLiggend)">
                        <xsl:variable name="i1" select="$identificatie"/>
                        <xsl:for-each select="../../../sl:stand/owo:owObject/rol:Activiteit">
                            <xsl:if
                                test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $i1">
                                <xsl:variable name="i2" select="rol:identificatie"/>
                                <xsl:if test="$identificatie = $i2">
                                    <xsl:value-of select="concat($i2, ', ')"/>
                                </xsl:if>
                                <xsl:for-each select="../../../sl:stand/owo:owObject/rol:Activiteit">
                                    <xsl:if
                                        test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $i2">
                                        <xsl:variable name="i3" select="rol:identificatie"/>
                                        <xsl:if test="$identificatie = $i3">
                                            <xsl:value-of select="concat($i3, ', ')"/>
                                        </xsl:if>
                                        <xsl:for-each
                                            select="../../../sl:stand/owo:owObject/rol:Activiteit">
                                            <xsl:if
                                                test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $i3">
                                                <xsl:variable name="i4" select="rol:identificatie"/>
                                                <xsl:if test="$identificatie = $i4">
                                                    <xsl:value-of select="concat($i4, ', ')"/>
                                                </xsl:if>
                                                <xsl:for-each
                                                    select="../../../sl:stand/owo:owObject/rol:Activiteit">
                                                    <xsl:if
                                                        test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $i4">
                                                        <xsl:variable name="i5" select="rol:identificatie"/>
                                                        <xsl:if test="$identificatie = $i5">
                                                            <xsl:value-of select="concat($i5, ', ')"/>
                                                        </xsl:if>
                                                        <xsl:for-each
                                                            select="../../../sl:stand/owo:owObject/rol:Activiteit">
                                                            <xsl:if
                                                                test="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href = $i5">
                                                                <xsl:variable name="i6" select="rol:identificatie"/>
                                                                <xsl:if test="$identificatie = $i6">
                                                                    <xsl:value-of select="concat($i6, ', ')"/>
                                                                </xsl:if>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <!-- Omdat de offendingIds circuliaire verwijzingen zijn worden ze niet gebruikt bij de volgende test waarbij gekeken wordt of iedere activiteit
            uiteindelijk bij een functionele activiteit uitkomt -->
            <xsl:variable name="activiteitenTrajectNaarFunctioneleStructuur">
                <xsl:for-each select="sl:stand/owo:owObject/rol:Activiteit">
                    <xsl:variable name="identificatie" select="rol:identificatie"/>
                    <xsl:variable name="bl1"
                        select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                    <!-- hier worden de activiteiten uitgefilterd waarvan de bovenliggende activiteiten in de functionele structuur zitten -->
                    <xsl:if test="not(contains($circulaireActivititeiten, $identificatie))">
                        <xsl:choose>
                            <xsl:when test="not(contains($activiteitenLijst, $bl1))">
                                <xsl:value-of select="concat($identificatie, ', ')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each select="../../../sl:stand/owo:owObject/rol:Activiteit">
                                    <xsl:if test="rol:identificatie = $bl1">
                                        <xsl:variable name="bl2"
                                            select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                                        <xsl:choose>
                                            <xsl:when test="not(contains($activiteitenLijst, $bl2))">
                                                <xsl:value-of select="concat($identificatie, ', ')"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:for-each
                                                    select="../../../sl:stand/owo:owObject/rol:Activiteit">
                                                    <xsl:if test="rol:identificatie = $bl2">
                                                        <xsl:variable name="bl3"
                                                            select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                                                        <xsl:choose>
                                                            <xsl:when
                                                                test="not(contains($activiteitenLijst, $bl3))">
                                                                <xsl:value-of select="concat($identificatie, ', ')"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:for-each
                                                                    select="../../../sl:stand/owo:owObject/rol:Activiteit">
                                                                    <xsl:if test="rol:identificatie = $bl3">
                                                                        <xsl:variable name="bl4"
                                                                            select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                                                                        <xsl:choose>
                                                                            <xsl:when
                                                                                test="not(contains($activiteitenLijst, $bl4))">
                                                                                <xsl:value-of select="concat($identificatie, ', ')"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:for-each
                                                                                    select="../../../sl:stand/owo:owObject/rol:Activiteit">
                                                                                    <xsl:if test="rol:identificatie = $bl4">
                                                                                        <xsl:variable name="bl5"
                                                                                            select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                                                                                        <xsl:choose>
                                                                                            <xsl:when
                                                                                                test="not(contains($activiteitenLijst, $bl5))">
                                                                                                <xsl:value-of select="concat($identificatie, ', ')"/>
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                <xsl:for-each
                                                                                                    select="../../../sl:stand/owo:owObject/rol:Activiteit">
                                                                                                    <xsl:if test="rol:identificatie = $bl5">
                                                                                                        <xsl:variable name="bl6"
                                                                                                            select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                                                                                                        <xsl:choose>
                                                                                                            <xsl:when
                                                                                                                test="not(contains($activiteitenLijst, $bl6))">
                                                                                                                <xsl:value-of select="concat($identificatie, ', ')"/>
                                                                                                            </xsl:when>
                                                                                                        </xsl:choose>
                                                                                                    </xsl:if>
                                                                                                </xsl:for-each>
                                                                                            </xsl:otherwise>
                                                                                        </xsl:choose>
                                                                                    </xsl:if>
                                                                                </xsl:for-each>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </xsl:if>
                                                                </xsl:for-each>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <sch:report test="string-length($activiteitenTrajectNaarFunctioneleStructuur) > 0"
                >Activiteit-ids: <sch:value-of select="$activiteitenTrajectNaarFunctioneleStructuur"
                />: ZH:TPOD1700: Voor elke hiërarchie van nieuwe activiteiten geldt dat de hoogste
                activiteit in de hiërarchie een bovenliggende activiteit moet hebben die reeds
                bestaat in de functionele structuur. DIT LAATSTE WORDT NU NOG NIET GETEST
            </sch:report>
            <sch:assert test="string-length($circulaireActivititeiten) = 0">Activiteit-ids:
                    <sch:value-of select="$circulaireActivititeiten"/>: ZH:TP0D930: Een
                bovenliggende activiteit mag niet naar een activiteit verwijzen die lager in de
                hiërarchie ligt.</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
