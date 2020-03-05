<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:title>Dog Stuff</sch:title>
    
    <sch:pattern>
        <sch:rule context="Dog">
            <sch:assert test="count(leg) = 4">A dog should have four legs, because then they can have four paws.</sch:assert>
            <sch:report test="count(leg) &lt; 3">A dog with less than three legs is unstable</sch:report>
        </sch:rule>
        <sch:rule context="Dog/leg">
            <sch:assert test="count(paw) = 1">Each dog's leg should have a single paw, as an element or attribute, because this meets the business requirement "Dog must be walkable".</sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>