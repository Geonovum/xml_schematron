<sch:schema queryBinding="xslt2" xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
  xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <sch:ns prefix="data" uri="https://standaarden.overheid.nl/stop/imop/data/" />
  <sch:ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform" />

  <sch:p>Versie @@@VERSIE@@@</sch:p>
  <sch:p>Schematron voor aanvullende validatie voor imop-data.xsd</sch:p>

  <!-- LVBB2017	Een AKN- of JOIN-identificatie mag geen punt bevatten -->
  <sch:pattern id="sch_data_001" see="data:FRBRWork data:FRBRExpression data:instrumentVersie
    data:doel">
    <sch:title>AKN- of JOIN-identificatie mag geen punt bevatten</sch:title>
    <sch:rule context="data:FRBRWork | data:FRBRExpression | data:instrumentVersie | data:doel">
      <sch:p>Een AKN- of JOIN-identificatie mag geen punt bevatten</sch:p>
      <sch:report id="LVBB2017" role="error" test="contains(., '.')">
        {"code":"LVBB2017", 
         "ID": "<sch:value-of select="."/>"}</sch:report>
    </sch:rule>
  </sch:pattern>
  <!--  -->

  <!-- LVBB2018	Als voor een AKN- of JOIN zowel het werk als de expressie gegeven is dan moet het eerste deel van de expressie overeenkomen met het werk -->
  <!--  -->
  <sch:pattern id="sch_data_002" see="data:ExpressionIdentificatie data:FRBRWork
    data:FRBRExpression">
    <sch:title>ExpressionID begint met WorkID</sch:title>
    <sch:rule context="data:ExpressionIdentificatie">
      <sch:p>Het deel vóór de @ van de FRBRExpression moet gelijk aan zijn FRBRWork</sch:p>
      <sch:assert id="LVBB2018" role="error"
        test="starts-with(data:FRBRExpression, data:FRBRWork)">
        {"code": "LVBB2018", 
        "Work-ID":"<sch:value-of select="data:FRBRWork" />", 
        "Expression-ID":"<sch:value-of select="data:FRBRExpression" />"}
	  </sch:assert>
      <!-- Het gedeelte van de
        FRBRExpression <sch:value-of select="data:FRBRExpression" /> vóór de 'landcode/@' is niet gelijk aan
        de FRBRWork-identificatie <sch:value-of select="data:FRBRWork" />. -->
    </sch:rule>
  </sch:pattern>
  <!--  -->

  <!-- LVBB2008 Daar waar een AKN- of JOIN-identificatie wordt verwacht moet deze beginnen met akn of join -->
  <!--  -->
  <sch:pattern id="sch_data_003" see="data:FRBRWork data:FRBRExpression data:instrumentVersie
    data:doel">
    <sch:title>AKN en JOIN identificaties starten met /akn/ of /join/</sch:title>
    <sch:rule context="data:FRBRWork | data:FRBRExpression | data:instrumentVersie | data:doel">
      <sch:p>Een AKN of JOIN identificatie MOET starten met /akn/ of /join/</sch:p>
      <sch:assert role="error" test="starts-with(., '/akn/') or starts-with(., '/join/')">
        {"code": "LVBB2008", 
        "ID":"<sch:value-of select="." />"}	    
		<!-- De waarde binnen element <sch:name /> begint niet met /akn/ of /join/ -->
	  </sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--  -->

  <!-- STOP3605 InformatieObjectMetadata: data:officieleTitel bevat een /join-identifier -->
  <!-- Hier alleen test of begin join is, nog niet of deze gelijk is aan identificatie  -->
  <!--  -->
  <sch:pattern id="sch_data_004" see="data:InformatieObjectMetadata data:officieleTitel">
    <sch:title>OfficieleTitel InformatieObject is JOIN identifier</sch:title>
    <sch:rule context="data:InformatieObjectMetadata">
      <sch:p>De officieleTitel van een InformatieObject MOET starten met /join/id/</sch:p>
      <sch:assert role="error" test="starts-with(./data:officieleTitel/string(), '/join/id/')">
        {"code": "LVBB3605", 
        "substring":"<sch:value-of select="./data:officieleTitel" />"}		     
		 <!-- De waarde van OfficieleTitel binnen element <sch:name /> begint niet met /join/id/ -->
	  </sch:assert>
    </sch:rule>
  </sch:pattern>
  <!--  -->

  <!-- AKN/JOIN validaties -->
  <sch:pattern id="sch_data_005" see="data:ExpressionIdentificatie">
    <sch:title>AKN/JOIN validaties Expression/Work in ExpressionIdentificatie</sch:title>
	<sch:rule context="data:ExpressionIdentificatie">
	  <sch:let name="soortWork" value="./data:soortWork/string()" />
	  <sch:let name="Expression" value="./data:FRBRExpression/string()" />	
	  <sch:let name="Work" value="./data:FRBRWork/string()" />	
	  
      <sch:let name="Expression_reeks" value="tokenize($Expression, '/')" />
	  <sch:let name="Expression_objecttype" value="$Expression_reeks[3]" />
	  <sch:let name="Expression_land" value="$Expression_reeks[3]" />
      <sch:let name="Expression_collectie" value="$Expression_reeks[4]" />
	  <sch:let name="Expression_documenttype" value="$Expression_reeks[4]" />
	  <sch:let name="Expression_overheid" value="$Expression_reeks[5]" />
      <sch:let name="Expression_datum_work" value="$Expression_reeks[6]" />
      <sch:let name="Expression_restdeel" value="$Expression_reeks[8]" />
      <sch:let name="Expression_restdeel_reeks" value="tokenize($Expression_restdeel, '@')" />
	  <sch:let name="Expression_taal" value="$Expression_restdeel_reeks[1]" />
      <sch:let name="Expression_restdeel_deel2" value="$Expression_restdeel_reeks[2]" />
      <sch:let name="Expression_restdeel_deel2_reeks" value="tokenize($Expression_restdeel_deel2, ';')" />
      <sch:let name="Expression_datum_expr" value="$Expression_restdeel_deel2_reeks[1]" />

      <sch:let name="Work_reeks" value="tokenize($Work, '/')" />
	  <sch:let name="Work_objecttype" value="$Work_reeks[3]" />
      <sch:let name="Work_land" value="$Work_reeks[3]" />
      <sch:let name="Work_collectie" value="$Work_reeks[4]" />
	  <sch:let name="Work_documenttype" value="$Work_reeks[4]" />
	  <sch:let name="Work_overheid" value="$Work_reeks[5]" />
	  <sch:let name="Work_datum_work" value="$Work_reeks[6]" />
	  
	  <sch:let name="is_join" value="$soortWork = '/join/id/stop/work_010'" />
	  <sch:let name="is_akn" value="$soortWork = '/join/id/stop/work_003' or $soortWork = '/join/id/stop/work_015' or 
	    $soortWork = '/join/id/stop/work_019' or $soortWork = '/join/id/stop/work_006' or $soortWork = '/join/id/stop/work_021'" />

      <sch:let name="is_besluit" value="$soortWork = '/join/id/stop/work_003'" />
      <sch:let name="is_regeling" value="$soortWork = '/join/id/stop/work_019' or $soortWork = '/join/id/stop/work_006' or $soortWork = '/join/id/stop/work_021'" />
      <sch:let name="is_publicatie" value="$soortWork = '/join/id/stop/work_015'" />

      <sch:let name="landexpressie" value="'^(nl|aw|cw|sx)$'" />
      <sch:let name="overheidexpressie" value="'^(mnre\d{4}|gm\d{4}|ws\d{4}|pv\d{2})$'" />
      <sch:let name="taalexpressie" value="'(^nld|eng|fry|pap|mul|und)$'" />
 	  <sch:let name="collectieexpressie" value="'^(regdata|infodata|pubdata)$'" />
	  
      <!-- LVBB2009 Voor een AKN-identificatie (werk/expressie) moet het tweede deel een geldig land zijn (nl, aw, cw, sx) -->
      <sch:p>AKN-identificatie (work) MOET als tweede deel een geldig land hebben</sch:p>
      <sch:report role="error" test="$is_akn and not (matches($Work_land, $landexpressie))">
	    {"code": "LVBB2009",
        "Work-ID":"<sch:value-of select="data:FRBRWork" />",		
        "substring":"<sch:value-of select="$Work_land" />"}
   	  <!-- Voor een AKN-identificatie (expressie) moet het tweede deel een geldig land zijn (nl, aw, cw, sx) -->
      <!-- alleen validatie op work, validatie op expressie wordt afgedekt door LVBB2018 Als voor een AKN- of JOIN zowel het werk als de expressie gegeven is dan moet het eerste deel van de expressie overeenkomen met het werk -->
	  </sch:report>

    
	  <!-- STOPxxxx De AKN van een officiele publicatie moet als derde veld 'officialGazette' hebben --> 
      <sch:p>AKN-identificatie (Work) van officiele publicatie MOET als derde deel officialGazette hebben</sch:p>
      <sch:report role="error" test="$is_publicatie and not (matches($Work_documenttype, '^officialGazette$'))">
	    {"code": "STOPxxxx",
        "Work-ID":"<sch:value-of select="data:FRBRWork" />",		
        "substring":"<sch:value-of select="$Work_documenttype" />"}	  
	    <!-- Voor een AKN-identificatie (Work) van officiele publicatie moet het derde deel een geldig type zijn (officialGazette) -->
        <!-- alleen validatie op work, validatie op expressie wordt afgedekt door LVBB2018 Als voor een AKN- of JOIN zowel het werk als de expressie gegeven is dan moet het eerste deel van de expressie overeenkomen met het werk -->
	  </sch:report>
  
	  <!-- LVBB4004	De AKN door het bevoegd gezag aangeleverd besluit moet als derde veld 'bill' hebben -->
      <sch:p>AKN-identificatie (Work) van besluit MOET als derde deel bill hebben</sch:p>
      <sch:report role="error" test="$is_besluit and not (matches($Work_documenttype, '^bill$'))">
	    {"code": "LVBB4004",
        "Work-ID":"<sch:value-of select="data:FRBRWork" />",		
        "substring":"<sch:value-of select="$Work_documenttype" />"}		  
        <!-- alleen validatie op work, validatie op expressie wordt afgedekt door LVBB2018 Als voor een AKN- of JOIN zowel het werk als de expressie gegeven is dan moet het eerste deel van de expressie overeenkomen met het werk -->    
		<!-- Voor een AKN-identificatie (work) van besluit moet het derde deel een geldig type zijn (bill) -->
	  </sch:report>
	  
      <!-- LVBB2500 De AKN door het bevoegd gezag aangeleverde regeling moet als derde veld 'act' hebben -->
      <sch:p>AKN-identificatie (work) van (evt gecons) regeling MOET als derde deel act hebben</sch:p>
      <sch:report role="error" test="$is_regeling and not (matches($Work_documenttype, '^act$'))">
	    {"code": "LVBB2500",
        "Work-ID":"<sch:value-of select="data:FRBRWork" />",		
        "substring":"<sch:value-of select="$Work_documenttype" />"}			  
        <!-- alleen validatie op work, validatie op expressie wordt afgedekt door LVBB2018 Als voor een AKN- of JOIN zowel het werk als de expressie gegeven is dan moet het eerste deel van de expressie overeenkomen met het werk -->
	    <!-- Voor een AKN-identificatie (work) van (evt gecons) regeling moet het derde deel een geldig type zijn (act) -->
	  </sch:report>

 
      <!-- LVBB2011 Voor een JOIN-identificatie (werk/expressie) moet het tweede deel geljk zijn aan 'id' of 'set'. -->
      <!-- volgens documentatie mag alleen id! -->	  
      <sch:p>JOIN-identificatie (work) MOET als tweede deel 'id' hebben</sch:p>
      <sch:report role="error" test="$is_join and not (matches($Work_objecttype, '^id$'))">
	  	{"code": "LVBB2011",
        "Work-ID":"<sch:value-of select="data:FRBRWork" />"}
	    <!-- Voor een JOIN-identificatie (work) moet het tweede deel gelijk zijn aan 'id' -->
	    <!-- alleen validatie op work, validatie op expressie wordt afgedekt door LVBB2018 Als voor een AKN- of JOIN zowel het werk als de expressie gegeven is dan moet het eerste deel van de expressie overeenkomen met het werk -->
	  </sch:report>
	
      <!-- LVBB2012	Voor een JOIN-identificatie (werk/expressie) moet het derde deel een geldig type zijn (regdata, pubdata, infodata, proces, stop) -->
      <!-- proces en stop mogen niet! -->
      <sch:p>JOIN-identificatie (werk) MOET als derde deel regdata,pubdata, infodata hebben</sch:p>
      <sch:report role="error"
        test="$is_join and not (matches($Work_collectie, $collectieexpressie))">
	  	{"code": "LVBB2012",
        "Work-ID":"<sch:value-of select="data:FRBRWork" />"}		
		<!-- Voor een JOIN-identificatie (werk) moet het derde deel een geldig type zijn (regdata,pubdata, infodata) -->
        <!-- alleen validatie op work, validatie op expressie wordt afgedekt door LVBB2018 Als voor een AKN- of JOIN zowel het werk als de expressie gegeven is dan moet het eerste deel van de expressie overeenkomen met het werk -->
	  </sch:report>

      <!-- LVBB2013 Voor een AKN- of JOIN identificatie (werk/expressie) moet het vijfde deel een jaartal zijn of een geldige datum zijn -->
      <sch:p>AKN of JOIN identificatie MOET als vijfde deel jaartal of geldigde datum hebben</sch:p>
      <sch:report role="error"
        test="($is_join or $is_akn) and not (($Work_datum_work castable as xs:date) or ($Work_datum_work castable as xs:gYear))">
		  {"code": "LVBB2013",
          "Work-ID":"<sch:value-of select="data:FRBRWork" />"}
		  <!-- Voor een AKN- of JOIN identificatie (werk/expressie) moet het vijfde deel een jaartal zijn of een geldige datum zijn <sch:value-of select="$Work_datum_work" /> -->
	  </sch:report>
		
      <!-- LVBB2014 Voor een JOIN-identificatie (expressie) moet het eerste deel na de '@' een jaartal of een geldige datum zijn -->
      <sch:p>JOIN-identificatie (expressie) MOET als eerste deel na de '@' een jaartal of een geldige datum hebben</sch:p>
      <sch:report role="error"
        test="$is_join and not (($Expression_datum_expr castable as xs:date) or ($Expression_datum_expr castable as xs:gYear))">
		  {"code": "LVBB2014",
          "Expression-ID":"<sch:value-of select="data:FRBRExpression" />"}		  
		  <!-- Voor een JOIN-identificatie (expressie) moet het eerste deel na de '@' een jaartal of een geldige datum zijn <sch:value-of select="$Expression_datum_expr" /> -->
	  </sch:report>

      <!-- LVBB2015 Als voor een JOIN-identificatie (expressie) het eerste deel na de '@' een jaartal is dan moet dat gelijk zijn of groter dan het jaartal in het werk deel (vijfde deel) -->
      <sch:p>JOIN-identificatie (expressie) MOET als eerste deel na de '@' een jaartal of een geldige datum hebben groter/gelijk aan jaartal in werk</sch:p>
      <sch:report role="error"
	    test="$is_join and not ($Expression_datum_expr >= $Expression_datum_work)"> 
		  {"code": "LVBB2015",
		  "Work-ID":"<sch:value-of select="data:FRBRWork" />",
          "Expression-ID":"<sch:value-of select="data:FRBRExpression" />"}			  
          <!-- Als voor een JOIN-identificatie (expressie) het eerste deel na de '@' een jaartal is dan moet dat gelijk zijn of groter dan het jaartal in het werk deel (vijfde deel) -->
	  </sch:report>

      <!-- LVBB2016 Voor een AKN- of JOIN-identificatie (expressie) moet deel voorafgaand aan de '@' een geldige taal zijn ('nld','eng','fry','pap','mul','und') -->
      <sch:p>AKN- of JOIN-identificatie (expressie) MOET als deel voorafgaand aan de '@' een geldige taal hebben</sch:p>
      <sch:report role="error"
        test="($is_join or $is_akn) and not (matches($Expression_taal, $taalexpressie))">
		  {"code": "LVBB2016",
          "Expression-ID":"<sch:value-of select="data:FRBRExpression" />"}	   		  
		  <!-- Voor een AKN- of JOIN-identificatie (expressie) moet deel voorafgaand aan de '@' <sch:value-of select="$Expression_taal" /> een geldige taal zijn ('nld','eng','fry','pap','mul','und') -->
      </sch:report>

      <!-- LVBB4035 Vierde deel van alle AKN / JOIN werken en expressies moet gelijk zijn aan een brpcode en deze moet ook gelijk zijn aan die van de eindverantwoordelijke -->
      <!-- Hier wordt alleen eerste deel gevalideerd, tweede deel eindverantwoordelijke moet op hoger LVBB niveau in lvbb-aanlevering.sch-->
      <sch:p>Vierde deel AKN werken MOET brpcode zijn</sch:p>
      <sch:report role="error" test="($is_akn or $is_join) and not (matches($Work_overheid, $overheidexpressie))"> 
	    <!-- Vierde deel van alle AKN/JOIN werken <sch:value-of select="$Work_overheid" /> moet gelijk zijn aan een brpcode -->
		  {"code": "LVBB4035",
		  "Work-ID":"<sch:value-of select="data:FRBRWork" />"}	
      </sch:report>
	  <!-- alleen validatie op work, validatie op expressie wordt afgedekt door LVBB2018 Als voor een AKN- of JOIN zowel het werk als de expressie gegeven is dan moet het eerste deel van de expressie overeenkomen met het werk -->

    </sch:rule>
  </sch:pattern>
  <!--  -->

  
</sch:schema>
