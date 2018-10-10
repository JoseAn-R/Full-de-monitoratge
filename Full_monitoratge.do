/*****************************************************************/
* Análisis del "Full de monitoratge" del SAP 
* 2018
/*****************************************************************/
	
* Nos vamos al directorio de interés


cd "D:/Users/jarodrig/Google Drive/Full de monitoratge MPiE"

cd "/Users/paganus/Google Drive/Full de monitoratge MPiE"


/****************************************************************
Captura y manipulación de los datos del archivo de Excel del 
'Full de monitoratge'
*****************************************************************/


* Capturamos los datos

set more off

import excel "Setembre2018.xls", sheet("Sheet1") ///
	firstrow case(lower) allstring
	

* Les echamos una ojeada

des

* Modificamos variables

destring pacient, gen(nhc)
list pacient nhc in 1/30

/* 
Damos formato a las fechas, teniendo en cuenta que Stata las captura
desde Excel en formato MDY aunque en Excel estén en DMY
*/
/*
gen dnaix=date(datadenaixement, "MDY")
label var dnaix "Data de naixement"
*/

gen dnaix=date(naixement_data, "MDY")
label var dnaix "Data de naixement"

/*
gen dent=date(datadentrada, "MDY")
label var dent "Data d'entrada"
*/

gen dent=date(entrada_data, "MDY")
label var dent "Data d'entrada"
format %td dnaix dent

list dnaix naixement_data in 1/150
drop naixement_data

list dent entrada_data in 1/150
drop entrada_data

* Modificamos variables

set more off

destring dosimefloquina, replace
label var dosimefloquina "Dosis d'antipalúdic"


gen autott=.
replace autott=1 if tractpaludisme=="Malarone"
label var autott "Autotractament amb Malarone"


label define vacunas 2 "C" 4 "dTpa" 5 "DTPa-PI-Hib" 6 "DTPa-PI-Hib-HB" ///
	7 "ECE (adults)" 8 "ECE (infantil)" 9 "EJ" 10 "FG" 11 "FT (IM)" ///
	12 "FT (VO)" 14 "HA (adults)" 15 "HA (infantil)" 16 "HAB (adults)" ///
	17 "HAB (infantil)" 18 "HB (adjuvada)" 19 "HB (40 mcg)" 20 "HB (adults)" ///
	21 "HB (infantil)" 22 "Hib" 23 "HZ" 24 "MA" 25 "MACWY (Menveo)" ///
	26 "MACWY (Nimenrix)" 27 "MB4" 28 "MC" 29 "PI" 30 "Pn13" 31 "Pn23" ///
	32 "Ra" 33 "RV" 34 "Td" 35 "V" 36 "VPH2" 37 "VPH9" 38 "VPH9" 40 "XRP" ///
	41 "XRPV" 50 "Ig antiHB" 51 "Ig antiRa" 52 "Ig inesp." 53 "Ig antiT" ///
	60 "Afluria" 61 "Chiroflu" 62 "Chiromas" 63 "Fluarix Tetra" 64 "Intanza"


	
