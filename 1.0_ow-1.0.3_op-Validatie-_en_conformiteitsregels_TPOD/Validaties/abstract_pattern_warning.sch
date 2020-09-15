<?xml version="1.0" encoding="UTF-8"?>
<sch:pattern xmlns:sch="http://purl.oclc.org/dsdl/schematron" id="abstractPatternWarning"
    abstract="true">
    <sch:rule context="$context">
        <sch:assert test="($businessRuleGroup and $CONDITION) or not($businessRuleGroup)" role="warning"> 
            { 
            "code": "<sch:value-of
                select="$code"/>", 
            "ernst": "Waarschuwing", 
            "<sch:value-of
                select="$nameidf"/>": "<sch:value-of select="$idf"/>", 
            "bestandsnaam":
                "<sch:value-of select="base-uri(.)"/>", 
            "regel": "<sch:value-of select="$regel"/>",
            "melding": "Dit is niet het geval bij <sch:value-of select="$nameidf"/>: <sch:value-of select="$idf"/><sch:value-of select="$melding"/>",
            "waarschuwing":  "<sch:value-of select="$waarschuwing"/>"           
            }, 
        </sch:assert>
    </sch:rule>
</sch:pattern>
