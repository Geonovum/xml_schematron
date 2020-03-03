Gebruik Ant vanuit deze directory

Gebruik volgende commando's in deze volgorde:
ant compile -q -DschemaFile="../Test_TPOD0400/TPOD0400.sch"
ant validate -q -DxmlFile="../Test_TPOD0400/akn_nl_act_pv30_2019_act3.xml"
ant cleanup -q