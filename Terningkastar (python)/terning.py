#!/usr/bin/env python
# -*- coding: utf-8 -*-
import random, sys

# Programmet er laga av Mads Opheim. 

# Koss funkar det: python terning.py 4d3 (f.eks.)

# Lisensiert etter CC-BY-SA:
#
# Du har lov til:
# 	å dele - å kopiere, distribuere og spre verket
# 	å remikse - å bearbeide verket

# På følgende vilkår:

#	Navngivelse
#		Du skal navngi opphavspersonen og/eller lisensgiveren på den måte som disse angir (men ikke på en måte som indikerer at disse har godkjent eller anbefaler din bruk av verket). 

#	Del på samme vilkår. 
#		Om du endrer, bearbeider eller bygger videre på verket, kan du kun distribuere resultatet under samme, lignende eller en kompatibel lisens. 

#I forbindelse med all gjenbruk og spredning skal du gjøre lisensvilkårene for dette verket klart for andre.

#Alle disse vilkårene kan frafalles, dersom du får tillatelse fra rettighetshaveren.

#Ideelle rettigheter forblir uberørt av denne lisensen, i den utstrekning de i henhold til gjeldende rett anerkjennes og ikke er fraskrivbare.

# http://creativecommons.org/licenses/by-sa/3.0/no/


def dice(terningstorleik):
	kast = random.randint(1,terningstorleik)
	array[kast-1] += 1
tel = 0

if len(sys.argv) < 2:
	print "Skriv inn antal kast d auge."
else: 
	temp = sys.argv[1].split("d")
	while len(temp) > 2:
		if not len(temp) == 2:
			tel += 1
			temp.pop(1)
	if tel > 0:
		print "Du skreiv 'd'", tel, "gongar for mykje. Du kan berre kasta éin terning om gongen. Programmet skriv her ut resultatet ditt med det første talet som antal kast og det siste som antal auge."
	if not "d" in sys.argv[1]:
		if "hjelp" in sys.argv[1]:
			print "Køyr programmet med parameter antal ønska kast d antal auge på terningen du vil kaste. T.d. kan du skriva 2d4."
			exit(0)
		print "Du manglar d-en."
	else:
		try: 
			antalkast = int(temp[0])
			terningstorleik = int(temp[1])
		except:
			print "Her vart det visst noko feil. Pass på rekkjefølgja. Treng du hjelp, køyr programmet med parameter 'hjelp'."
			exit(0)
		array = [0] * terningstorleik
		if terningstorleik == 0:
			 print "Du kan ikkje kaste ein terning med 0 auge. Prøv igjen, du."
			 exit(0)
		for i in xrange(antalkast):
			dice(terningstorleik)
		if antalkast == 0:
			print "D'oh"
		for i in xrange(len(array)):
			if array[i] != 0:
				print "Verdi: " +str(i+1), "   Antal: " +str(array[i])