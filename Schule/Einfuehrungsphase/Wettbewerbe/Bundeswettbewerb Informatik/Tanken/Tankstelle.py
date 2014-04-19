import asso
import scholl
import random

asso = asso.Asso()
scholl = scholl.Scholl()

tage = 30
stunden = 24
autos_pro_stunde = 3600

print "Tage:", tage
print "Stunden pro  Tag:", stunden
print "Autos pro Stunde:", autos_pro_stunde
print ""

spotmarktpreis = 40

for tag in xrange(tage):
	tag += 1
	print ""
	print "Neuer Tag..."
	print "------------"
	print ""

	for stunde in xrange(stunden):
		stunde += 1
		kunden_pro_stunde = 0

		if stunde % 6 == 0:
			spotmarktpreis += (random.randint(1, 7) - 3) / 10.0

		print "Einkaufspreis:", spotmarktpreis
		asso.einkaufspreis = spotmarktpreis
		scholl.einkaufspreis = spotmarktpreis
		
		for auto in xrange(autos_pro_stunde):
			auto += 1
			# ist das Auto ein Kunde?
			if random.randint(1, 60) == 1:
				kunden_pro_stunde += 1
				# Ist es ein Stammkunde?
				if random.randint(1, 100) <= 40:
					# Bei Asso?
					if random.randint(0, 2) == 0:
						asso.tanken()
					# Bei Scholl?
					else:
						scholl.tanken()
					
				else:
					# Asso ist billiger?
					if asso.preis < scholl.preis:
						asso.tanken()
					# Scholl ist billiger?
					elif asso.preis > scholl.preis:
						scholl.tanken()
					# Gleich teuer. Fahrer entscheidet sich ohne weitere Absicht.
					else:
						# Bei Asso?
						if random.randint(0, 2) == 0:
							asso.tanken()
						# Bei Scholl?
						else:
							scholl.tanken()

		asso_anzahl_der_kunden_letzte_stunde = asso.anzahl_der_kunden_letzte_stunde
		scholl_anzahl_der_kunden_letzte_stunde = scholl.anzahl_der_kunden_letzte_stunde
						
		asso.naechste_stunde(stunde, tag)
		scholl.naechste_stunde(stunde, tag)
		print ""
		print "Kunden:\tAsso:", asso_anzahl_der_kunden_letzte_stunde , "\tScholl:", scholl_anzahl_der_kunden_letzte_stunde, "Gewinn:\tAsso:", asso.gewinn(stunde, tag), "\tScholl:", scholl.gewinn(stunde, tag), "\t\tPreis:\tAsso:", asso.preis, "\tScholl:", scholl.preis

gewinn_asso = 0
for geld in asso.gewinne.values():
	gewinn_asso += geld


print "Gewinn Asso insgesamt:", gewinn_asso

gewinn_scholl = 0
for geld in scholl.gewinne.values():
	gewinn_scholl += geld


print "Gewinn Scholl insgesamt:", gewinn_scholl

