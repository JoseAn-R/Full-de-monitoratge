/************************************************************************
Hacemos tablas sobre vacunas totalesprescritas y administradas 
y las exportamos a Excel.
Para ello nos aprovechamos de las matrices que se crean con el comando
'tabstat' 
************************************************************************/

* Primero las vacunas prescritas

use "Setembre2018"

set more off

tabstat vp_c vp_dtpa vp_dtpapihib vp_dtpapihibhb vp_ece_a vp_ece_i ///
vp_ej vp_fg vp_ft_im vp_ft_vo vp_ha_a vp_ha_i vp_hab_a vp_hab_i ///
vp_hb_ad vp_hb_40 vp_hb_a vp_hb_i vp_hib vp_hz  vp_macwy_m vp_macwy_n ///
vp_mb4 vp_mc vp_pi vp_pn13 vp_pn23 vp_ra vp_rv vp_td vp_v vp_vph2 vp_vph4 ///
vp_vph9 vp_xrp vp_xrpv igp_hb igp_ra igp_in igp_t vp_g60 vp_g61 vp_g62 vp_g63 ///
vp_g64, statistics(sum) col(stat) save

return list

mat list r(StatTotal)

* Transponemos esta matriz

mat VP = r(StatTotal)'

* Las vacunas administradas

tabstat va_c va_dtpa va_dtpapihib va_dtpapihibhb va_ece_a va_ece_i va_ej ///
va_fg va_ft_im va_ft_vo va_ha_a va_ha_i va_hab_a va_hab_i va_hb_ad ///
va_hb_40 va_hb_a va_hb_i va_hib va_hz va_macwy_m va_macwy_n va_mb4 ///
va_mc va_pi va_pn13 va_pn23 va_ra va_rv va_td va_v va_vph2 va_vph4 va_vph9 ///
va_xrp va_xrpv iga_hb iga_ra iga_in iga_t va_g60 va_g61 va_g62 va_g63 ///
va_g64, statistics(sum) col(stat) save

return list

mat list r(StatTotal)

* Transponemos esta matriz

mat VA = r(StatTotal)'

* Exportamos los resultados a Excel

