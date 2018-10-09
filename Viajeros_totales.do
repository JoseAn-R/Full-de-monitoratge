/*****************************************************************/
/* 
En los datos no coinciden los números de dosis 
de vacunas como ECE, EJ, FG, FT en la hoja de vacunas totales con
la hoja de vacunas administradas a viajeros, por lo que usamos 
los números totales de estas vacunas y no sólo los de los pacientes 
etiquetados como viajeros. Para el resto de vacunas, sólo contamos
las prescritas/administradas a los etiquetados como viajeros.

Primero marcamos como viajeros todos los registros que hayan sido etiquetados
como viajeros en alguna ocasión. 
Luego creamos una base de datos que contenga sólo a estos registros etiquetados
como viajeros (sólo el NHC y la etiqueta de viajero).
Finalmente, mezclamos esta última base de datos con la original, para que
todos los registros que coincidan en el NHC entre ambas estén etiquetados como
viajeros.
*/
/*****************************************************************/


 use Setembre2018

* Primero ordenamos los registros por 'nhc'

sort nhc

* Ahora creamos una base de datos sólo con los viajeros


tab via

gen via=1 if missing(viatger)==0

keep if via==1

keep nhc via

save ViatgersSetembre2018, replace

clear

* Ahora mezclamos ambas bases de datos

use Setembre2018

sum nhc

merge m:m nhc using ViatgersSetembre2018

sum nhc

tab viatger via, missing

* 165 viajeros

drop _merge

save Setembre2018, replace


* Ahora calculamos los datos de los viajeros

set more off

* Vacunas específicas de viajeros administradas en todos los registros 

tabstat va_c va_ece_a va_ece_i va_ej va_fg va_ft_im va_ft_vo va_ra igp_ra, ///
statistics(sum) col(stat) save

return list

mat list r(StatTotal)

* Transponemos esta matriz

mat VAV1 = r(StatTotal)'


* Ahora las vacunas no específicas de viajeros administradas en 
* registros etiquetados como viajeros

tabstat va_dtpa va_dtpapihib va_dtpapihibhb va_gt va_ha_a va_ha_i ///
va_hab_a va_hab_i va_hb_ad va_hb_40 va_hb_a va_hb_i va_hib va_hz ///
va_macwy_m va_macwy_n va_mb4 va_mc va_pi va_pn13 va_pn23 va_rv va_td va_v ///
va_vph2 va_vph4 va_vph9 va_xrp iga_hb iga_in iga_t if via==1, statistics(sum) col(stat) save

return list

mat list r(StatTotal)

* Transponemos esta matriz

mat VAV2 = r(StatTotal)'


* Ahora la quimioprofilaxis

tabstat nhc, s(count) by(quimioprofilaxi) col(stat) save

return list

mat AP = r(Stat1)
mat MQ = r(Stat2)

tabstat dosimefloquina, s(count) col(stat) save

return list

mat list r(StatTotal)

mat DMQ = r(StatTotal)

tabstat autott, s(count) col(stat) save

return list

mat list r(StatTotal)

mat AUTT = r(StatTotal)

* Por último calculamos el número de viajeros atendidos

set more off

duplicates report nhc if via==1, save

return list

* Exportamos los resultados a Excel

set more off


