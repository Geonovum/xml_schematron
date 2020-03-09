<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:ow-dc="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
                xmlns:sl="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
                xmlns:r="http://www.geostandaarden.nl/imow/regels/v20190901"
                xmlns:r-ref="http://www.geostandaarden.nl/imow/regels-ref/v20190901"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:l="http://www.geostandaarden.nl/imow/locatie/v20190901"
                xmlns:l-ref="http://www.geostandaarden.nl/imow/locatie-ref/v20190901"
                xmlns:rol="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901"
                xmlns:rol-ref="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709"
                xmlns:foo="http://whatever"
                xmlns:ga="http://www.geostandaarden.nl/imow/gebiedsaanwijzing/v20190709"
                xmlns:ga-ref="http://www.geostandaarden.nl/imow/gebiedsaanwijzing-ref/v20190709"
                xmlns:g-ref="http://www.geostandaarden.nl/imow/geometrie-ref/v20190901"
                xmlns:geo="http://www.geostandaarden.nl/basisgeometrie/v20190901"
                xmlns:gml="http://www.opengis.net/gml/3.2"
                xmlns:data="https://standaarden.overheid.nl/stop/imop/data/"
                xmlns:stop="https://standaarden.overheid.nl/lvbb/stop/"
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
   <xsl:function xmlns:sch="http://purl.oclc.org/dsdl/schematron"
                 xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
                 name="foo:calculateCondition">
      <xsl:param name="href"/>
      <xsl:variable name="context"
                    select="$gmlDocuments//geo:Geometrie[geo:id/text() eq string($href)]"/>
      <xsl:choose>
         <xsl:when test="$context">
            <xsl:variable name="C1" select="not($context//gml:MultiPoint)"/>
            <xsl:variable name="C2" select="not($context//gml:Point)"/>
            <xsl:variable name="C3" select="not($context//gml:MultiSurface)"/>
            <xsl:message select="'--------------------'"/>
            <xsl:message select="string($C1)"/>
            <xsl:message select="string($C2)"/>
            <xsl:message select="string($C3)"/>
            <xsl:message select="string($C1 and $C2 and $C3)"/>
            <xsl:if test="($C1 and $C2 and $C3)">
               <xsl:value-of select="'true'"/>
            </xsl:if>
            <xsl:if test="not($C1 and $C2 and $C3)">
               <xsl:value-of select="''"/>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="''"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>
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
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/bestanden/deelbestand/v20190901"
                                             prefix="ow-dc"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/bestanden-ow/standlevering-generiek/v20190301"
                                             prefix="sl"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/regels/v20190901" prefix="r"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/regels-ref/v20190901"
                                             prefix="r-ref"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/locatie/v20190901" prefix="l"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/locatie-ref/v20190901"
                                             prefix="l-ref"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/regelsoplocatie/v20190901"
                                             prefix="rol"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/regelsoplocatie-ref/v20190709"
                                             prefix="rol-ref"/>
         <svrl:ns-prefix-in-attribute-values uri="http://whatever" prefix="foo"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing/v20190709"
                                             prefix="ga"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/gebiedsaanwijzing-ref/v20190709"
                                             prefix="ga-ref"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/imow/geometrie-ref/v20190901"
                                             prefix="g-ref"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.geostandaarden.nl/basisgeometrie/v20190901"
                                             prefix="geo"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
         <svrl:ns-prefix-in-attribute-values uri="https://standaarden.overheid.nl/stop/imop/data/" prefix="data"/>
         <svrl:ns-prefix-in-attribute-values uri="https://standaarden.overheid.nl/lvbb/stop/" prefix="stop"/>
         <svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/1999/XSL/Transform" prefix="xsl"/>
         <svrl:active-pattern>
            <xsl:attribute name="document">
               <xsl:value-of select="document-uri(/)"/>
            </xsl:attribute>
            <xsl:attribute name="id">TPOD_1960</xsl:attribute>
            <xsl:attribute name="name">TPOD_1960</xsl:attribute>
            <xsl:apply-templates/>
         </svrl:active-pattern>
         <xsl:apply-templates select="/" mode="M27"/>
      </svrl:schematron-output>
   </xsl:template>
   <!--SCHEMATRON PATTERNS-->
   <xsl:param name="xmlDocuments" select="collection('.?select=*.xml')"/>
   <xsl:param name="gmlDocuments" select="collection('.?select=*.gml')"/>
   <xsl:param name="SOORT_REGELING"
              select="$xmlDocuments//stop:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>
   <xsl:param name="AMvB" select="'/join/id/stop/regelingtype_001'"/>
   <xsl:param name="MR" select="'/join/id/stop/regelingtype_002'"/>
   <xsl:param name="OP" select="'/join/id/stop/regelingtype_003'"/>
   <xsl:param name="OV" select="'/join/id/stop/regelingtype_004'"/>
   <xsl:param name="WV" select="'/join/id/stop/regelingtype_005'"/>
   <xsl:param name="OVI_PB" select="''"/>
   <!--PATTERN TPOD_1960-->
   <!--RULE -->
   <xsl:template match="//l:Lijn/l:geometrie/g-ref:GeometrieRef"
                 priority="1000"
                 mode="M27">
      <svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                       context="//l:Lijn/l:geometrie/g-ref:GeometrieRef"/>
      <xsl:variable name="APPLICABLE" select="true()"/>
      <xsl:variable name="href" select="string(@xlink:href)"/>
      <xsl:variable name="CONDITION"
                    select="string-length(foo:calculateCondition($href))&gt;0"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"/>
         <xsl:otherwise>
            <svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
                                test="($APPLICABLE and $CONDITION) or not($APPLICABLE)">
               <xsl:attribute name="location">
                  <xsl:apply-templates select="." mode="schematron-select-full-path"/>
               </xsl:attribute>
               <svrl:text>
                TPOD_1960: Betreft <xsl:text/>
                  <xsl:value-of select="../../name()"/>
                  <xsl:text/>: <xsl:text/>
                  <xsl:value-of select="../../l:identificatie"/>
                  <xsl:text/>,
                <xsl:text/>
                  <xsl:value-of select="@xlink:href"/>
                  <xsl:text/>: Iedere verwijzing naar een gmlObject
                vanuit een Lijn moet een lijn-geometrie zijn. 
            </svrl:text>
            </svrl:failed-assert>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/>
   </xsl:template>
</xsl:stylesheet>