/*
putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 

putexcel A1=("Total vacunes"), font("Verdana", 14) bold hcenter 
putexcel B3:C3, merge
putexcel B3=("Gener"), font("Verdana", 10) bold hcenter 
putexcel B4=("P*") C4=("A**"), font("Verdana", 10) bold hcenter border(all)
putexcel D3:E3, merge 
putexcel D3=("Febrer"), font("Verdana", 10) bold hcenter 
putexcel D4=("P") E4=("A"), font("Verdana", 10) bold hcenter border(all)
putexcel F3:G3, merge
putexcel F3=("Març"), font("Verdana", 10) bold hcenter 
putexcel F4=("P") G4=("A"), font("Verdana", 10) bold hcenter border(all)
putexcel H3:I3, merge
putexcel H3=("Abril"), font("Verdana", 10) bold hcenter
putexcel H4=("P") I4=("A"), font("Verdana", 10) bold hcenter border(all)
putexcel J3:K3, merge
putexcel J3=("Maig"), font("Verdana", 10) bold hcenter 
putexcel J4=("P") K4=("A"), font("Verdana", 10) bold hcenter border(all)
putexcel L3:M3, merge
putexcel L3=("Juny"), font("Verdana", 10) bold hcenter 
putexcel L4=("P") M4=("A"), font("Verdana", 10) bold hcenter border(all)
putexcel N3:O3, merge
putexcel N3=("Juliol"), font("Verdana", 10) bold hcenter
putexcel N4=("P") O4=("A"), font("Verdana", 10) bold hcenter border(all)
putexcel P3:Q3, merge
putexcel P3=("Agost"), font("Verdana", 10) bold hcenter
putexcel P4=("P") Q4=("A"), font("Verdana", 10) bold hcenter border(all)
putexcel R3:S3, merge
putexcel R3=("Setembre"), font("Verdana", 10) bold hcenter
putexcel R4=("P") S4=("A"), font("Verdana", 10) bold hcenter border(all)
putexcel T3:U3, merge
putexcel T3=("Octubre"), font("Verdana", 10) bold hcenter
putexcel T4=("P") U4=("A"), font("Verdana", 10) bold hcenter border(all)
putexcel V3:W3, merge
putexcel V3=("Novembre"), font("Verdana", 10) bold hcenter
putexcel V4=("P") W4=("A"), font("Verdana", 10) bold hcenter border(all)
putexcel X3:Y3, merge
putexcel X3=("Desembre"), font("Verdana", 10) bold hcenter 
putexcel X4=("P") Y4=("A"), font("Verdana", 10) bold hcenter border(all)
putexcel Z3:AA3, merge
putexcel Z3=("Total"), font("Verdana", 12) bold hcenter 
putexcel Z4=("P") AA4=("A"), font("Verdana", 10) bold hcenter border(all)


putexcel A5=("Vacuna C (anticolèrica)"), border(all)
putexcel A6=("Vacuna dTpa (antidiftèrica, antitetànica i antipertússica acel·lular per a adults)"), border(all)
putexcel A7=("Vacuna DTPa-PI-Hib (pentavalent)"), border(all)
putexcel A8=("Vacuna DTPa-PI-Hib-HB (hexavalent)"), border(all)
putexcel A9=("Vacuna ECE (antiencefalitis centreeuropea) per a adults"), border(all)
putexcel A10=("Vacuna ECE (antiencefalitis centreeuropea) infantil"), border(all)
putexcel A11=("Vacuna EJ (antiencefalitis japonesa)"), border(all)
putexcel A12=("Vacuna FG (antiamaríl·lica)"), border(all)
putexcel A13=("Vacuna FT (antitifoïdal) IM"), border(all)
putexcel A14=("Vacuna FT (antitifoïdal) VO"), border(all)
putexcel A15=("Vacuna HA (antihepatitis A) per a adults"), border(all)
putexcel A16=("Vacuna HA (antihepatitis A) infantil"), border(all)
putexcel A17=("Vacuna HAB (antihepatitis A i B) per a adults"), border(all)
putexcel A18=("Vacuna HAB (antihepatitis A i B) infantil"), border(all)
putexcel A19=("Vacuna HB (antihepatitis B) adjuvada"), border(all)
putexcel A20=("Vacuna HB (antihepatitis B) 40 mcg"), border(all)
putexcel A21=("Vacuna HB (antihepatitis B) per a adults"), border(all)
putexcel A22=("Vacuna HB (antihepatitis B) infantil"), border(all)
putexcel A23=("Vacuna Hib (anti-Haemophilus influenzae tipus b conjugada)"), border(all)
putexcel A24=("Vacuna HZ (antiherpes zòster)"), border(all)
putexcel A25=("Vacuna MACWY (antimeningocòccica conjugada tetravalent) Menveo (R)"), border(all)
putexcel A26=("Vacuna MACWY (antimeningocòccica conjugada tetravalent) Nimenrix (R)"), border(all)
putexcel A27=("Vacuna MB4 (antimeningococ B de quatre components)"), border(all)
putexcel A28=("Vacuna MC (antimeningococ C conjugada)"), border(all)
putexcel A29=("Vacuna PI (antipoliomielítica injectable)"), border(all)
putexcel A30=("Vacuna Pn13 (antipneumocòccica conjugada 13-valent)"), border(all)
putexcel A31=("Vacuna Pn23 (antipneumocòccica 23-valent)"), border(all)
putexcel A32=("Vacuna Ra (antiràbica)"), border(all)
putexcel A33=("Vacuna RV (antirotavírica)"), border(all)
putexcel A34=("Vacuna Td (antitetànica i antidiftèrica)"), border(all)
putexcel A35=("Vacuna V (antivaricel·losa)"), border(all)
putexcel A36=("Vacuna VPH2 (antivirus del papil·loma humà tipus 16 i 18)"), border(all)
putexcel A37=("Vacuna VPH4 (antivirus del papil·loma humà tetravalent)"), border(all)
putexcel A38=("Vacuna VPH9 (antivirus del papil·loma humà nonavalent)"), border(all)
putexcel A39=("Vacuna XRP (antixarampionosa, antirubeòlica i antiparotidítica)"), border(all)
putexcel A40=("Vacuna XRPV (antixarampionosa, antirubeòlica, antiparotidítica i antivaricel·losa)"), border(all)
putexcel A41=("Immunoglobulina anti-hepatitis B"), border(all)
putexcel A42=("Immunoglobulina antiràbica"), border(all)
putexcel A43=("Immunoglobulina inespecífica"), border(all)
putexcel A44=("Immunoglobulina antitetànica"), border(all)
putexcel A45=("Vacuna antigripal Afluria"), border(all)
putexcel A46=("Vacuna antigripal Chiroflu"), border(all)
putexcel A47=("Vacuna antigripal Chiromas"), border(all)
putexcel A48=("Vacuna antigripal Fluarix Tetra"), border(all)
putexcel A49=("Vacuna antigripal Intanza"), border(all)

putexcel A51=("*P: vacunes prescrites")
putexcel A52=("**A: vacunes administrades")

* Datos de Enero 2018
putexcel B5=matrix(VP) C5=matrix(VA), border(all)

* Datos de Febrero 2018

putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 
putexcel D5=matrix(VP) E5=matrix(VA), border(all)

* Datos de Marzo 2018

putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 
putexcel F5=matrix(VP) G5=matrix(VA), border(all)

* Datos de Abril 2018

putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 
putexcel H5=matrix(VP) I5=matrix(VA), border(all)

* Datos de Mayo 2018

putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 
putexcel J5=matrix(VP) K5=matrix(VA), border(all)


* Datos de Junio 2018

putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 
putexcel L5=matrix(VP) M5=matrix(VA), border(all)


* Datos de Julio 2018

putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 
putexcel N5=matrix(VP) O5=matrix(VA), border(all)


* Datos de Agosto 2018

putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 
putexcel P5=matrix(VP) Q5=matrix(VA), border(all)


* Datos de Septiembre 2018

putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 
putexcel R5=matrix(VP) S5=matrix(VA), border(all)

*/

* Datos de Octubre 2018

putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 
putexcel T5=matrix(VP) U5=matrix(VA), border(all)

/*

* Datos de Noviembre 2018

putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 
putexcel V5=matrix(VP) W5=matrix(VA), border(all)

* Datos de Diciembre 2018

putexcel set Activitat_vacunes_2018, sheet("Total vacunes") modify 
putexcel X5=matrix(VP) Y5=matrix(VA), border(all)
*/
