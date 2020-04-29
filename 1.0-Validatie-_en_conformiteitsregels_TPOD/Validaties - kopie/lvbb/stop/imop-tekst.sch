<?xml version="1.0" encoding="UTF-8"?>
<sch:schema queryBinding="xslt2" xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
  xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
  xmlns:tekst="https://standaarden.overheid.nl/stop/imop/tekst/"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <sch:ns prefix="tekst" uri="https://standaarden.overheid.nl/stop/imop/tekst/" />
  <sch:ns prefix="data" uri="https://standaarden.overheid.nl/stop/imop/data/" />
  <sch:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform" />
  <!-- Variabelen om de waarden voor identificerende data te kunnen valideren.
    Deze variabelen kunnen dus op 1 locatie (hier) worden aangepast waardoor ze overal waar 
    ze gebruikt worden correct zijn. -->
  <sch:let name="aknIdentifier" value="'/akn/[\.]+'" />
  <sch:let name="joinIdentifier" value="'^/join/[A-z0-9\./#@!]+$'" />
  <sch:let name="joinOfAkn" value="'^(/join/|/akn/)[A-z0-9\./#@!]+$'" />
  <!-- -->
  <sch:p>0.98</sch:p>
  <sch:title>imop-tekst schematron (generieke validatie)</sch:title>
  <sch:pattern>
    <sch:title>Lijst: nummering afhankelijk van het type van de lijst [T]</sch:title>
    <sch:rule context="tekst:Lijst[not(@type)]">
      <sch:p>Een Lijst zonder type aanduiding MOET worden behandeld als een lijst van het type
        'expliciet'</sch:p>
      <sch:assert test="count(tekst:Li[not(tekst:LiNummer)]) = 0"> Een Lijst van type 'expliciet'
        heeft verplicht altijd LiNummer elementen.</sch:assert>
    </sch:rule>
    <sch:rule context="tekst:Lijst[@type = 'ongemarkeerd']">
      <sch:p>Een Lijst van het type 'ongemarkeerd' MOET lijst items hebben zonder nummering.</sch:p>
      <sch:assert test="count(tekst:Li/tekst:LiNummer) = 0"> Een Lijst van type 'ongemarkeerd' mag
        geen LiNummer elementen hebben.</sch:assert>
    </sch:rule>
    <sch:rule context="tekst:Lijst[@type = 'expliciet']">
      <sch:p>Een Lijst van het type 'expliciet' MOET genummerde lijst items hebben.</sch:p>
      <sch:assert test="count(tekst:Li[not(tekst:LiNummer)]) = 0"> Een Lijst van type 'expliciet'
        heeft verplicht altijd LiNummer elementen.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <sch:pattern>
    <sch:title>Nummer voor structuur en LidNummer voor WijzigArtikel [T]</sch:title>
    <sch:rule context="tekst:Nummer | tekst:WijzigArtikel//tekst:LidNummer">
      <sch:p>Nummer voor structuur en LidNummer voor WijzigArtikel MAG NIET op een punt '.'
        eindigen.</sch:p>
      <sch:report test="ends-with(., '.')"> De nummering van element <sch:value-of
          select="local-name(ancestor::node()[@wId][1])" /> met id <sch:value-of
          select="ancestor::*[@wId][1]/@wId" /> mag NIET eindigen met een punt '.'.</sch:report>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <sch:pattern>
    <sch:title>Nummer voor structuur-elementen [T]</sch:title>
    <sch:rule context="tekst:Nummer[not(ancestor::tekst:Divisie)]">
      <sch:p>Nummer voor structuur MAG NIET op een punt '.' eindigen.</sch:p>
      <sch:report test="ends-with(., '.')"> De nummering van element <sch:value-of
          select="local-name(ancestor::node()[@wId][1])" /> met id <sch:value-of
          select="ancestor::*[@wId][1]/@wId" /> mag NIET eindigen met een punt '.'.</sch:report>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <sch:pattern>
    <sch:title>De attributen voor een RegelingMutatie zijn in lijn zijn met de FRBRwork
      [T]</sch:title>
    <sch:rule context="tekst:RegelingMutatie">
      <sch:p>De identificerend waarden van de attributen @was @wordt en @FRBRwork MOET onderling
        consistent zijn.</sch:p>
      <sch:let name="workID" value="@FRBRwork" />
      <sch:assert test="not(matches($workID, $aknIdentifier))">De waarde voor de @FRBRwork van
        RegelingMutatie <sch:value-of select="@componentnaam" /> is geen
        AKN-identifier.</sch:assert>
      <sch:assert test="starts-with(@was, $workID)">De waarde voor de @was van RegelingMutatie
          <sch:value-of select="@componentnaam" /> begint niet met de waarde van
        @FRBRwork.</sch:assert>
      <sch:assert test="starts-with(@wordt, $workID)">De waarde voor de @wordt van RegelingMutatie
          <sch:value-of select="@componentnaam" /> begint niet beginnen met de waarde van
        @FRBRwork.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <sch:pattern>
    <sch:title>Een NootRef kan alleen binnen een tabel worden gebruikt [T]</sch:title>
    <sch:rule context="tekst:Nootref">
      <sch:let name="nootID" value="@refid" />
      <sch:p>Een NootRef MOET in de context van een tabel staan verwijzend naar een Noot binnen
        dezelfde tabel.</sch:p>
      <sch:assert test="ancestor::tekst:table">De Nootref naar Noot met id <sch:value-of
          select="@idref" /> staat niet in een tabel.</sch:assert>
      <sch:p>Een NootRef MOET verwijzen naar een Noot in dezelfde tabel.</sch:p>
      <sch:assert test="ancestor::tekst:table/descendant::tekst:Noot[id = $nootID]">De NootRef
        verwijst niet naar een NOOT in dezelfde tabel <sch:value-of select="ancestor::table/@wId"
         />.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <sch:pattern>
    <sch:title>Gebruik van een tabel in een lijst is voorbehouden aan oudere regelingen (legacy)
      [T]</sch:title>
    <sch:rule context="tekst:li/tekst:table">
      <sch:p>Voor nieuwe regelingen is het niet toegestaan een tabel binnen een Lijst te
        plaatsen.</sch:p>
      <sch:report test="ancestor::tekst:NieuweRegeling or ancestor::tekst:MaakInitieleRegeling">Een
        tabel in Lijstitem <sch:value-of select="parent::Li/@wId" /> is niet
        toegestaan.</sch:report>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <!-- INTERNE REFERENTIES HEBBEN CORRECTE VERWIJZINGEN -->
  <!--  -->
  <sch:pattern>
    <sch:title>Een de waarden van een intern refererent element moet verwijzen naar een bestaande
      identificatie [T].</sch:title>
    <sch:rule
      context="NieuweRegeling//IntRef[@doel] | NieuweRegeling//IntIoRef[@doel] | MaakInitieleRegeling//IntRef[@doel] | MaakInitieleRegeling//IntIoRef[@doel]">
      <sch:let name="doelwit" value="@doel" />
      <sch:assert test="//*[@eId = $doelwit] | //*[@wId = $doelwit]">Het @doel van element
        <sch:name /> met waarde <sch:value-of select="$doelwit" /> verwijst niet naar een bestaande
        identifier.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!-- -->
  <sch:pattern>
    <sch:title>Een @wId en @eId mogen niet eindigen op een '.' [T]</sch:title>
    <sch:rule context="//*[@eId]">
      <sch:let name="doelwitE" value="@eId" />
      <sch:let name="doelwitW" value="@wId" />
      <sch:p>Een attribuut @eId MAG NIET eindigen met een '.'.</sch:p>
      <sch:report test="ends-with($doelwitE, '.')">Het attribuut @eId <sch:value-of
          select="$doelwitE" /> eindigt op een '.', dit is niet toegestaan.</sch:report>
      <sch:p>Een attribuut @wId MAG NIET eindigen met een '.'.</sch:p>
      <sch:report test="ends-with($doelwitW, '.')">Het attribuut @wId <sch:value-of
          select="$doelwitW" /> eindigt op een '.', dit is niet toegestaan.</sch:report>
    </sch:rule>
  </sch:pattern>
  <!-- 
    Renvooi markering alleen toegestaan binnen een tekst:RegelingMutatie
  -->
  <sch:pattern>
    <sch:title>Tekstuele-wijzigingen in de context van een tekst:RegelingMutatie [T]</sch:title>
    <sch:rule context="//tekst:NieuweTekst | //tekst:VerwijderdeTekst">
      <p>Een tekstuele wijziging MOET in de context van een tekst:RegelingMutatie staan.</p>
      <sch:assert role="error" test="ancestor::tekst:RegelingMutatie"> Tekstuele wijziging is niet
        toegestaan voor <sch:value-of select="local-name(parent::tekst:*)" /> - "<sch:value-of
          select="ancestor::tekst:*[@wId][1]/@wId" />" buiten de context van een
        tekst:RegelingMutatie. </sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <sch:pattern>
    <sch:title>Structuur-wijzigingen in de context van een tekst:RegelingMutatie [T]</sch:title>
    <sch:rule context="//tekst:*[@wijzigactie]">
      <p>Een structuur wijziging MOET in de context van een tekst:RegelingMutatie staan.</p>
      <sch:assert role="error" test="ancestor::tekst:RegelingMutatie"> Attribuut @wijzigactie is
        niet toegestaan op element <sch:value-of select="local-name()" /> - "<sch:value-of
          select="@wId" />" buiten de context van een tekst:RegelingMutatie. </sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--
    Unieke eId en wId's voor Besluit / regeling / NieuweRegeling
  -->
  <xsl:key match="tekst:Besluit/descendant::tekst:*[@eId][not(ancestor::tekst:*[@componentnaam])]"
    name="alleEIDs" use="@eId" />
  <xsl:key match="tekst:Besluit/descendant::tekst:*[@wId][not(ancestor::tekst:*[@componentnaam])]"
    name="alleWIDs" use="@wId" />
  <sch:pattern>
    <sch:title>Alle identifiers wId en eId moeten uniek zijn</sch:title>
    <sch:rule
      context="tekst:Besluit/descendant::tekst:*[@eId][not(ancestor::tekst:*[@componentnaam])]">
      <sch:p>eId identifiers moeten uniek zijn in een Besluit</sch:p>
      <sch:assert role="warning" test="count(key('alleEIDs', @eId)) = 1">Error: eId '<sch:value-of
          select="@eId" />' binnen het besluit is niet uniek.</sch:assert>
      <sch:p>wId identifiers moeten uniek zijn in een Besluit</sch:p>
      <sch:assert role="warning" test="count(key('alleWIDs', @wId)) = 1">Error: wId '<sch:value-of
          select="@eId" />' binnen het besluit is niet uniek.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--
    Unieke ID's voor componenten zoals MaakInitieleRegeling / RegelingMutatie
  -->
  <sch:pattern id="Unieke-componentIds">
    <sch:title>Binnen een component moeten de identifiers uniek zijn.</sch:title>
    <sch:rule context="tekst:*[@componentnaam]/descendant::tekst:*[@eId]">
      <sch:let name="mijnEID" value="@eId" />
      <sch:let name="mijnWID" value="@wId" />
      <sch:assert role="warning"
        test="count(ancestor::tekst:*[@componentnaam]/descendant::tekst:*[@eId[. = $mijnEID]]) = 1"
        >Error: eId '<sch:value-of select="@eId" />' binnen component <sch:value-of
          select="ancestor::tekst:*[@componentnaam]/@componentnaam" /> moet uniek zijn.</sch:assert>
      <sch:assert role="warning"
        test="count(ancestor::tekst:*[@componentnaam]/descendant::tekst:*[@wId[. = $mijnWID]]) = 1"
        >Error: wId '<sch:value-of select="@wId" />' binnen component <sch:value-of
          select="ancestor::tekst:*[@componentnaam]/@componentnaam" /> moet uniek zijn.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <!-- VOOR TABELLEN EEN REEKS CONTROLES OP GEBRUIK WIJZIGACTIES -->
  <!--  -->
  <sch:pattern>
    <sch:title>Wijzigactie voor rijen en kolommen mogen niet samen voorkomen [D]</sch:title>
    <sch:rule context="tekst:tgroup">
      <sch:p>Wijzigactie MOET OF voor kolommen OF voor rijen voorkomen, niet gecombineerd.</sch:p>
      <sch:report role="error"
        test="descendant::tekst:row[@wijzigactie] and descendant::tekst:colspec[@wijzigactie]"> Een
        @wijzigactie op zowel rijen als kolommen in tabel '<sch:value-of
          select="ancestor::tekst:table/@wId" />' is niet toegestaan. </sch:report>
      <sch:p>Wijzigactie MAG NIET voorkomen, wanneer verticale overspanning is gebruikt.</sch:p>
      <sch:assert role="error"
        test="(descendant::tekst:row[@wijzigactie] or descendant::tekst:colspec[@wijzigactie]) and descendant::tekst:entry[@morerows &gt; 0]"
        > Een @wijzigactie voor tabel <sch:value-of select="ancestor::tekst:table/@wId" /> met een
        verticale overspanning is niet toegestaan. </sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <!-- VOOR TABELLEN EEN REEKS CONTROLES OP CALS REGELS -->
  <!--  -->
  <sch:pattern>
    <sch:title>Een tabel cel (entry) verwijst naar bestaande identifiers [T]</sch:title>
    <sch:rule context="tekst:entry/@colname | tekst:entry/@namst | tekst:entry/@nameend">
      <sch:let name="id" value="." />
      <sch:p>De referentie van een entry naar een kolom MOET correct verwijzen naar een
        colspec.</sch:p>
      <sch:assert test="ancestor::tekst:tgroup/tekst:colspec[@colname = $id]">Het attribuut @colname
        in rij <sch:value-of select="parent::tekst:row/position()" /> van tabel <sch:value-of
          select="ancestor::tekst:table/@wId" /> verwijst niet naar een bestaande
        kolom.</sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--  -->
  <sch:pattern>
    <sch:title>Het aantal cellen geplaatst in een tabel moet overeenkomen met de specificatie
      [T]</sch:title>
    <sch:rule context="tekst:thead | tekst:tbody">
      <sch:let name="totaalCellen" value="count(tekst:row) * parent::tekst:tgroup/@cols" />
      <sch:let name="colPosities">
        <xsl:for-each select="ancestor::tekst:tgroup/tekst:colspec">
          <col id="{@colname}">
            <xsl:value-of select="position()" />
          </col>
        </xsl:for-each>
      </sch:let>
      <sch:let name="cellen" value="count(descendant::tekst:entry)" />
      <sch:let name="spanEinde">
        <xsl:for-each select="descendant::tekst:entry">
          <xsl:variable name="nameend" select="@nameend" />
          <xsl:variable name="namest" select="@namest" />
          <nr>
            <xsl:choose>
              <xsl:when test="@namest and @morerows">
                <xsl:value-of
                  select="($colPosities/*[@id = $nameend]/. - $colPosities/*[@id = $namest]/. + 1) * (@morerows + 1)"
                 />
              </xsl:when>
              <xsl:when test="@namest">
                <xsl:value-of
                  select="$colPosities/*[@id = $nameend]/. - $colPosities/*[@id = $namest]/. + 1" />
              </xsl:when>
              <xsl:when test="@morerows">
                <xsl:value-of select="1 + @morerows" />
              </xsl:when>
              <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
          </nr>
        </xsl:for-each>
      </sch:let>
      <sch:let name="spannend" value="sum($spanEinde/*)" />
      <sch:p>Het aantal colspec's MOET gelijk zijn aan het opgegeven aantal kolommen.</sch:p>
      <sch:assert flag="error"
        test="parent::tekst:tgroup/@cols = count(ancestor::tekst:tgroup/tekst:colspec)">Het aantal
        colspec's (<sch:value-of select="count(ancestor::tekst:tgroup/tekst:colspec)" />) voor
        <sch:name /> in tabel <sch:value-of select="ancestor::tekst:table/@wId" /> komt niet overeen
        met het aantal kolommen (<sch:value-of select="parent::tekst:tgroup/@cols" />).</sch:assert>
      <p>Het totale aantal cellen inclusief spans en morerows MOET overeenkomen met het aantal
        mogelijke cellen zonder spans en morerows.</p>
      <sch:assert flag="error" test="$totaalCellen = $spannend">Het aantal cellen (<sch:value-of
          select="$spannend" />) in <sch:name /> van tabel "<sch:value-of
          select="ancestor::tekst:table/@wId" />" komt niet overeen met de verwachting (resultaat:
          <sch:value-of select="$spannend" /> van verwachting <sch:value-of select="$totaalCellen"
         />).</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
