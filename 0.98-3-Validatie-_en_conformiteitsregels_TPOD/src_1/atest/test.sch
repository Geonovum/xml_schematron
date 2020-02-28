<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    >
    <sch:pattern id="TDOP_0400">
        <sch:rule context="/">
            <sch:let name="CONDITION"> 
                <xsl:value-of select="true()"/>
            </sch:let>
            <sch:assert test="false()"><xsl:value-of select="$CONDITION"/></sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>