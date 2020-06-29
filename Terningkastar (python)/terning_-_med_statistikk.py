# -*- coding: UTF-8 -*-
import random
import sys

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
		for i in xrange(antalkast):
#			print i
			dice(terningstorleik)
		totalsum = 0
		for i in xrange(len(array)):
			print "Verdi: " +str(i+1), "   Antal: " +str(array[i])
			totalsum += (i+1)*array[i]
		snitt = float(totalsum)/float(antalkast)
		
		ektesnitt = float(terningstorleik+1) / 2
		
		print "Totalsum: ", totalsum
		print "Gjennomsnitt: ", snitt
		print "Avvik frå 'ekte' snitt (absolutt): ", ektesnitt - snitt
		print "Avvik frå 'ekte' snitt (relativt): ", 100*abs((ektesnitt - snitt) / ektesnitt), "%"