/*

* Textos de filas y columnas

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel A1=("Total viajeros"), font("Verdana", 14) bold hcenter 
putexcel B3=("Enero"), font("Verdana", 10) bold hcenter border(all)
putexcel C3=("Febrero"), font("Verdana", 10) bold hcenter border(all)
putexcel D3=("Marzo"), font("Verdana", 10) bold hcenter border(all)
putexcel E3=("Abril"), font("Verdana", 10) bold hcenter border(all)
putexcel F3=("Mayo"), font("Verdana", 10) bold hcenter border(all)
putexcel G3=("Junio"), font("Verdana", 10) bold hcenter border(all)
putexcel H3=("Julio"), font("Verdana", 10) bold hcenter border(all)
putexcel I3=("Agosto"), font("Verdana", 10) bold hcenter border(all)
putexcel J3=("Septiembre"), font("Verdana", 10) bold hcenter border(all)
putexcel K3=("Octubre"), font("Verdana", 10) bold hcenter border(all)
putexcel L3=("Noviembre"), font("Verdana", 10) bold hcenter border(all)
putexcel M3=("Diciembre"), font("Verdana", 10) bold hcenter border(all)
putexcel N3=("Total"), font("Verdana", 12) bold hcenter border(all)

putexcel A4=("Viajeros atendidos"), border(all)		
putexcel A5=("Vacunaciones/inmunoglobulinas administradas (Nº de dosis)"), border(all)		
putexcel A6=("Qumioprofilaxis del paludismo (Nº de viajeros)"), border(all)		
putexcel A7=("Tratamiento de reserva del paludismo (Nº de viajeros)"), border(all)		
putexcel A9=("Vacunas administradas"), font("Verdana", 12) bold hcenter border(all)	
putexcel A10=("V. anticolérica"), border(all)		
putexcel A11=("V. antiencefalitis centroeuropea (adultos)"), border(all)		
putexcel A12=("V. antiencefalitis centroeuropea (infantil)"), border(all)		
putexcel A13=("V. antiencefalitis japonesa"), border(all)		
putexcel A14=("V. contra la fiebre amarilla"), border(all)		
putexcel A15=("V. contra la fiebre tifoidea IM"), border(all)		
putexcel A16=("V. contra la fiebre tifoidea VO"), border(all)		
putexcel A17=("V. antirrábica"), border(all)		
putexcel A18=("Inmunoglobulina antirrábica"), border(all)		
	
putexcel A20=("V. contra la difteria, tétanos y tos ferina (adultos)"), border(all)
putexcel A21=("V. pentavalente (DTPa-PI-Hib)"), border(all)		
putexcel A22=("V. hexavalente (DTPa-PI-Hib-HB)"), border(all)		
putexcel A23=("V. antigripal"), border(all)		
putexcel A24=("V. antihepatitis A (adultos)"), border(all)		
putexcel A25=("V. antihepatitis A (infantil)"), border(all)		
putexcel A26=("V. antihepatitis A y B (adultos)"), border(all)		
putexcel A27=("V. antihepatitis A y B (infantil)"), border(all)		
putexcel A28=("V. antihepatitis B (adyuvada)"), border(all)		
putexcel A29=("V. antihepatitis B (40 mcg)"), border(all)		
putexcel A30=("V. antihepatitis B (adults)"), border(all)		
putexcel A31=("V. antihepatitis B (infantil)"), border(all)		
putexcel A32=("V. conjugada contra Haemophilus influenzae tipo b"), border(all)		
putexcel A33=("V. antiherpes zóster"), border(all)		
putexcel A34=("V. antimeningocócica conjugada tetravalente (Menveo)"), border(all)		
putexcel A35=("V. antimeningocócica conjugada tetravalente (Nimenrix)"), border(all)		
putexcel A36=("V. antimeningocócica B"), border(all)		
putexcel A37=("V. antimeningocócica C conjugada"), border(all)		
putexcel A38=("V. antipoliomielítica IM"), border(all)		
putexcel A39=("V. antineumocócica conjugada 13-valente"), border(all)		
putexcel A40=("V. antineumocócica 23-valente"), border(all)		
putexcel A41=("V. antirotavírica"), border(all)		
putexcel A42=("V. contra tétanos y difteria"), border(all)		
putexcel A43=("V. antivaricelosa"), border(all)		
putexcel A44=("V. contra el virus del papiloma humano tipo 16 y 18"), border(all)		
putexcel A45=("V. contra el virus del papiloma humano tetravalente"), border(all)		
putexcel A46=("V. contra el virus del papiloma humano nonavalente"), border(all)		
putexcel A47=("V. triple vírica (sarampión, rubeola y parotiditis)"), border(all)		
putexcel A48=("Inmunoglobulina antihepatitis B"), border(all)		
putexcel A49=("Inmunoglobulina inespecífica"), border(all)
putexcel A50=("Inmunoglobulina antitetánica"), border(all)


putexcel A52=("Prevención del paludismo") B52=("Cantidad"), ///
	font("Verdana", 10) bold border(bottom)
putexcel A53=("  Cloroquina (Nº de viajeros)") B53=(""), border(all)
putexcel A54=("  Cloroquina-Proguanil (Nº de viajeros)"), border(all)
putexcel A55=("  Atovacuona-Proguanil (Nº de viajeros)"), border(all)
putexcel A56=("  Mefloquina (Nº de viajeros)"),	border(all)
putexcel A57=("  Mefloquina (Nº de dosis)"), border(all)

putexcel A59=("Tratamiento de reserva del paludismo") B59=("Cantidad"), ///
	font("Verdana", 10) bold border(bottom)
putexcel A60=("  Atovacuona-Proguanil (Nº de viajeros)"), border(all)

* Datos y cambios de Enero 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel B4=`r(unique_value)', border(all)		
putexcel B5=formula(=SUM(B10:B50)), border(all)		
putexcel B6=formula(=SUM(B53:B56)), border(all)		
putexcel B7=formula(=B60), border(all)		
putexcel B9=("Vacunas administradas"), font("Verdana", 12) bold hcenter border(bottom)
putexcel B10=matrix(VAV1), border(all)	
putexcel B20=matrix(VAV2), border(all)	

putexcel B53=(""), border(all)
putexcel B54=(""), border(all)
putexcel B55=matrix(AP), border(all)
putexcel B56=matrix(MQ), border(all)
putexcel B57=matrix(DMQ), border(all)

* Datos y cambios de Febrero 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel C4=`r(unique_value)', border(all)		
putexcel C5=formula(=SUM(C10:C50)), border(all)		
putexcel C6=formula(=SUM(C53:C56)), border(all)		
putexcel C7=formula(=C60), border(all)		
putexcel A9=("Vacunas administradas"), font("Verdana", 12) bold hcenter border(bottom)
putexcel C10=matrix(VAV1), border(all)	
putexcel C20=matrix(VAV2), border(all)	

putexcel C53=(""), border(all)
putexcel C54=(""), border(all)
putexcel C55=matrix(AP), border(all)
putexcel C56=matrix(MQ), border(all)
putexcel C57=matrix(DMQ), border(all)

putexcel B59=(" ")
putexcel C60=matrix(AUTT), border(all)


* Datos y cambios de Marzo 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel D4=`r(unique_value)', border(all)		
putexcel D5=formula(=SUM(D10:D50)), border(all)		
putexcel D6=formula(=SUM(D53:D56)), border(all)		
putexcel D7=formula(=D60), border(all)	

putexcel D10=matrix(VAV1), border(all)	
putexcel D20=matrix(VAV2), border(all)	

putexcel D53=(""), border(all)
putexcel D54=(""), border(all)
putexcel D55=matrix(AP), border(all)
putexcel D56=matrix(MQ), border(all)
putexcel D57=matrix(DMQ), border(all)

putexcel D60=matrix(AUTT), border(all)

* Datos y cambios de Abril 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel E4=`r(unique_value)', border(all)		
putexcel E5=formula(=SUM(E10:E50)), border(all)		
putexcel E6=formula(=SUM(E53:E56)), border(all)		
putexcel E7=formula(=E60), border(all)	

putexcel E10=matrix(VAV1), border(all)	
putexcel E20=matrix(VAV2), border(all)	

putexcel E53=(""), border(all)
putexcel E54=(""), border(all)
putexcel E55=matrix(AP), border(all)
putexcel E56=matrix(MQ), border(all)
putexcel E57=matrix(DMQ), border(all)

putexcel E60=matrix(AUTT), border(all)

* Datos y cambios de Mayo 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel F4=`r(unique_value)', border(all)		
putexcel F5=formula(=SUM(F10:F50)), border(all)		
putexcel F6=formula(=SUM(F53:F56)), border(all)		
putexcel F7=formula(=F60), border(all)	

putexcel F10=matrix(VAV1), border(all)	
putexcel F20=matrix(VAV2), border(all)	

putexcel F53=(""), border(all)
putexcel F54=(""), border(all)
putexcel F55=matrix(AP), border(all)
putexcel F56=matrix(MQ), border(all)
putexcel F57=matrix(DMQ), border(all)

putexcel F60=matrix(AUTT), border(all)

* Datos y cambios de Junio 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel G4=`r(unique_value)', border(all)		
putexcel G5=formula(=SUM(G10:G50)), border(all)		
putexcel G6=formula(=SUM(G53:G56)), border(all)		
putexcel G7=formula(=G60), border(all)	

putexcel G10=matrix(VAV1), border(all)	
putexcel G20=matrix(VAV2), border(all)	

putexcel G53=(""), border(all)
putexcel G54=(""), border(all)
putexcel G55=matrix(AP), border(all)
putexcel G56=matrix(MQ), border(all)
putexcel G57=matrix(DMQ), border(all)

putexcel G60=matrix(AUTT), border(all)


* Datos y cambios de Julio 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel H4=`r(unique_value)', border(all)		
putexcel H5=formula(=SUM(H10:H50)), border(all)		
putexcel H6=formula(=SUM(H53:H56)), border(all)		
putexcel H7=formula(=H60), border(all)	

putexcel H10=matrix(VAV1), border(all)	
putexcel H20=matrix(VAV2), border(all)	

putexcel H53=(""), border(all)
putexcel H54=(""), border(all)
putexcel H55=matrix(AP), border(all)
putexcel H56=matrix(MQ), border(all)
putexcel H57=matrix(DMQ), border(all)

putexcel H60=matrix(AUTT), border(all)


* Datos y cambios de Agosto 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel I4=`r(unique_value)', border(all)		
putexcel I5=formula(=SUM(I10:I50)), border(all)		
putexcel I6=formula(=SUM(I53:I56)), border(all)		
putexcel I7=formula(=I60), border(all)	

putexcel I10=matrix(VAV1), border(all)	
putexcel I20=matrix(VAV2), border(all)	

putexcel I53=(""), border(all)
putexcel I54=(""), border(all)
putexcel I55=matrix(AP), border(all)
putexcel I56=matrix(MQ), border(all)
putexcel I57=matrix(DMQ), border(all)

putexcel I60=matrix(AUTT), border(all)

* Datos y cambios de Septiembre 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel J4=`r(unique_value)', border(all)		
putexcel J5=formula(=SUM(J10:J50)), border(all)		
putexcel J6=formula(=SUM(J53:J56)), border(all)		
putexcel J7=formula(=J60), border(all)	

putexcel J10=matrix(VAV1), border(all)	
putexcel J20=matrix(VAV2), border(all)	

putexcel J53=(""), border(all)
putexcel J54=(""), border(all)
putexcel J55=matrix(AP), border(all)
putexcel J56=matrix(MQ), border(all)
putexcel J57=matrix(DMQ), border(all)

putexcel J60=matrix(AUTT), border(all)

*/

