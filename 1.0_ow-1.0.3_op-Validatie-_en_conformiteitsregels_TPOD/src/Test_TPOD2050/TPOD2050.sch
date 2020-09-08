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
    <sch:let name="SOORT_REGELING"
        value="$xmlDocuments//aanlevering:RegelingVersieInformatie/data:RegelingMetadata/data:soortRegeling/text()"/>

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
    
    <sch:let name="rijk" value="$SOORT_REGELING=$AMvB or $SOORT_REGELING=$MR"/>
    <sch:let name="omgevingsplan" value="$SOORT_REGELING=$OP"/>
    <sch:let name="omgevingsplan-en-waterschap" value="$SOORT_REGELING=$OP or $SOORT_REGELING=$WV"/>
    <sch:let name="allen" value="
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
    <sch:let name="allen-behalve-rijk" value="
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
    <sch:let name="omgevingsverordening" value="$SOORT_REGELING=$OV"/>
    <sch:let name="regelstructuur" value="
        $SOORT_REGELING=$AMvB or 
        $SOORT_REGELING=$MR or 
        $SOORT_REGELING=$OP or 
        $SOORT_REGELING=$OV or 
        $SOORT_REGELING=$WV or 
        $SOORT_REGELING=$VR
        "/>
    <sch:let name="vrijetekststructuur" value="
        $SOORT_REGELING=$OVi or
        $SOORT_REGELING=$PB or
        $SOORT_REGELING=$I or
        $SOORT_REGELING=$P or
        $SOORT_REGELING=$RI
        "/>
    <sch:let name="waterschapsverordening" value="$SOORT_REGELING=$WV"/>

    <!-- ============================================================================================================================ -->

    <sch:pattern id="TPOD_2050">
        <sch:rule context="//aanlevering:AanleveringBesluit">
            <sch:let name="APPLICABLE" value="$allen"/>
            <sch:let name="message" value="foo:existsTPOD_2050()"/>
            <sch:let name="CONDITION" value="string-length($message)=0"/>
            <sch:assert test="($APPLICABLE and $CONDITION) or not($APPLICABLE)"> 
                {               
                "code": "TPOD2050",
                "ernst": "Blokkerend",
                "bestandsnaam": "<sch:value-of select="base-uri(.)"/>",
                "regel": "Kijken of het manifest-ow en het manifest bestaan, en de bestanden benoemd in de manifest-bestanden aanwezig zijn.",
                "melding": "<sch:value-of select="$message"/>"
                },
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <xsl:function name="foo:existsTPOD_2050">
        <xsl:variable name="message">
        <xsl:choose>
            <xsl:when test="(not(document('manifest-ow.xml'))) and (not(document('manifest.xml')))">
                <xsl:value-of select="'manifest-ow.xml en manifest.xml zijn niet aangetroffen of niet valide.'"/>
            </xsl:when>
            <xsl:when test="not(document('manifest-ow.xml'))">
                <xsl:value-of select="concat('manifest-ow.xml is niet aangetroffen of niet valide.',foo:bestandenTPOD_2050())"/>
            </xsl:when>
            <xsl:when test="not(document('manifest.xml'))">
                <xsl:value-of select="'manifest.xml is niet aangetroffen of niet valide.'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="foo:bestandenTPOD_2050()"/>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:variable>
        <xsl:message select="$message"/>
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
    
    
</sch:schema>
