# -*- coding: UTF-8 -*-
import random
import sys

def dice(terningstorleik):
	kast = random.randint(1,terningstorleik)
	array[kast-1] += 1

#input = raw_input("antalkast d auge? ")

#print sys
temp = sys.argv[0]

if temp[0] != int(temp[0]):
	print "antal kast er ikkje eit heiltal"
if temp[1] != int(temp[1]):
	print "antal auge på terningen er ikkje eit heiltal"
antalkast = int(temp[0])
terningstorleik = int(temp[1])
array = [0] * terningstorleik

for i in xrange(antalkast):
	dice(terningstorleik)
for i in xrange(len(array)):
	print "Verdi: " +str(i+1)\
	+ "   Antal: " +str(array[i])