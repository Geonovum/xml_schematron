# Valideren met gebruik van ANT

De validatie-tool bestaat uit een aantal directories die noodzakelijk zijn om in die structuur
de tool goed te laten functioneren.

Zo zit er een directory: lib in. Deze bevat de saxon-schematron/xslt-libraries
Er zit een directory: xsl in. Deze bevat de noodzakelijke conversie bestanden die saxon gebruikt.
Er zit een directory: Opdracht in. Deze hoort de te valideren dataset te bevatten.

Al deze directories komen in functionele samenhang door het bestandje build.xml. 
Dit is een configuratiebestandje voor ant (Engels voor mier). Ant is een tool die bij veel
ontwikkelaars is bekend en uitermate geschikt is om dit soort complexe constellaties te verwerken.

Het valideren zelf gebeurt door het script-bestand **validate.sch**

Ant wordt opgestart door een eenvoudig command-line bestandje:

Op Linux: **./validate.sh**
**$ ./validate.sh > log.txt 2>&1**

Op Windows: **validate.bat**

De validatiefouten en andere mededelingen verschijnen op het scherm.

# Valideren zonder gebruik van ANT

U kunt het validatie-script ook gebruiken zonder ANT, maar dan heeft u iets anders nodig dat de 
libraries en xslt-conversie bestanden aanbiedt en gebruikt.

De XML-editor **Oxygen** is hiervoor uitstekend geschikt. Mogelijk zijn andere editors ook geschikt,
maar dat heb ik niet getest.

Echter, omdat in dergelijke werkwijze de directory-aanwijzingen uit build.xml niet worden gelezen,
moet u het validatie-bestand: **validate.sch** in de directory van de te testen dataset zetten.

Dan klikt u een xml-bestand aan, en in Oxygen geeft u dan de menu-instructie: Valideren met Schematron, 
en dan wijst u het validate.sch aan als te gebruiken validatie-script.