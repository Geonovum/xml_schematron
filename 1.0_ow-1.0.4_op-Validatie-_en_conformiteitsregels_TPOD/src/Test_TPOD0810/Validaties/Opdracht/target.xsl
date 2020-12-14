<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:foo="http://whatever"
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
                xmlns:aanlevering="https://standaarden.overheid.nl/lvbb/stop/aanlevering/"
                xmlns:basisgeo="http://www.geostandaarden.nl/basisgeometrie/1.0"
                xmlns:gio="https://standaarden.overheid.nl/stop/imop/gio/"
                xmlns:gml="http://www.opengis.net/gml/3.2"
                xmlns:geo="https://standaarden.overheid.nl/stop/imop/geo/"
                xmlns:lvbb="http://www.overheid.nl/2017/lvbb"
                xmlns:stop="http://www.overheid.nl/2017/stop"
                xmlns:tns="http://www.logius.nl/digikoppeling/gb/2010/10"
                xmlns:ow-manifest="http://www.geostandaarden.nl/bestanden-ow/manifest-ow"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
   <xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>
   <!--PHASES-->
   <!--PROLOG-->
   <xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
               method="xml"
               omit-xml-declaration="no"
               standalone="yes"
               indent="yes"/>
   <!--XSD TYPES FOR XSLT2-->
   <!--KEYS AND FUNCTIONS-->
   <!--DEFAULT RULES-->
   <!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path"/>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="local-name()"/>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-2-->
   <!--This mode can be used to generate prefixed XPath for humans-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
   <!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: GENERATE-ID-FROM-PATH -->
   <xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>
   <!--MODE: GENERATE-ID-2 -->
   <xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters-->
   <xsl:template match="text()" priority="-1"/>
   <!--SCHEMA SETUP-->
   <xsl:template match="/">
      <svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="" schemaVersion="">
         <xsl:comment>
            <xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/>
         </xsl:comment>
         <svrl:ns-prefix-in-attribute-values uri="http://whatever" prefix="foo"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand"
                                             prefix="ow-dc"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/owobject" prefix="ow"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/datatypenalgemeen" prefix="da"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek"
                                             prefix="sl"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing" prefix="ga"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/kaart" prefix="k"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/locatie" prefix="l"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/pons" prefix="p"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/regels" prefix="r"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/regelsoplocatie" prefix="rol"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/vrijetekst" prefix="vt"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
         <svrl:ns-prefix-in-attribute-values uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
         <svrl:ns-prefix-in-attribute-values uri="https://standaarden.overheid.nl/stop/imop/tekst/" prefix="tekst"/>
         <svrl:ns-prefix-in-attribute-values uri="https://standaarden.overheid.nl/lvbb/stop/aanlevering/"
                                             prefix="aanlevering"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/basisgeometrie/1.0" prefix="basisgeo"/>
         <svrl:ns-prefix-in-attribute-values uri="https://standaarden.overheid.nl/stop/imop/gio/" prefix="gio"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
         <svrl:ns-prefix-in-attribute-values uri="https://standaarden.overheid.nl/stop/imop/geo/" prefix="geo"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.overheid.nl/2017/lvbb" prefix="lvbb"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.overheid.nl/2017/stop" prefix="stop"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.logius.nl/digikoppeling/gb/2010/10" prefix="tns"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/bestanden-ow/manifest-ow"
                                             prefix="ow-manifest"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">TPOD0810</xsl:attribute>
            <xsl:attribute name="name">TPOD0810</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M53"/>
      </svrl:schematron-output>
   </xsl:template>
   <!--SCHEMATRON PATTERNS-->
   <xsl:param name="xmlDocuments" select="collection('.?select=*.xml')"/>
   <xsl:param name="gmlDocuments" select="collection('.?select=*.gml')"/>
   <xsl:param name="SOORT_REGELING"
              select="$xmlDocuments//aanlevering:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>
   <xsl:param name="AMvB" select="'/join/id/stop/regelingtype_001'"/>
   <xsl:param name="MR" select="'/join/id/stop/regelingtype_002'"/>
   <xsl:param name="OP" select="'/join/id/stop/regelingtype_003'"/>
   <xsl:param name="OV" select="'/join/id/stop/regelingtype_004'"/>
   <xsl:param name="WV" select="'/join/id/stop/regelingtype_005'"/>
   <xsl:param name="OVi" select="'/join/id/stop/regelingtype_006'"/>
   <xsl:param name="PB" select="'/join/id/stop/regelingtype_007'"/>
   <xsl:param name="I" select="'/join/id/stop/regelingtype_008'"/>
   <xsl:param name="VR" select="'/join/id/stop/regelingtype_009'"/>
   <xsl:param name="P" select="'/join/id/stop/regelingtype_010'"/>
   <xsl:param name="RI" select="'/join/id/stop/regelingtype_011'"/>
   <xsl:param name="AMvB_MR" select="$SOORT_REGELING=$AMvB or $SOORT_REGELING=$MR"/>
   <xsl:param name="Omgevingsplan" select="$SOORT_REGELING=$OP"/>
   <xsl:param name="OP-implementatie-GemeentenEnWaterschappen"
              select="$SOORT_REGELING=$OP or $SOORT_REGELING=$WV"/>
   <xsl:param name="OW-generiek"
              select="         $SOORT_REGELING=$AMvB or          $SOORT_REGELING=$MR or          $SOORT_REGELING=$OP or          $SOORT_REGELING=$OV or          $SOORT_REGELING=$WV or          $SOORT_REGELING=$OVi or         $SOORT_REGELING=$PB or         $SOORT_REGELING=$I or         $SOORT_REGELING=$VR or         $SOORT_REGELING=$P or         $SOORT_REGELING=$RI         "/>
   <xsl:param name="OW-generiek_OZON"
              select="         $SOORT_REGELING=$AMvB or          $SOORT_REGELING=$MR or          $SOORT_REGELING=$OP or          $SOORT_REGELING=$OV or          $SOORT_REGELING=$WV or          $SOORT_REGELING=$OVi or         $SOORT_REGELING=$PB or         $SOORT_REGELING=$I or         $SOORT_REGELING=$VR or         $SOORT_REGELING=$P or         $SOORT_REGELING=$RI         "/>
   <xsl:param name="OP-implementatie-generiek"
              select="         $SOORT_REGELING=$AMvB or          $SOORT_REGELING=$MR or          $SOORT_REGELING=$OP or          $SOORT_REGELING=$OV or          $SOORT_REGELING=$WV or          $SOORT_REGELING=$OVi or         $SOORT_REGELING=$PB or         $SOORT_REGELING=$I or         $SOORT_REGELING=$VR or         $SOORT_REGELING=$P or         $SOORT_REGELING=$RI         "/>
   <xsl:param name="OP-implementatie-niet-Rijk"
              select="         $SOORT_REGELING=$OP or          $SOORT_REGELING=$OV or          $SOORT_REGELING=$WV or          $SOORT_REGELING=$OVi or         $SOORT_REGELING=$PB or         $SOORT_REGELING=$I or         $SOORT_REGELING=$VR or         $SOORT_REGELING=$P or         $SOORT_REGELING=$RI         "/>
   <xsl:param name="OP-implementatie-Omgevingsverordening"
              select="$SOORT_REGELING=$OV"/>
   <xsl:param name="OP-implementatie-regelstructuur"
              select="         $SOORT_REGELING=$AMvB or          $SOORT_REGELING=$MR or          $SOORT_REGELING=$OP or          $SOORT_REGELING=$OV or          $SOORT_REGELING=$WV or          $SOORT_REGELING=$VR         "/>
   <xsl:param name="Regelstructuur"
              select="         $SOORT_REGELING=$AMvB or          $SOORT_REGELING=$MR or          $SOORT_REGELING=$OP or          $SOORT_REGELING=$OV or          $SOORT_REGELING=$WV or          $SOORT_REGELING=$VR         "/>
   <xsl:param name="Regelstructuur_OZON"
              select="         $SOORT_REGELING=$AMvB or          $SOORT_REGELING=$MR or          $SOORT_REGELING=$OP or          $SOORT_REGELING=$OV or          $SOORT_REGELING=$WV or          $SOORT_REGELING=$VR         "/>
   <xsl:param name="Vrijetekststructuur"
              select="         $SOORT_REGELING=$OVi or         $SOORT_REGELING=$PB or         $SOORT_REGELING=$I or         $SOORT_REGELING=$P or         $SOORT_REGELING=$RI         "/>
   <xsl:param name="Vrijetekststructuur_OZON"
              select="         $SOORT_REGELING=$OVi or         $SOORT_REGELING=$PB or         $SOORT_REGELING=$I or         $SOORT_REGELING=$P or         $SOORT_REGELING=$RI         "/>
   <xsl:param name="Waterschapsverordening" select="$SOORT_REGELING=$WV"/>
   <!--PATTERN TPOD0810-->
   <!--RULE -->
   <xsl:template match="//tekst:Lijst" priority="1000" mode="M53">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//tekst:Lijst"/>
      <!--ASSERT warning-->
      <xsl:choose>
         <xsl:when test="($OP-implementatie-GemeentenEnWaterschappen and name(*[1])='Lijstaanhef') or not($OP-implementatie-GemeentenEnWaterschappen)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="($OP-implementatie-GemeentenEnWaterschappen and name(*[1])='Lijstaanhef') or not($OP-implementatie-GemeentenEnWaterschappen)">
               <xsl:attribute name="role">warning</xsl:attribute>
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text> 
            { 
            "code": "<xsl:text/>
                  <xsl:value-of select="'TPOD0810'"/>
                  <xsl:text/>", 
            "ernst": "Waarschuwing", 
            "<xsl:text/>
                  <xsl:value-of select="'eId'"/>
                  <xsl:text/>": "<xsl:text/>
                  <xsl:value-of select="@eId"/>
                  <xsl:text/>", 
            "bestandsnaam":
                "<xsl:text/>
                  <xsl:value-of select="base-uri(.)"/>
                  <xsl:text/>", 
            "regel": "<xsl:text/>
                  <xsl:value-of select="'Een Lijst wordt altijd voorafgegaan door een inleidende tekst, oftewel de Lijstaanhef.'"/>
                  <xsl:text/>",
            "melding": "Dit is niet het geval bij <xsl:text/>
                  <xsl:value-of select="'eId'"/>
                  <xsl:text/>: <xsl:text/>
                  <xsl:value-of select="@eId"/>
                  <xsl:text/>
                  <xsl:text/>
                  <xsl:value-of select="''"/>
                  <xsl:text/>",
            "waarschuwing":  "<xsl:text/>
                  <xsl:value-of select="''"/>
                  <xsl:text/>"           
            }, 
        </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="@*|node()" priority="-2" mode="M53">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M53"/>
   </xsl:template>
</xsl:stylesheet>
