<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:r-ref="http://www.geostandaarden.nl/imow/regels-ref/v20190901"
    xmlns:l-ref="http://www.geostandaarden.nl/imow/locatie-ref/v20190901"
    xmlns:l="http://www.geostandaarden.nl/imow/locatie/v20190901"
    xmlns:g-ref="http://www.geostandaarden.nl/imow/geometrie-ref/v20190901"
    xmlns:gml="http://www.opengis.net/gml/3.2"
    xmlns:lvbb="http://www.overheid.nl/2017/lvbb"
    >
    <sch:ns uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901" prefix="ow-dc"/>
    <sch:ns uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
        prefix="sl"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing/v20190709" prefix="ga"/>
    <sch:ns uri="http://whatever" prefix="foo"/>
    <sch:ns uri="http://www.geostandaarden.nl/basisgeometrie/v20190901" prefix="geo"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901" prefix="rol"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709" prefix="rol-ref"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/regels-ref/v20190901" prefix="r-ref"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/vrijetekst/v20190901" prefix="vt"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/kaartrecept/v20190901" prefix="k"/>
    <sch:ns uri="http://www.geostandaarden.nl/imow/pons/v20190901" prefix="p"/>
    
    <xsl:variable name="allDocuments" select="collection('.?select=*.xml')"/>

    <!-- TPOD930_TPOD940 -->
    <sch:pattern id="TPOD930_TPOD940">
        <sch:rule context="$allDocuments/geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie[tokenize(geo:geometrie/*/@srsName, ':')[last()] eq '28992']">
            <xsl:variable name="fouteCoord">
                <xsl:for-each select="foo:posListForCoordinateCheck(.)">
                    <xsl:if test="string-length(substring-after(string(.), '.')) &gt; 3">
                        <xsl:value-of select="concat(text(), ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <sch:assert test="string-length($fouteCoord) = 0"> ZH:TP0D930: Indien gebruik wordt gemaakt
                van EPSG:28992 (=RD new) dan moeten coördinaten in eenheden van meters worden
                opgegeven waarbij de waarde maximaal 3 decimalen achter de komma mag
                bevatten.  Id=<sch:value-of select="geo:id"/>. De coordinaten waarom het gaat staan nu genoemd: <sch:value-of select="$fouteCoord"/></sch:assert>
        </sch:rule>
        <sch:rule context="$allDocuments/geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie[tokenize(geo:geometrie/*/@srsName, ':')[last()] eq '4258']">
            <xsl:variable name="fouteCoord">
                <xsl:for-each select="foo:posListForCoordinateCheck(.)">
                    <xsl:if test="string-length(substring-after(string(.), '.')) &gt; 8">
                        <xsl:value-of select="concat(text(), ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <sch:assert test="string-length($fouteCoord) = 0"> ZH:TP0D930: Indien gebruik wordt gemaakt
                van EPSG:4258 (=ETRS89) dan moeten coördinaten in eenheden van meters worden
                opgegeven waarbij de waarde maximaal 8 decimalen achter de komma mag
                bevatten.  Id=<sch:value-of select="geo:id"/>. De coordinaten waarom het gaat staan nu genoemd: <sch:value-of select="$fouteCoord"/></sch:assert>
        </sch:rule>
        <sch:rule
            context="$allDocuments/geo:FeatureCollectionGeometrie/geo:featureMember/geo:Geometrie/geo:geometrie">
            <xsl:variable name="crs">
                <xsl:for-each select="descendant-or-self::*/@srsName">
                    <xsl:if test="position()=1">
                        <xsl:value-of select="."/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="crsses">
                <xsl:for-each select="descendant-or-self::*/@srsName">
                    <xsl:if test="not($crs=.)">
                        <xsl:value-of select="concat(., ', ')"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <sch:assert test="string-length($crsses) = 0">ZH:TP0D940: Een geometrie moet zijn opgebouwd middels één
                coordinate reference system (crs): EPSG:28992 (=RD new) of EPSG:4258
                (=ETRS89). Id=<sch:value-of select="parent::*/geo:id"/>: </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- TPOD930_TPOD940 Local functions -->
    <xsl:function name="foo:posListForCoordinateCheck">
        <xsl:param name="context" as="node()"/>
        <xsl:for-each select="$context">
            <xsl:for-each select="descendant::gml:posList">
                <xsl:variable name="coordinaten" select="tokenize(normalize-space(text()), ' ')"
                    as="xs:string*"/>
                <xsl:for-each select="$coordinaten">
                    <xsl:element name="pos">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:function>
    
    <!-- TPOD1650 -->
    <sch:pattern id="TPOD1650">
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Omgevingswaarde">
            <sch:assert
                test="
                (rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde or rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde) and
                not(rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde and rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde)"
                > H:TPOD1650: <sch:value-of select="rol:identificatie"/>: Het attribuut 'normwaarde' moet bestaan uit één van de twee mogelijke
                attributen; 'kwalitatieveWaarde' óf 'kwantitatieveWaarde'. </sch:assert>
        </sch:rule>
        <sch:rule context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/rol:Omgevingsnorm">
            <sch:assert
                test="
                (rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde or rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde) and
                not(rol:normwaarde/rol:Normwaarde/rol:kwantitatieveWaarde and rol:normwaarde/rol:Normwaarde/rol:kwalitatieveWaarde)"
                > H:TPOD1650: <sch:value-of select="rol:identificatie"/>: Het attribuut 'normwaarde' moet bestaan uit één van de twee mogelijke
                attributen; 'kwalitatieveWaarde' óf 'kwantitatieveWaarde'. </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- TPOD1670 -->
    <sch:pattern id="TPOD1670">
        <sch:rule
            context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/r:RegelVoorIedereen">
            <sch:assert
                test="(r:activiteitaanduiding) or (not(r:activiteitaanduiding) and not(r:activiteitregelkwalificatie))"
                > H:TPOD1670: behorend bij ArtikelOfLid <sch:value-of select="r:artikelOfLid/r-ref:RegeltekstRef/@xlink:href"/>: Activiteitregelkwalificatie is alleen te gebruiken wanneer het object
                ‘Regel voor iedereen’ is geannoteerd met Activiteit. </sch:assert>
        </sch:rule>
    </sch:pattern>
        
    <!-- TPOD1700_TPOD1710_TPOD1730 -->
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
            <!-- TPOD1700  -->
            <!-- Omdat de offendingIds circuliaire verwijzingen zijn worden ze niet gebruikt bij de volgende test waarbij gekeken wordt of iedere activiteit
            uiteindelijk bij een functionele activiteit uitkomt -->
            <xsl:variable name="activiteitenTrajectNaarFunctioneleStructuur">
                <xsl:variable name="identificatie" select="rol:identificatie"/>
                <xsl:variable name="lokaalBovenliggend"
                    select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                <!-- hier worden de activiteiten uitgefilterd waarvan de bovenliggende activiteiten in de functionele structuur zitten -->
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
            <!-- TPOD1700  -->
            <sch:report test="string-length($activiteitenTrajectNaarFunctioneleStructuur) > 0"
                >REPORT: ZH:TPOD1700: Activiteit-ids: <sch:value-of
                    select="$activiteitenTrajectNaarFunctioneleStructuur"/>: Voor elke hiërarchie
                van nieuwe activiteiten geldt dat de hoogste activiteit in de hiërarchie een
                bovenliggende activiteit moet hebben die reeds bestaat in de functionele structuur.
                DIT LAATSTE WORDT NU NOG NIET GETEST </sch:report>
            <!-- TPOD1710  -->
            <sch:assert test="string-length($circulaireActivititeiten) = 0">ZH:TP0D1710:
                Activiteit-ids: <sch:value-of select="$circulaireActivititeiten"/>: Een
                bovenliggende activiteit mag niet naar een activiteit verwijzen die lager in de
                hiërarchie ligt.</sch:assert>
            <!-- TPOD1730  -->
            <sch:assert
                test="contains($activiteitenLijst, rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef/@xlink:href)"
                >H:TPOD1730: <sch:value-of
                    select="rol:identificatie"/> Betreft verwijzing: 
                <sch:value-of select="rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>: Gerelateerde activiteiten moeten
                bestaan indien er naar verwezen wordt.</sch:assert>
            <!-- TPOD1740  -->
            <sch:report test="not(contains($activiteitenLijst, rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href))"> REPORT: H:TPOD1740: <sch:value-of
                select="rol:identificatie"
            />:  Betreft verwijzing: <sch:value-of select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>: Bovenliggende 
                activiteiten moeten bestaan indien er naar verwezen wordt. DIT LAATSTE WORDT NU NOG
                NIET GETEST</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <!-- TPOD1700_TPOD1710_TPOD1730 -->    
    <sch:pattern id="TPOD1700-TPOD1710-TPOD1730">
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
            <!-- TPOD1700  -->
            <!-- Omdat de offendingIds circuliaire verwijzingen zijn worden ze niet gebruikt bij de volgende test waarbij gekeken wordt of iedere activiteit
            uiteindelijk bij een functionele activiteit uitkomt -->
            <xsl:variable name="activiteitenTrajectNaarFunctioneleStructuur">
                <xsl:variable name="identificatie" select="rol:identificatie"/>
                <xsl:variable name="lokaalBovenliggend"
                    select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>
                <!-- hier worden de activiteiten uitgefilterd waarvan de bovenliggende activiteiten in de functionele structuur zitten -->
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
            <!-- TPOD1700  -->
            <sch:report test="string-length($activiteitenTrajectNaarFunctioneleStructuur) > 0"
                >REPORT: ZH:TPOD1700: Activiteit-ids: <sch:value-of
                    select="$activiteitenTrajectNaarFunctioneleStructuur"/>: Voor elke hiërarchie
                van nieuwe activiteiten geldt dat de hoogste activiteit in de hiërarchie een
                bovenliggende activiteit moet hebben die reeds bestaat in de functionele structuur.
                DIT LAATSTE WORDT NU NOG NIET GETEST </sch:report>
            <!-- TPOD1710  -->
            <sch:assert test="string-length($circulaireActivititeiten) = 0">ZH:TP0D1710:
                Activiteit-ids: <sch:value-of select="$circulaireActivititeiten"/>: Een
                bovenliggende activiteit mag niet naar een activiteit verwijzen die lager in de
                hiërarchie ligt.</sch:assert>
            <!-- TPOD1730  -->
            <sch:assert
                test="contains($activiteitenLijst, rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef/@xlink:href)"
                >H:TPOD1730: <sch:value-of
                    select="rol:identificatie"/> Betreft verwijzing: 
                <sch:value-of select="rol:gerelateerdeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>: Gerelateerde activiteiten moeten
                bestaan indien er naar verwezen wordt.</sch:assert>
            <!-- TPOD1740  -->
            <sch:report test="not(contains($activiteitenLijst, rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href))"> REPORT: H:TPOD1740: <sch:value-of
                select="rol:identificatie"
            />:  Betreft verwijzing: <sch:value-of select="rol:bovenliggendeActiviteit/rol-ref:ActiviteitRef/@xlink:href"/>: Bovenliggende 
                activiteiten moeten bestaan indien er naar verwezen wordt. DIT LAATSTE WORDT NU NOG
                NIET GETEST</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <!-- TPOD1700_TPOD1710_TPOD1730 Local functions -->
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
    
    
    <!-- TPOD1760 -->
    <sch:pattern id="TPOD1760">
        <sch:rule
            context="/ow-dc:owBestand/sl:standBestand/sl:stand/ow-dc:owObject/ga:Gebiedsaanwijzing">
            <sch:assert
                test="foo:isGebiedaanwijzingvanTypegebied(., foo:featureMembers())[1] = ''"
                > H:TPOD1760: Betreft <sch:value-of select="ga:identificatie"/>: Een
                gebiedsaanwijzing moet een gebied of gebiedengroep zijn (en mag geen punt,
                puntengroep, lijn of lijnengroep zijn). </sch:assert>
        </sch:rule>
    </sch:pattern>
    <!-- TPOD1760 Local Functions -->
    <xsl:function name="foo:isGebiedaanwijzingvanTypegebied">
        <xsl:param name="context" as="node()"/>
        <xsl:param name="featureMembers" as="node()*"/>
        <xsl:for-each select="$context/ga:locatieaanduiding/l-ref:LocatieRef">
            <xsl:choose>
                <xsl:when test="contains(@xlink:href, 'gebiedengroep')">
                    <xsl:for-each select="foo:gebiedenGroepen()">
                        <xsl:if
                            test="current()/l:Gebiedengroep/l:identificatie = $context/ga:locatieaanduiding/l-ref:LocatieRef/@xlink:href">
                            <xsl:for-each select="current()/l:Gebiedengroep/l:groepselement/l-ref:GebiedRef">
                                <xsl:value-of
                                    select="foo:isGebiedvanTypegebied(@xlink:href, $featureMembers)"
                                />
                            </xsl:for-each>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="foo:isGebiedvanTypegebied($context/ga:locatieaanduiding/l-ref:LocatieRef/@xlink:href, $featureMembers)"
                    />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="foo:isGebiedvanTypegebied">
        <xsl:param name="id" as="xs:string"/>
        <xsl:param name="featureMembers" as="node()*"/>
        <xsl:variable name="gebieden" select="foo:gebieden()"/>
        <xsl:for-each select="$gebieden/l:Gebied">
            <xsl:if test="current()/l:identificatie = $id">
                <xsl:value-of select="foo:isGeometrievanTypegebied(current()/l:geometrie/g-ref:GeometrieRef/@xlink:href, $featureMembers)"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="foo:isGeometrievanTypegebied">
        <xsl:param name="geoId" as="xs:string"/>
        <xsl:param name="featureMembers" as="node()*"/>
        <xsl:variable name="result">
            <xsl:for-each select="$featureMembers/geo:featureMember/geo:Geometrie">
                <xsl:if test="geo:id eq $geoId">
                    <xsl:if test="not(geo:geometrie/gml:MultiSurface)">
                        <xsl:value-of select="$geoId"/>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$result"></xsl:value-of>
    </xsl:function>
    
    <!-- GENERIC FUNCTIONS -->
    
    <xsl:function name="foo:manifest-ow">
        <xsl:variable name="manifest-ow">
            <xsl:for-each select="$allDocuments">
                <xsl:if test="Modules">
                    <manifest-ow copy-namespaces="no" xmlns="">
                        <xsl:for-each select="//Modules/RegelingVersie/Bestand">
                            <Bestand copy-namespaces="no" xmlns="">
                                <xsl:element name="naam">
                                    <xsl:value-of
                                        select="concat(string-join($base-uri), string('/'), string(naam))"/>
                                </xsl:element>
                                <xsl:for-each select="objecttype">
                                    <xsl:element name="objecttype">
                                        <xsl:value-of select="."/>
                                    </xsl:element>
                                </xsl:for-each>
                            </Bestand>
                        </xsl:for-each>
                    </manifest-ow>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$manifest-ow"/>
    </xsl:function>
    
    <xsl:function name="foo:manifest">
        <xsl:variable name="manifestBestand">
            <xsl:for-each select="$allDocuments">
                <xsl:if test="lvbb:manifest">
                    <manifest copy-namespaces="no" xmlns="">
                        <xsl:for-each select="//lvbb:manifest/lvbb:bestand">
                            <bestand copy-namespaces="no" xmlns="">
                                <xsl:element name="bestandsNaam">
                                    <xsl:value-of select="lvbb:bestandsnaam"/>
                                </xsl:element>
                                <xsl:element name="contentType">
                                    <xsl:value-of select="lvbb:contentType"/>
                                </xsl:element>
                            </bestand>
                        </xsl:for-each>
                    </manifest>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$manifestBestand"/>
    </xsl:function>
    
    <xsl:function name="foo:substring-before-last">
        <xsl:param name="input"/>
        <xsl:param name="substr"/>
        <xsl:if test="$substr and contains($input, $substr)">
            <xsl:variable name="temp" select="substring-after($input, $substr)"/>
            <xsl:value-of select="substring-before($input, $substr)"/>
            <xsl:if test="contains($temp, $substr)">
                <xsl:value-of select="$substr"/>
                <xsl:value-of select="foo:substring-before-last($temp, $substr)"> </xsl:value-of>
            </xsl:if>
        </xsl:if>
    </xsl:function>
    
    <xsl:function name="foo:substring-after-last">
        <xsl:param name="input"/>
        <xsl:param name="substr"/>
        <xsl:variable name="temp" select="substring-after($input, $substr)"/>
        <xsl:choose>
            <xsl:when test="$substr and contains($temp, $substr)">
                <xsl:value-of select="foo:substring-after-last($temp, $substr)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$temp"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:variable name="base-uri" select="foo:substring-before-last(base-uri(.), '/')"/>
    
    <xsl:function name="foo:featureMembers">
        <xsl:variable name="featureMembers">
            <xsl:for-each select="foo:manifest()/manifest/bestand">
                <xsl:if test="contains(contentType, 'gml+xml')">
                    <xsl:if test="document(bestandsNaam)//geo:FeatureCollectionGeometrie">
                        <xsl:for-each
                            select="document(bestandsNaam)//geo:FeatureCollectionGeometrie/geo:featureMember">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$featureMembers"/>
    </xsl:function>
    
    <xsl:function name="foo:gebieden">
        <xsl:variable name="gebieden">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Gebied'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/l:Gebied">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$gebieden"/>
    </xsl:function>
    
    <xsl:function name="foo:punten">
        <xsl:variable name="punten">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Punt'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/l:Punt">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$punten"/>
    </xsl:function>
    
    <xsl:function name="foo:lijnen">
        <xsl:variable name="lijnen">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Lijn'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/l:Lijn">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$lijnen"/>
    </xsl:function>
    
    <xsl:function name="foo:gebiedenGroepen">
        <xsl:variable name="gebiedenGroepen">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Gebiedengroep'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/l:Gebiedengroep">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$gebiedenGroepen"/>
    </xsl:function>
    
    <xsl:function name="foo:puntenGroepen">
        <xsl:variable name="puntenGroepen">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Puntengroep'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/l:Puntengroep">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$puntenGroepen"/>
    </xsl:function>
    
    <xsl:function name="foo:lijnenGroepen">
        <xsl:variable name="lijnenGroepen">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Lijnengroep'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/l:Lijnengroep">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$lijnenGroepen"/>
    </xsl:function>
    
    <xsl:function name="foo:symbolisatiecollectie">
        <xsl:variable name="symbolisatiecollectie">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Symbolisatiecollectie'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/k:Symbolisatiecollectie">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$symbolisatiecollectie"/>
    </xsl:function>
    
    <xsl:function name="foo:kaart">
        <xsl:variable name="kaart">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Kaart'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/k:Kaart">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$kaart"/>
    </xsl:function>
    
    <xsl:function name="foo:pons">
        <xsl:variable name="pons">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Pons'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/p:Pons">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$pons"/>
    </xsl:function>
    
    <xsl:variable name="foo:regelTeksten">
        <xsl:variable name="regelTeksten">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Regeltekst'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/r:Regeltekst">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$regelTeksten"/>
    </xsl:variable>
    
    <xsl:variable name="foo:regelsVoorIedereen">
        <xsl:variable name="regelsVoorIedereen">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'RegelVoorIedereen'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/r:RegelVoorIedereen">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$regelsVoorIedereen"/>
    </xsl:variable>
    
    <xsl:variable name="foo:omgevingswaarderegel">
        <xsl:variable name="omgevingswaarderegel">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Omgevingswaarderegel'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/r:Omgevingswaarderegel">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$omgevingswaarderegel"/>
    </xsl:variable>
    
    <xsl:function name="foo:activiteiten">
        <xsl:variable name="activiteiten">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Activiteit'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/rol:Activiteit">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$activiteiten"/>
    </xsl:function>
    
    <xsl:function name="foo:omgevingsnormen">
        <xsl:variable name="omgevingsnormen">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Omgevingsnorm'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/rol:Omgevingsnorm">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$omgevingsnormen"/>
    </xsl:function>
    
    <xsl:function name="foo:omgevingswaardes">
        <xsl:variable name="omgevingswaardes">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Omgevingswaarde'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/rol:Omgevingswaarde">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$omgevingswaardes"/>
    </xsl:function>
    
    <xsl:function name="foo:gebiedsaanwijzing">
        <xsl:variable name="gebiedsaanwijzing">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Gebiedsaanwijzing'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/ga:Omgevingswaarde">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$gebiedsaanwijzing"/>
    </xsl:function>
    
    <xsl:function name="foo:formeleDivisies">
        <xsl:variable name="formeleDivisies">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'FormeleDivisie'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/vt:FormeleDivisie">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$formeleDivisies"/>
    </xsl:function>
    
    <xsl:function name="foo:tekstdeel">
        <xsl:variable name="tekstdeel">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Tekstdeel'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/vt:Tekstdeel">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$tekstdeel"/>
    </xsl:function>
    
    <xsl:function name="foo:hoofdlijn">
        <xsl:variable name="hoofdlijn">
            <xsl:for-each select="foo:manifest-ow()//Bestand">
                <xsl:for-each select="objecttype">
                    <xsl:if test="text() = 'Hoofdlijn'">
                        <xsl:for-each
                            select="document(../naam)//sl:standBestand/sl:stand/ow-dc:owObject/vt:Hoofdlijn">
                            <xsl:copy-of select="."/>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="$hoofdlijn"/>
    </xsl:function>
    
    
</sch:schema>