* Datos y cambios de Octubre 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel K4=`r(unique_value)', border(all)		
putexcel K5=formula(=SUM(K10:K50)), border(all)		
putexcel K6=formula(=SUM(K53:K56)), border(all)		
putexcel K7=formula(=K60), border(all)	

putexcel K10=matrix(VAV1), border(all)	
putexcel K20=matrix(VAV2), border(all)	

putexcel K53=(""), border(all)
putexcel K54=(""), border(all)
putexcel K55=matrix(AP), border(all)
putexcel K56=matrix(MQ), border(all)
putexcel K57=matrix(DMQ), border(all)

putexcel K60=matrix(AUTT), border(all)

/*

* Datos y cambios de Noviembre 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel L4=`r(unique_value)', border(all)		
putexcel L5=formula(=SUM(L10:L50)), border(all)		
putexcel L6=formula(=SUM(L53:L56)), border(all)		
putexcel L7=formula(=L60), border(all)	

putexcel L10=matrix(VAV1), border(all)	
putexcel L20=matrix(VAV2), border(all)	

putexcel L53=(""), border(all)
putexcel L54=(""), border(all)
putexcel L55=matrix(AP), border(all)
putexcel L56=matrix(MQ), border(all)
putexcel L57=matrix(DMQ), border(all)

putexcel L60=matrix(AUTT), border(all)

* Datos y cambios de Diciembre 2018 

putexcel set Activitat_vacunes_2018, sheet("Total viatgers") modify 

putexcel M4=`r(unique_value)', border(all)		
putexcel M5=formula(=SUM(M10:M50)), border(all)		
putexcel M6=formula(=SUM(M53:M56)), border(all)		
putexcel M7=formula(=M60), border(all)	

putexcel M10=matrix(VAV1), border(all)	
putexcel M20=matrix(VAV2), border(all)	

putexcel M53=(""), border(all)
putexcel M54=(""), border(all)
putexcel M55=matrix(AP), border(all)
putexcel M56=matrix(MQ), border(all)
putexcel M57=matrix(DMQ), border(all)

putexcel M60=matrix(AUTT), border(all)

*/