foreach num of numlist 1 2 3 4 5 {
gen va`num'=.
replace va`num'=2 if vadmin`num'=="Anticol XXX"
replace va`num'=4 if vadmin`num'=="Antidiftèria - antitetànica - antipertússica adults (dTpa)"
replace va`num'=5 if vadmin`num'=="DTPa- VPI- Hib (pentavalent)"
replace va`num'=6 if vadmin`num'=="DTPa- VPI- Hib - VHB (hexavalent)"
replace va`num'=7 if vadmin`num'=="Encefalitis centeroeuropea adults"
replace va`num'=8 if vadmin`num'=="Encefalitis centeroeuropea infants"
replace va`num'=9 if vadmin`num'=="Encefalitis japonesa"
replace va`num'=10 if vadmin`num'=="Febre groga"
replace va`num'=11 if vadmin`num'=="Antitifoïdal intramuscular"
replace va`num'=12 if vadmin`num'=="Antitifoïdal oral"
replace va`num'=14 if vadmin`num'=="Hepatitis A adults"
replace va`num'=15 if vadmin`num'=="Hepatitis A pediàtrica"
replace va`num'=16 if vadmin`num'=="Hepatitis A+B adults"
replace va`num'=17 if vadmin`num'=="Hepatitis A+B pediàtrica"
replace va`num'=18 if vadmin`num'=="Hepatitis B - 40 mg Adyugada"
replace va`num'=19 if vadmin`num'=="Hepatitis B 40 mg"
replace va`num'=20 if vadmin`num'=="Hepatitis B adults"
replace va`num'=21 if vadmin`num'=="Hepatitis B pediàtrica"
replace va`num'=22 if vadmin`num'=="Aniithaemophilus influenza b(Hib)"
replace va`num'=23 if vadmin`num'=="Antiherpes Zoster"
replace va`num'=24 if vadmin`num'=="Antimeningococ A conj."
replace va`num'=25 if vadmin`num'=="Antimeningococòccica tetravalent (ACYW135) conjugada (Meveo)"
replace va`num'=26 if vadmin`num'=="Antimeningococòccica tetravalent (ACYW135) conjugada (Nimenrix)"
replace va`num'=27 if vadmin`num'=="Antimeningococòccica B"
replace va`num'=28 if vadmin`num'=="Antimeningococòccica C conjugada"
replace va`num'=29 if vadmin`num'=="Antipolimielitica (VPI)"
replace va`num'=30 if vadmin`num'=="Antipneumocòccica 13 valent conjugada"
replace va`num'=31 if vadmin`num'=="Antipneumocòccica 23 valent"
replace va`num'=32 if vadmin`num'=="Antiràbica"
replace va`num'=33 if vadmin`num'=="Antirotavírica"
replace va`num'=34 if vadmin`num'=="Antidiftèria - antitetànica (dT)"
replace va`num'=35 if vadmin`num'=="Vacuna antivaricel·la"
replace va`num'=36 if vadmin`num'=="Vacuna del virus papil·loma humà (Bivalent)"
replace va`num'=37 if vadmin`num'=="Vacuna del virus papil·loma humà (Tetravalent)"
replace va`num'=38 if vadmin`num'=="Vacuna del virus papil·loma humà (Nonavalent)"
replace va`num'=40 if vadmin`num'=="Antiparotiditis - antirubèola - antixarampió (triple virica)"
replace va`num'=41 if vadmin`num'=="Antiparotiditis - antirubèola - antixarampió - varicel.la"
replace va`num'=50 if vadmin`num'=="Inmunoglobulina anti-hepatitits B"
replace va`num'=51 if vadmin`num'=="Inmunoglobulina antiràbica"	
replace va`num'=52 if vadmin`num'=="Inmunoglobulina inespecífica"
replace va`num'=53 if vadmin`num'=="Inmunoglobulina antitetànica"
replace va`num'=60 if vadmin`num'=="Antigripal fraccionada"
replace va`num'=61 if vadmin`num'=="Antigripal subunitats"
replace va`num'=62 if vadmin`num'=="Antigripal adyugada"
replace va`num'=63 if vadmin`num'=="Grip ( Virosomes)"
replace va`num'=64 if vadmin`num'=="Grip ( Intradèrmica)"

label var va`num' "Vacuna administrada `num'"

label values va`num' vacunas

gen vp`num'=.
replace vp`num'=2 if vposible`num'=="Anticol XXX"
replace vp`num'=4 if vposible`num'=="Antidiftèria - antitetànica - antipertússica adults (dTpa)"
replace vp`num'=5 if vposible`num'=="DTPa- VPI- Hib (pentavalent)"
replace vp`num'=6 if vposible`num'=="DTPa- VPI- Hib - VHB (hexavalent)"
replace vp`num'=7 if vposible`num'=="Encefalitis centeroeuropea adults"
replace vp`num'=8 if vposible`num'=="Encefalitis centeroeuropea infants"
replace vp`num'=9 if vposible`num'=="Encefalitis japonesa"
replace vp`num'=10 if vposible`num'=="Febre groga"
replace vp`num'=11 if vposible`num'=="Antitifoïdal intramuscular"
replace vp`num'=12 if vposible`num'=="Antitifoïdal oral"
replace vp`num'=14 if vposible`num'=="Hepatitis A adults"
replace vp`num'=15 if vposible`num'=="Hepatitis A pediàtrica"
replace vp`num'=16 if vposible`num'=="Hepatitis A+B adults"
replace vp`num'=17 if vposible`num'=="Hepatitis A+B pediàtrica"
replace vp`num'=18 if vposible`num'=="Hepatitis B - 40 mg Adyugada"
replace vp`num'=19 if vposible`num'=="Hepatitis B 40 mg"
replace vp`num'=20 if vposible`num'=="Hepatitis B adults"
replace vp`num'=21 if vposible`num'=="Hepatitis B pediàtrica"
replace vp`num'=22 if vposible`num'=="Aniithaemophilus influenza b(Hib)"
replace vp`num'=23 if vposible`num'=="Antiherpes Zoster"
replace vp`num'=24 if vposible`num'=="Antimeningococ A conj."
replace vp`num'=25 if vposible`num'=="Antimeningococòccica tetravalent (ACYW135) conjugada (Meveo)"
replace vp`num'=26 if vposible`num'=="Antimeningococòccica tetravalent (ACYW135) conjugada (Nimenrix)"
replace vp`num'=27 if vposible`num'=="Antimeningococòccica B"
replace vp`num'=28 if vposible`num'=="Antimeningococòccica C conjugada"
replace vp`num'=29 if vposible`num'=="Antipolimielitica (VPI)"
replace vp`num'=30 if vposible`num'=="Antipneumocòccica 13 valent conjugada"
replace vp`num'=31 if vposible`num'=="Antipneumocòccica 23 valent"
replace vp`num'=32 if vposible`num'=="Antiràbica"
replace vp`num'=33 if vposible`num'=="Antirotavírica"
replace vp`num'=34 if vposible`num'=="Antidiftèria - antitetànica (dT)"
replace vp`num'=35 if vposible`num'=="Vacuna antivaricel·la"
replace vp`num'=36 if vposible`num'=="Vacuna del virus papil·loma humà (Bivalent)"
replace vp`num'=37 if vposible`num'=="Vacuna del virus papil·loma humà (Tetravalent)"
replace vp`num'=38 if vposible`num'=="Vacuna del virus papil·loma humà (Nonavalent)"
replace vp`num'=40 if vposible`num'=="Antiparotiditis - antirubèola - antixarampió (triple virica)"
replace vp`num'=41 if vposible`num'=="Antiparotiditis - antirubèola - antixarampió - varicel.la"
replace vp`num'=50 if vposible`num'=="Inmunoglobulina anti-hepatitits B"
replace vp`num'=51 if vposible`num'=="Inmunoglobulina antiràbica"
replace vp`num'=52 if vposible`num'=="Inmunoglobulina inespecífica"
replace vp`num'=53 if vposible1=="Inmunoglobulina antitetànica"
replace vp`num'=60 if vposible`num'=="Antigripal fraccionada"
replace vp`num'=61 if vposible`num'=="Antigripal subunitats"
replace vp`num'=62 if vposible`num'=="Antigripal adyugada"
replace vp`num'=63 if vposible`num'=="Grip ( Virosomes)"
replace vp`num'=64 if vposible`num'=="Grip ( Intradèrmica)"

label var vp`num' "Vacuna prescrita `num'"

label values vp`num' vacunas
}



list vadmin1 va1 in 1/30 
list vposible1 vp1 in 1/30

list vadmin2 va2 in 1/30 
list vposible2 vp2 in 1/30

list vadmin3 va3 in 1/30 
list vposible3 vp3 in 1/30

list vadmin4 va4 in 1/30 
list vposible4 vp4 in 1/30

list vadmin5 va5 in 1/30 
list vposible5 vp5 in 1/30

drop vadmin* vposible*

* Creamos nuevas variables
* Vacunas administradas

gen va_c=1 if va1==2 | va2==2  | va3==2 | va4==2 | va5==2
label var va_c "Vacuna C administrada"

gen va_dtpa=1 if va1==4 | va2==4  | va3==4 | va4==4 | va5==4
label var va_dtpa "Vacuna dTpa administrada"

gen va_dtpapihib=1 if va1==5 | va2==5  | va3==5 | va4==5 | va5==5
label var va_dtpapihib "Vacuna DTPa-PI-Hib administrada"

gen va_dtpapihibhb=1 if va1==6 | va2==6  | va3==6 | va4==6 | va5==6
label var va_dtpapihibhb "Vacuna DTPa-PI-Hib-HB administrada"

gen va_ece_a=1 if va1==7 | va2==7  | va3==7 | va4==7 | va5==7
label var va_ece_a "Vacuna ECE (adults) administrada"

gen va_ece_i=1 if va1==8 | va2==8  | va3==8 | va4==8 | va5==8
label var va_ece_i "Vacuna ECE (infantil) administrada"

gen va_ej=1 if va1==9 | va2==9  | va3==9 | va4==9 | va5==9
label var va_ej "Vacuna EJ administrada"

gen va_fg=1 if va1==10 | va2==10  | va3==10 | va4==10 | va5==10
label var va_fg "Vacuna FG administrada"

gen va_ft_im=1 if va1==11 | va2==11  | va3==11 | va4==11 | va5==11
label var va_ft_im "Vacuna FT (IM) administrada"

gen va_ft_vo=1 if va1==12 | va2==12  | va3==12 | va4==12 | va5==12
label var va_ft_vo "Vacuna FT (VO) administrada"

gen va_ha_a=1 if va1==14 | va2==14  | va3==14 | va4==14 | va5==14
label var va_ha_a "Vacuna HA (adults) administrada" 

gen va_ha_i=1 if va1==15 | va2==15  | va3==15 | va4==15 | va5==15
label var va_ha_i "Vacuna HA (infantil) administrada" 

gen va_hab_a=1 if va1==16 | va2==16  | va3==16 | va4==16 | va5==16
label var va_hab_a "Vacuna HAB (adults) administrada" 

gen va_hab_i=1 if va1==17 | va2==17  | va3==17 | va4==17 | va5==17
label var va_hab_i "Vacuna HAB (infantil) administrada" 

gen va_hb_ad=1 if va1==18 | va2==18  | va3==18 | va4==18 | va5==18
label var va_hb_ad "Vacuna HB (adjuvada) administrada" 

gen va_hb_40=1 if va1==19 | va2==19  | va3==19 | va4==19 | va5==19
label var va_hb_40 "Vacuna HB (40 mcg) administrada" 

gen va_hb_a=1 if va1==20 | va2==20  | va3==20 | va4==20 | va5==20
label var va_hb_a "Vacuna HB (adults) administrada" 

gen va_hb_i=1 if va1==21 | va2==21  | va3==21 | va4==21 | va5==21
label var va_hb_i "Vacuna HB (infantil) administrada" 

gen va_hib=1 if va1==22 | va2==22  | va3==22 | va4==22 | va5==22
label var va_hib "Vacuna Hib administrada" 

gen va_hz=1 if va1==23 | va2==23  | va3==23 | va4==23 | va5==23
label var va_hz "Vacuna HZ administrada" 

gen va_macwy_m=1 if va1==25 | va2==25  | va3==25 | va4==25 | va5==25
label var va_macwy_m "Vacuna MACWY (Menveo) administrada" 

gen va_macwy_n=1 if va1==26 | va2==26  | va3==26 | va4==26 | va5==26
label var va_macwy_n "Vacuna MACWY (Nimenrix) administrada" 

gen va_mb4=1 if va1==27 | va2==27  | va3==27 | va4==27 | va5==27
label var va_mb4 "Vacuna MB4 administrada" 

gen va_mc=1 if va1==28 | va2==28  | va3==28 | va4==28 | va5==28
label var va_mc "Vacuna MC administrada" 

gen va_pi=1 if va1==29 | va2==29  | va3==29 | va4==29 | va5==29
label var va_pi "Vacuna PI administrada" 

gen va_pn13=1 if va1==30 | va2==30  | va3==30 | va4==30 | va5==30
label var va_pn13 "Vacuna Pn13 administrada" 

gen va_pn23=1 if va1==31 | va2==31  | va3==31 | va4==31 | va5==31
label var va_pn23 "Vacuna Pn23 administrada" 

gen va_ra=1 if va1==32 | va2==32  | va3==32 | va4==32 | va5==32
label var va_ra "Vacuna Ra administrada" 

gen va_rv=1 if va1==33 | va2==33  | va3==33 | va4==33 | va5==33
label var va_rv "Vacuna RV administrada" 

gen va_td=1 if va1==34 | va2==34  | va3==34 | va4==34 | va5==34
label var va_td "Vacuna Td administrada" 

gen va_v=1 if va1==35 | va2==35  | va3==35 | va4==35 | va5==35
label var va_v "Vacuna V administrada" 

gen va_vph2=1 if va1==36 | va2==36  | va3==36 | va4==36 | va5==36
label var va_vph2 "Vacuna VPH2 administrada" 

gen va_vph4=1 if va1==37 | va2==37  | va3==37 | va4==37 | va5==37
label var va_vph4 "Vacuna VPH9 administrada" 

gen va_vph9=1 if va1==38 | va2==38  | va3==38 | va4==38 | va5==38
label var va_vph9 "Vacuna VPH9 administrada" 

gen va_xrp=1 if va1==40 | va2==40  | va3==40 | va4==40 | va5==40
label var va_xrp "Vacuna XRP administrada" 

gen va_xrpv=1 if va1==41 | va2==41  | va3==41 | va4==41 | va5==41
label var va_xrpv "Vacuna XRPV administrada" 

gen iga_hb=1 if va1==50 | va2==50  | va3==50 | va4==50 | va5==50
label var iga_hb "Ig. anti-HB administrada"

gen iga_ra=1 if va1==51 | va2==51  | va3==51 | va4==51 | va5==51
label var iga_ra "Ig. antiràbica administrada"

gen iga_in=1 if va1==52 | va2==52  | va3==52 | va4==52 | va5==52
label var iga_in "Ig. inespecífica administrada"

gen iga_t=1 if va1==53 | va2==53  | va3==53 | va4==53 | va5==53
label var iga_t "Ig. antitetànica administrada"

gen va_g60=1 if va1==60 | va2==60  | va3==60 | va4==60 | va5==60
label var va_g60 "Vacuna G administrada: Afluria"

gen va_g61=1 if va1==61 | va2==61  | va3==61 | va4==61 | va5==61
label var va_g61 "Vacuna G administrada: Chiroflu"

gen va_g62=1 if va1==62 | va2==62  | va3==62 | va4==62 | va5==62
label var va_g62 "Vacuna G administrada: Chiromas"

gen va_g63=1 if va1==63 | va2==63  | va3==63 | va4==63 | va5==63
label var va_g63 "Vacuna G administrada: Fluarix Tetra"

gen va_g64=1 if va1==64 | va2==64  | va3==64 | va4==64 | va5==64
label var va_g64 "Vacuna G administrada: Intanza"

gen va_gt=1 if va_g60==1 | va_g61==1 | va_g62==1 | va_g63==1 | va_g64==1 
label var va_gt "Vacuna G administrada"  


* Vacunas prescritas

gen vp_c=1 if vp1==2 | vp2==2  | vp3==2 | vp4==2 | vp5==2
label var vp_c "Vacuna C prescrita"

gen vp_dtpa=1 if vp1==4 | vp2==4  | vp3==4 | vp4==4 | vp5==4
label var vp_dtpa "Vacuna dTpa prescrita"

gen vp_dtpapihib=1 if vp1==5 | vp2==5  | vp3==5 | vp4==5 | vp5==5
label var vp_dtpapihib "Vacuna DTPa-PI-Hib prescrita"

gen vp_dtpapihibhb=1 if vp1==6 | vp2==6  | vp3==6 | vp4==6 | vp5==6
label var vp_dtpapihibhb "Vacuna DTPa-PI-Hib-HB prescrita"

gen vp_ece_a=1 if vp1==7 | vp2==7  | vp3==7 | vp4==7 | vp5==7
label var vp_ece_a "Vacuna ECE (adults) prescrita"

gen vp_ece_i=1 if vp1==8 | vp2==8  | vp3==8 | vp4==8 | vp5==8
label var vp_ece_i "Vacuna ECE (infantil) prescrita"

gen vp_ej=1 if vp1==9 | vp2==9  | vp3==9 | vp4==9 | vp5==9
label var vp_ej "Vacuna EJ prescrita"

gen vp_fg=1 if vp1==10 | vp2==10  | vp3==10 | vp4==10 | vp5==10
label var vp_fg "Vacuna FG prescrita"

gen vp_ft_im=1 if vp1==11 | vp2==11  | vp3==11 | vp4==11 | vp5==11
label var vp_ft_im "Vacuna FT (IM) prescrita"

gen vp_ft_vo=1 if vp1==12 | vp2==12  | vp3==12 | vp4==12 | vp5==12
label var vp_ft_vo "Vacuna FT (VO) prescrita"

gen vp_ha_a=1 if vp1==14 | vp2==14  | vp3==14 | vp4==14 | vp5==14
label var vp_ha_a "Vacuna HA (adults) prescrita" 

gen vp_ha_i=1 if vp1==15 | vp2==15  | vp3==15 | vp4==15 | vp5==15
label var vp_ha_i "Vacuna HA (infantil) prescrita" 

gen vp_hab_a=1 if vp1==16 | vp2==16  | vp3==16 | vp4==16 | vp5==16
label var vp_hab_a "Vacuna HAB (adults) prescrita" 

gen vp_hab_i=1 if vp1==17 | vp2==17  | vp3==17 | vp4==17 | vp5==17
label var vp_hab_i "Vacuna HAB (infantil) prescrita" 

gen vp_hb_ad=1 if vp1==18 | vp2==18  | vp3==18 | vp4==18 | vp5==18
label var vp_hb_ad "Vacuna HB (adjuvada) prescrita" 

gen vp_hb_40=1 if vp1==19 | vp2==19  | vp3==19 | vp4==19 | vp5==19
label var vp_hb_40 "Vacuna HB (40 mcg) prescrita" 

gen vp_hb_a=1 if vp1==20 | vp2==20  | vp3==20 | vp4==20 | vp5==20
label var vp_hb_a "Vacuna HB (adults) prescrita" 

gen vp_hb_i=1 if vp1==21 | vp2==21  | vp3==21 | vp4==21 | vp5==21
label var vp_hb_i "Vacuna HB (infantil) prescrita" 

gen vp_hib=1 if vp1==22 | vp2==22  | vp3==22 | vp4==22 | vp5==22
label var vp_hib "Vacuna Hib prescrita" 

gen vp_hz=1 if vp1==23 | vp2==23  | vp3==23 | vp4==23 | vp5==23
label var vp_hz "Vacuna HZ prescrita" 

gen vp_macwy_m=1 if vp1==25 | vp2==25  | vp3==25 | vp4==25 | vp5==25
label var vp_macwy_m "Vacuna MACWY (Menveo) prescrita" 

gen vp_macwy_n=1 if vp1==26 | vp2==26  | vp3==26 | vp4==26 | vp5==26
label var vp_macwy_n "Vacuna MACWY (Nimenrix) prescrita" 

gen vp_mb4=1 if vp1==27 | vp2==27  | vp3==27 | vp4==27 | vp5==27
label var vp_mb4 "Vacuna MB4 prescrita" 

gen vp_mc=1 if vp1==28 | vp2==28  | vp3==28 | vp4==28 | vp5==28
label var vp_mc "Vacuna MC prescrita" 

gen vp_pi=1 if vp1==29 | vp2==29  | vp3==29 | vp4==29 | vp5==29
label var vp_pi "Vacuna PI prescrita" 

gen vp_pn13=1 if vp1==30 | vp2==30  | vp3==30 | vp4==30 | vp5==30
label var vp_pn13 "Vacuna Pn13 prescrita" 

gen vp_pn23=1 if vp1==31 | vp2==31  | vp3==31 | vp4==31 | vp5==31
label var vp_pn23 "Vacuna Pn23 prescrita" 

gen vp_ra=1 if vp1==32 | vp2==32  | vp3==32 | vp4==32 | vp5==32
label var vp_ra "Vacuna Ra prescrita" 

gen vp_rv=1 if vp1==33 | vp2==33  | vp3==33 | vp4==33 | vp5==33
label var vp_rv "Vacuna RV prescrita" 

gen vp_td=1 if vp1==34 | vp2==34  | vp3==34 | vp4==34 | vp5==34
label var vp_td "Vacuna Td prescrita" 

gen vp_v=1 if vp1==35 | vp2==35  | vp3==35 | vp4==35 | vp5==35
label var vp_v "Vacuna V prescrita" 

gen vp_vph2=1 if vp1==36 | vp2==36  | vp3==36 | vp4==36 | vp5==36
label var vp_vph2 "Vacuna VPH2 prescrita" 

gen vp_vph4=1 if vp1==37 | vp2==37  | vp3==37 | vp4==37 | vp5==37
label var vp_vph4 "Vacuna VPH9 prescrita" 

gen vp_vph9=1 if vp1==38 | vp2==38  | vp3==38 | vp4==38 | vp5==38
label var vp_vph9 "Vacuna VPH9 prescrita" 

gen vp_xrp=1 if vp1==40 | vp2==40  | vp3==40 | vp4==40 | vp5==40
label var vp_xrp "Vacuna XRP prescrita" 

gen vp_xrpv=1 if vp1==41 | vp2==41  | vp3==41 | vp4==41 | vp5==41
label var vp_xrpv "Vacuna XRPV prescrita" 

gen igp_hb=1 if vp1==50 | vp2==50  | vp3==50 | vp4==50 | vp5==50
label var igp_hb "Ig. anti-HB prescrita"

gen igp_ra=1 if vp1==51 | vp2==51  | vp3==51 | vp4==51 | vp5==51
label var igp_ra "Ig. antiràbica prescrita"

gen igp_in=1 if vp1==52 | vp2==52  | vp3==52 | vp4==52 | vp5==52
label var igp_in "Ig. inespecífica prescrita"

gen igp_t=1 if vp1==53 | vp2==53  | vp3==53 | vp4==53 | vp5==53
label var igp_t "Ig. antitetànica prescrita"

gen vp_g60=1 if vp1==60 | vp2==60  | vp3==60 | vp4==60 | vp5==60
label var vp_g60 "Vacuna G prescrita: Afluria"

gen vp_g61=1 if vp1==61 | vp2==61  | vp3==61 | vp4==61 | vp5==61
label var vp_g61 "Vacuna G prescrita: Chiroflu"

gen vp_g62=1 if vp1==62 | vp2==62  | vp3==62 | vp4==62 | vp5==62
label var vp_g62 "Vacuna G prescrita: Chiromas"

gen vp_g63=1 if vp1==63 | vp2==63  | vp3==63 | vp4==63 | vp5==63
label var vp_g63 "Vacuna G prescrita: Fluarix Tetra"

gen vp_g64=1 if vp1==64 | vp2==64  | vp3==64 | vp4==64 | vp5==64
label var vp_g64 "Vacuna G prescrita: Intanza"

gen vp_gt=1 if vp_g60==1 | vp_g61==1 | vp_g62==1 | vp_g63==1 | vp_g64==1 
label var vp_gt "Vacuna G prescrita"

* Eliminamos registros que no nos interesan

tab dent

drop if dent > td("30sep2018")

* Guardamos los datos

save "Setembre2018", replace


clear
exit

