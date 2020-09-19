<sch:schema queryBinding="xslt2" xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
  xmlns:tekst="https://standaarden.overheid.nl/stop/imop/tekst/"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <sch:ns prefix="tekst" uri="https://standaarden.overheid.nl/stop/imop/tekst/" />
  <sch:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform" />
  <!-- Variabelen om de waarden voor identificerende data te kunnen valideren zijn als
       sch:let opgenomen op de plek waar ze gebruikt worden. -->
  <!-- -->
  <sch:p>Versie @@@VERSIE@@@</sch:p>
  <sch:p>Schematron voor aanvullende validatie voor imop-tekst.xsd</sch:p>
  <sch:pattern id="sch_tekst_001" see="tekst:Lijst tekst:Li tekst:LiNummer">
    <sch:title>Lijst - Nummering lijstitems</sch:title>
    <sch:rule context="tekst:Lijst[@type = 'ongemarkeerd']">
      <sch:assert id="STOP0001" role="error" test="count(tekst:Li/tekst:LiNummer) = 0"> 
        { "code": "STOP0001", 
          "eId": "<sch:value-of select="@eId" />" }</sch:assert>
    </sch:rule>
    <!--  -->
    <sch:rule context="tekst:Lijst[@type = 'expliciet']">
      <sch:assert id="STOP0002" role="error" test="count(tekst:Li[descendant::tekst:LiNummer]) = count(tekst:Li)">
        { "code": "STOP0002",
          "eId": "<sch:value-of select="@eId" />" }</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <sch:pattern id="sch_tekst_022" see="tekst:Al">
    <sch:title>Alinea - Bevat content</sch:title>
    <sch:rule context="tekst:Al">
      <sch:report id="STOP0005" role="error" test="normalize-space(.) = '' and not(descendant::tekst:InlineTekstAfbeelding)">
        { "code": "STOP0005", 
          "element": "<sch:value-of select="ancestor::tekst:*[@eId][1]/local-name()" />",
          "eId": "<sch:value-of select="ancestor::tekst:*[@eId][1]/@eId" />" }</sch:report>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <sch:pattern id="sch_tekst_027" see="tekst:Kop">
    <sch:title>Kop - Bevat content</sch:title>
    <sch:rule context="tekst:Kop">
      <sch:report id="STOP0006" role="error" test="normalize-space(.) = ''">
        { "code": "STOP0006",
          "element": "<sch:value-of select="ancestor::tekst:*[@eId][1]/local-name()" />",
          "eId": "<sch:value-of select="ancestor::tekst:*[@eId][1]/@eId" />" }</sch:report>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <sch:pattern id="sch_tekst_003" see="tekst:table tekst:NootRef">
    <sch:title>Tabel - Referenties naar een noot</sch:title>
    <sch:rule context="tekst:Nootref">
      <sch:let name="nootID" value="@refid" />
      <sch:assert id="STOP0007" test="ancestor::tekst:table">
        { "code": "STOP0007",
          "ref": "<sch:value-of select="@refid" />" }</sch:assert>
      <sch:assert id="STOP0008" test="ancestor::tekst:table/descendant::tekst:Noot[@id = $nootID]">
        { "code": "STOP0008",
          "ref": "<sch:value-of select="@refid" />",
          "eId": "<sch:value-of select="ancestor::tekst:table/@eId" />"}</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <sch:pattern id="sch_tekst_004" see="tekst:Lijst tekst:Li tekst:table">
    <sch:title>Lijst - plaatsing tabel in een lijst</sch:title>
    <sch:rule context="tekst:Li[tekst:table]">
      <sch:report id="STOP0009" role="warning" test="self::tekst:Li/tekst:table and not(ancestor::tekst:Instructie)">
        { "code": "STOP0009",
          "eId": "<sch:value-of select="@eId" />" }</sch:report>
    </sch:rule>
  </sch:pattern>
 
  <!--  -->
  <sch:pattern id="sch_tekst_020" see="tekst:agAKN">
    <sch:title>Identificatie - AKN-naamgeving voor eId en wId</sch:title>
    <sch:rule context="*[@eId]">
      <sch:let name="AKNnaam">
        <xsl:choose>
          <xsl:when test="matches(local-name(), 'Lichaam')">body</xsl:when>
          <xsl:when test="matches(local-name(), 'RegelingOpschrift')">longTitle</xsl:when>
          <xsl:when test="matches(local-name(), 'AlgemeneToelichting')">genrecital</xsl:when>
          <xsl:when test="matches(local-name(), '^ArtikelgewijzeToelichting$')"
            >artrecital</xsl:when>
          <xsl:when test="matches(local-name(), 'Artikel|WijzigArtikel')">art</xsl:when>
          <xsl:when test="matches(local-name(), 'WijzigLid|Lid')">para</xsl:when>
          <xsl:when test="matches(local-name(), 'Divisietekst')">content</xsl:when>
          <xsl:when test="matches(local-name(), 'Divisie')">div</xsl:when>
          <xsl:when test="matches(local-name(), 'Boek')">book</xsl:when>
          <xsl:when test="matches(local-name(), 'Titel')">title</xsl:when>
          <xsl:when test="matches(local-name(), 'Deel')">part</xsl:when>
          <xsl:when test="matches(local-name(), 'Hoofdstuk')">chp</xsl:when>
          <xsl:when test="matches(local-name(), 'Afdeling')">subchp</xsl:when>
          <xsl:when test="matches(local-name(), 'Paragraaf|Subparagraaf|Subsubparagraaf')"
            >subsec</xsl:when>
          <xsl:when test="matches(local-name(), 'WijzigBijlage|Bijlage')">cmp</xsl:when>
          <xsl:when test="matches(local-name(), 'Inhoudsopgave')">toc</xsl:when>
          <xsl:when test="matches(local-name(), 'Motivering')">acc</xsl:when>
          <xsl:when test="matches(local-name(), 'Toelichting')">recital</xsl:when>
          <xsl:when test="matches(local-name(), 'InleidendeTekst')">intro</xsl:when>
          <xsl:when test="matches(local-name(), 'Aanhef')">formula_1</xsl:when>
          <xsl:when test="matches(local-name(), 'Kadertekst')">recital</xsl:when>
          <xsl:when test="matches(local-name(), 'Sluiting')">formula_2</xsl:when>
          <xsl:when test="matches(local-name(), 'table')">table</xsl:when>
          <xsl:when test="matches(local-name(), 'Figuur')">img</xsl:when>
          <xsl:when test="matches(local-name(), 'Formule')">math</xsl:when>
          <xsl:when test="matches(local-name(), 'Citaat')">cit</xsl:when>
          <xsl:when test="matches(local-name(), 'Begrippenlijst|Lijst')">list</xsl:when>
          <xsl:when test="matches(local-name(), 'Li|Begrip')">item</xsl:when>
          <xsl:when test="matches(local-name(), 'IntIoRef|ExtIoRef')">ref</xsl:when>
          <xsl:otherwise>X</xsl:otherwise>
        </xsl:choose>
      </sch:let>
      <sch:let name="mijnEID">
        <xsl:choose>
          <xsl:when test="contains(@eId, '__')">
            <xsl:value-of select="tokenize(@eId, '__')[last()]" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@eId" />
          </xsl:otherwise>
        </xsl:choose>
      </sch:let>
      <sch:let name="mijnWID">
        <xsl:value-of select="tokenize(@wId, '__')[last()]" />
      </sch:let>
      <sch:assert id="STOP0022" test="starts-with($mijnEID, $AKNnaam)">
        { "code": "STOP0022",
          "AKNdeel": "<sch:value-of select="$mijnEID" />",
          "element": "<sch:name />",
          "waarde": "<sch:value-of select="$AKNnaam" />",
          "wId": "<sch:value-of select="@wId" />"}</sch:assert>
      <sch:p>Een wId MOET voldoen aan de AKN-naamgevingsconventie</sch:p>
      <sch:assert id="STOP0023" test="starts-with($mijnWID, $AKNnaam)">
        { "code": "STOP0023",
          "AKNdeel": "<sch:value-of select="$mijnWID" />",
          "element": "<sch:name />",
          "waarde": "<sch:value-of select="$AKNnaam" />",
          "wId": "<sch:value-of select="@wId" />"}</sch:assert>

    </sch:rule>
  </sch:pattern>
 
  <!--  -->
</sch:schema>
