# Die Tankstelle Scholl
class Scholl:
	anzahl_der_kunden_letzte_stunde = 0
	preis = 100
	einkaufspreis = 50
	gewinne = {}

	def tanken(self):
		self.anzahl_der_kunden_letzte_stunde += 1
	
	def naechste_stunde(self, stunde, tag):
		self.gewinne[str(tag) + "_" + str(stunde)] = (self.preis - self.einkaufspreis) * self.anzahl_der_kunden_letzte_stunde

		self.preis = self.einkaufspreis + 5
		
		self.anzahl_der_kunden_letzte_stunde = 0

	def gewinn(self, stunde, tag):
		return self.gewinne[str(tag) + "_" + str(stunde)]

