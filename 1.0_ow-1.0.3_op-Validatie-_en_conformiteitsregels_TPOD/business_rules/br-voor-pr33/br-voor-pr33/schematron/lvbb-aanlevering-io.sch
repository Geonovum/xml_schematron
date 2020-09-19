<sch:schema queryBinding="xslt2" xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
  xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <sch:ns prefix="data" uri="https://standaarden.overheid.nl/stop/imop/data/" />
  <sch:ns prefix="tekst" uri="https://standaarden.overheid.nl/stop/imop/tekst/" />
  <sch:ns prefix="lvbba" uri="https://standaarden.overheid.nl/lvbb/stop/aanlevering/" />
  <sch:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform" />

  <sch:p>Versie @@@VERSIE@@@</sch:p>
  <sch:p>Schematron voor aanvullende validaties voor lvbba</sch:p>

  <!-- STOP3210 Voor GIO's moet het element data:heeftBestanden naar precies 1 bestand verwijzen.
       TODO: test geldt voor alle IOs, niet alleen voor GIOs -->
  <sch:pattern id="sch_lvbba_STOP3210" see="lvbba:InformatieObjectVersie">
    <sch:title>Informatieobject - aanleveren GIO</sch:title>
    <sch:rule context="lvbba:InformatieObjectVersie">
      <sch:let name="Expression-ID" value="data:ExpressionIdentificatie/data:FRBRExpression" />
      <sch:assert id="STOP3210" role="error"
        test="count(data:InformatieObjectVersieMetadata/data:heeftBestanden/data:heeftBestand) = 1 ">
        {"code":"STOP3210", 
        "Expression-ID": "<sch:value-of select="$Expression-ID" />"}</sch:assert>
    </sch:rule>
  </sch:pattern>

</sch:schema>
